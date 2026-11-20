
create type public.app_role as enum ('admin', 'participant');

create table public.user_roles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  role public.app_role not null,
  unique (user_id, role)
);
grant select on public.user_roles to authenticated;
grant all on public.user_roles to service_role;
alter table public.user_roles enable row level security;

create or replace function public.has_role(_user_id uuid, _role public.app_role)
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.user_roles where user_id = _user_id and role = _role)
$$;

create policy "Read own roles or admin reads all" on public.user_roles
  for select to authenticated
  using (user_id = auth.uid() or public.has_role(auth.uid(), 'admin'));

-- Teams
create table public.teams (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  emoji text not null default '🦁',
  color text not null default 'ochre',
  motto text,
  sort int not null default 0,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.teams to authenticated;
grant all on public.teams to service_role;
alter table public.teams enable row level security;
create policy "Members read teams" on public.teams for select to authenticated using (true);
create policy "Admin inserts teams" on public.teams for insert to authenticated with check (public.has_role(auth.uid(), 'admin'));
create policy "Admin updates teams" on public.teams for update to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admin deletes teams" on public.teams for delete to authenticated using (public.has_role(auth.uid(), 'admin'));

-- Participants (profiles)
create table public.participants (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique,
  display_name text not null,
  emoji text not null default '🙂',
  bio text,
  team_id uuid references public.teams(id) on delete set null,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.participants to authenticated;
grant all on public.participants to service_role;
alter table public.participants enable row level security;
create policy "Members read participants" on public.participants for select to authenticated using (true);
create policy "Admin inserts participants" on public.participants for insert to authenticated with check (public.has_role(auth.uid(), 'admin'));
create policy "Own or admin updates participant" on public.participants for update to authenticated
  using (user_id = auth.uid() or public.has_role(auth.uid(), 'admin'))
  with check (user_id = auth.uid() or public.has_role(auth.uid(), 'admin'));
create policy "Admin deletes participants" on public.participants for delete to authenticated using (public.has_role(auth.uid(), 'admin'));

create or replace function public.guard_participant_update()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if auth.uid() is not null and not public.has_role(auth.uid(), 'admin') then
    if new.team_id is distinct from old.team_id or new.user_id is distinct from old.user_id then
      raise exception 'Seul l''administrateur peut changer les équipes';
    end if;
  end if;
  return new;
end $$;
create trigger participants_guard before update on public.participants
  for each row execute function public.guard_participant_update();

-- Days
create table public.days (
  id uuid primary key default gen_random_uuid(),
  day_number int not null,
  date date,
  title text not null,
  location text not null default '',
  region text not null default 'savane',
  summary text not null default '',
  description text not null default '',
  accommodation text,
  lat double precision,
  lng double precision,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.days to authenticated;
grant all on public.days to service_role;
alter table public.days enable row level security;
create policy "Members read days" on public.days for select to authenticated using (true);
create policy "Admin inserts days" on public.days for insert to authenticated with check (public.has_role(auth.uid(), 'admin'));
create policy "Admin updates days" on public.days for update to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admin deletes days" on public.days for delete to authenticated using (public.has_role(auth.uid(), 'admin'));

-- Activities
create table public.activities (
  id uuid primary key default gen_random_uuid(),
  day_id uuid not null references public.days(id) on delete cascade,
  start_time text not null default '',
  title text not null,
  description text not null default '',
  place text not null default '',
  category text not null default 'visite',
  lat double precision,
  lng double precision,
  sort int not null default 0,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.activities to authenticated;
grant all on public.activities to service_role;
alter table public.activities enable row level security;
create policy "Members read activities" on public.activities for select to authenticated using (true);
create policy "Admin inserts activities" on public.activities for insert to authenticated with check (public.has_role(auth.uid(), 'admin'));
create policy "Admin updates activities" on public.activities for update to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admin deletes activities" on public.activities for delete to authenticated using (public.has_role(auth.uid(), 'admin'));

-- Practical info
create table public.practical_info (
  id uuid primary key default gen_random_uuid(),
  category text not null,
  title text not null,
  content text not null,
  emoji text not null default '📌',
  sort int not null default 0,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.practical_info to authenticated;
grant all on public.practical_info to service_role;
alter table public.practical_info enable row level security;
create policy "Members read infos" on public.practical_info for select to authenticated using (true);
create policy "Admin inserts infos" on public.practical_info for insert to authenticated with check (public.has_role(auth.uid(), 'admin'));
create policy "Admin updates infos" on public.practical_info for update to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admin deletes infos" on public.practical_info for delete to authenticated using (public.has_role(auth.uid(), 'admin'));

-- Games
create table public.games (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  emoji text not null default '🎲',
  description text not null default '',
  rules text not null default '',
  max_points int not null default 10,
  day_id uuid references public.days(id) on delete set null,
  sort int not null default 0,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.games to authenticated;
grant all on public.games to service_role;
alter table public.games enable row level security;
create policy "Members read games" on public.games for select to authenticated using (true);
create policy "Admin inserts games" on public.games for insert to authenticated with check (public.has_role(auth.uid(), 'admin'));
create policy "Admin updates games" on public.games for update to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admin deletes games" on public.games for delete to authenticated using (public.has_role(auth.uid(), 'admin'));

-- Scores
create table public.scores (
  id uuid primary key default gen_random_uuid(),
  game_id uuid not null references public.games(id) on delete cascade,
  team_id uuid not null references public.teams(id) on delete cascade,
  points int not null check (points >= 0 and points <= 1000),
  comment text,
  status text not null default 'pending' check (status in ('pending', 'validated', 'rejected')),
  submitted_by uuid default auth.uid(),
  reviewed_by uuid,
  reviewed_at timestamptz,
  created_at timestamptz not null default now()
);
grant select, insert, update, delete on public.scores to authenticated;
grant all on public.scores to service_role;
alter table public.scores enable row level security;
create policy "Members read scores" on public.scores for select to authenticated using (true);
create policy "Members propose pending scores" on public.scores for insert to authenticated
  with check (submitted_by = auth.uid() and status = 'pending' and reviewed_by is null);
create policy "Admin reviews scores" on public.scores for update to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admin deletes scores" on public.scores for delete to authenticated using (public.has_role(auth.uid(), 'admin'));

-- Signup: participant row + roles (first account becomes admin)
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
declare v_name text;
begin
  v_name := coalesce(nullif(trim(new.raw_user_meta_data->>'display_name'), ''), split_part(coalesce(new.email, 'Voyageur'), '@', 1));
  insert into public.participants (user_id, display_name) values (new.id, v_name)
    on conflict (user_id) do nothing;
  insert into public.user_roles (user_id, role) values (new.id, 'participant')
    on conflict do nothing;
  if not exists (select 1 from public.user_roles where role = 'admin') then
    insert into public.user_roles (user_id, role) values (new.id, 'admin');
  end if;
  return new;
end $$;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();

-- ===== Seed data =====
insert into public.teams (name, emoji, color, motto, sort) values
  ('Les Lions de la Mara', '🦁', 'ochre', 'Rugir d''abord, réfléchir ensuite', 1),
  ('Les Girafes Rebelles', '🦒', 'acacia', 'On voit tout de plus haut', 2),
  ('Les Flamants Roses', '🦩', 'flamingo', 'Élégance, même sur une patte', 3),
  ('Les Éléphants Joyeux', '🐘', 'lagoon', 'Lents mais jamais oubliés', 4);

insert into public.participants (display_name, emoji, bio, team_id) values
  ('Camille', '😎', 'Organisatrice en chef, fan de couchers de soleil', (select id from public.teams where sort = 1)),
  ('Yanis', '📸', 'Photographe officiel du groupe', (select id from public.teams where sort = 1)),
  ('Léa', '🌿', 'Connaît le nom de chaque oiseau', (select id from public.teams where sort = 1)),
  ('Hugo', '🚴', 'Toujours partant pour une rando', (select id from public.teams where sort = 2)),
  ('Inès', '🎶', 'DJ des trajets en 4x4', (select id from public.teams where sort = 2)),
  ('Malik', '🍽️', 'Testeur officiel de nyama choma', (select id from public.teams where sort = 2)),
  ('Sarah', '🏐', 'Reine du beach-volley', (select id from public.teams where sort = 3)),
  ('Théo', '🧭', 'Ne se perd jamais (sauf parfois)', (select id from public.teams where sort = 3)),
  ('Nora', '📚', 'Apprend le swahili depuis 3 mois', (select id from public.teams where sort = 3)),
  ('Antoine', '🤿', 'Plongeur du dimanche', (select id from public.teams where sort = 4)),
  ('Jade', '🌅', 'Se lève à 5 h pour les safaris, sans râler', (select id from public.teams where sort = 4)),
  ('Karim', '😂', 'Responsable de l''ambiance', (select id from public.teams where sort = 4));

insert into public.days (day_number, date, title, location, region, summary, description, accommodation, lat, lng) values
  (1, '2027-02-06', 'Karibu Nairobi !', 'Nairobi', 'nairobi', 'Arrivée, girafes et premier dîner kényan.', 'Atterrissage à Nairobi, installation à l''hôtel puis première rencontre avec les girafes de Rothschild au Giraffe Centre. Le soir, dîner de bienvenue autour des grillades.', 'Hôtel à Karen, Nairobi', -1.2921, 36.8219),
  (2, '2027-02-07', 'Nairobi sauvage', 'Nairobi', 'nairobi', 'Safari aux portes de la ville et éléphanteaux orphelins.', 'Safari matinal dans le parc national de Nairobi, avec les gratte-ciel en toile de fond. Visite de l''orphelinat des éléphants puis de la maison de Karen Blixen.', 'Hôtel à Karen, Nairobi', -1.3733, 36.8589),
  (3, '2027-02-08', 'Cap sur le Masai Mara', 'Vallée du Rift → Masai Mara', 'mara', 'Route panoramique et premier safari au coucher du soleil.', 'Départ tôt en 4x4. Arrêt photo au belvédère de la vallée du Rift, puis traversée des plaines jusqu''au Masai Mara. Installation au camp et premier safari en fin de journée.', 'Camp de toile, Masai Mara', -1.4061, 35.0100),
  (4, '2027-02-09', 'Journée Big Five', 'Masai Mara', 'mara', 'Safari complet, rivière Mara et village maasaï.', 'Grande journée de safari avec pique-nique dans la savane. Direction la rivière Mara pour les hippopotames et crocodiles, puis rencontre avec une communauté maasaï.', 'Camp de toile, Masai Mara', -1.4986, 35.0444),
  (5, '2027-02-10', 'Lac Naivasha', 'Naivasha', 'naivasha', 'Bateau parmi les hippos et balade à pied sur Crescent Island.', 'Route vers le lac Naivasha. Balade en bateau au milieu des hippopotames et des pygargues, puis safari à pied sur Crescent Island parmi zèbres et girafes.', 'Lodge au bord du lac Naivasha', -0.7667, 36.4167),
  (6, '2027-02-11', 'Hell''s Gate à vélo', 'Naivasha', 'naivasha', 'Vélo dans les gorges et bain géothermal.', 'Le seul parc où l''on pédale entre les zèbres ! Descente dans les gorges de Hell''s Gate puis détente dans les eaux chaudes du spa géothermal.', 'Lodge au bord du lac Naivasha', -0.9033, 36.3286),
  (7, '2027-02-12', 'Bonjour l''océan Indien', 'Diani Beach', 'diani', 'Vol vers la côte, plage et dhow au coucher du soleil.', 'Vol intérieur vers la côte. Après-midi farniente sur le sable blanc de Diani, puis sortie en dhow traditionnel au coucher du soleil.', 'Villa à Diani Beach', -4.3170, 39.5810),
  (8, '2027-02-13', 'Récifs et grande finale', 'Diani Beach', 'diani', 'Snorkeling, singes colobes et soirée de remise des prix.', 'Journée en mer au parc marin de Kisite-Mpunguti avec dauphins et snorkeling. Le soir : grande finale des jeux et remise des trophées !', 'Villa à Diani Beach', -4.7167, 39.3667),
  (9, '2027-02-14', 'Kwaheri Kenya', 'Mombasa', 'diani', 'Derniers achats et vol retour.', 'Matinée libre, derniers souvenirs puis transfert vers l''aéroport de Mombasa. Asante sana Kenya !', null, -4.0348, 39.5944);

insert into public.activities (day_id, start_time, title, description, place, category, lat, lng, sort) values
  ((select id from public.days where day_number = 1), '07:30', 'Arrivée à l''aéroport', 'Accueil par notre chauffeur et transfert à l''hôtel.', 'Aéroport Jomo Kenyatta', 'transport', -1.3192, 36.9278, 1),
  ((select id from public.days where day_number = 1), '14:00', 'Giraffe Centre', 'Nourrir les girafes de Rothschild depuis la plateforme.', 'Giraffe Centre, Langata', 'animaux', -1.3762, 36.7445, 2),
  ((select id from public.days where day_number = 1), '19:30', 'Dîner de bienvenue', 'Grillades à volonté et premier toast du voyage.', 'Restaurant Carnivore', 'repas', -1.3283, 36.8061, 3),
  ((select id from public.days where day_number = 2), '06:30', 'Safari au parc de Nairobi', 'Lions, rhinos et buffles avec la ville en arrière-plan.', 'Parc national de Nairobi', 'safari', -1.3733, 36.8589, 1),
  ((select id from public.days where day_number = 2), '11:00', 'Orphelinat des éléphants', 'L''heure du biberon des éléphanteaux.', 'Sheldrick Wildlife Trust', 'animaux', -1.3767, 36.7744, 2),
  ((select id from public.days where day_number = 2), '15:00', 'Maison de Karen Blixen', 'La maison de « Out of Africa » et ses jardins.', 'Karen Blixen Museum', 'visite', -1.3503, 36.7124, 3),
  ((select id from public.days where day_number = 2), '20:00', 'Quiz swahili', 'Premier jeu par équipes à l''hôtel.', 'Hôtel', 'jeu', null, null, 4),
  ((select id from public.days where day_number = 3), '09:00', 'Belvédère de la vallée du Rift', 'Vue spectaculaire sur la grande faille.', 'Rift Valley Viewpoint', 'visite', -0.9667, 36.5833, 1),
  ((select id from public.days where day_number = 3), '15:00', 'Installation au camp', 'Tentes avec vue sur la savane.', 'Camp, Masai Mara', 'hebergement', -1.4061, 35.0100, 2),
  ((select id from public.days where day_number = 3), '16:30', 'Safari au coucher du soleil', 'Premier game drive dans la réserve.', 'Réserve du Masai Mara', 'safari', -1.4500, 35.1000, 3),
  ((select id from public.days where day_number = 4), '06:00', 'Safari journée complète', 'À la recherche des Big Five, pique-nique dans la savane.', 'Réserve du Masai Mara', 'safari', -1.4900, 35.1400, 1),
  ((select id from public.days where day_number = 4), '11:30', 'Rivière Mara', 'Hippopotames et crocodiles du Nil.', 'Rivière Mara', 'animaux', -1.4986, 35.0444, 2),
  ((select id from public.days where day_number = 4), '16:00', 'Village maasaï', 'Danses, chants et concours de saut.', 'Village maasaï', 'culture', -1.3800, 35.1000, 3),
  ((select id from public.days where day_number = 5), '14:00', 'Bateau sur le lac', 'Hippos, pélicans et pygargues vocifères.', 'Lac Naivasha', 'animaux', -0.7667, 36.4167, 1),
  ((select id from public.days where day_number = 5), '16:00', 'Safari à pied', 'Marcher parmi zèbres, gnous et girafes.', 'Crescent Island', 'safari', -0.7569, 36.4103, 2),
  ((select id from public.days where day_number = 6), '08:00', 'Vélo à Hell''s Gate', 'Course des équipes entre falaises et zèbres.', 'Parc national de Hell''s Gate', 'jeu', -0.9033, 36.3286, 1),
  ((select id from public.days where day_number = 6), '15:00', 'Spa géothermal', 'Bain chaud face aux collines.', 'Olkaria Geothermal Spa', 'detente', -0.8836, 36.2950, 2),
  ((select id from public.days where day_number = 7), '10:00', 'Vol vers la côte', 'Vol intérieur jusqu''à Ukunda.', 'Aérodrome d''Ukunda', 'transport', -4.2967, 39.5711, 1),
  ((select id from public.days where day_number = 7), '14:00', 'Plage de Diani', 'Sable blanc et concours de château de sable.', 'Diani Beach', 'detente', -4.3170, 39.5810, 2),
  ((select id from public.days where day_number = 7), '17:30', 'Dhow au coucher du soleil', 'Navigation sur un voilier traditionnel.', 'Diani Beach', 'culture', -4.3300, 39.5850, 3),
  ((select id from public.days where day_number = 8), '08:00', 'Snorkeling à Kisite', 'Dauphins, tortues et poissons du récif.', 'Parc marin de Kisite-Mpunguti', 'detente', -4.7167, 39.3667, 1),
  ((select id from public.days where day_number = 8), '16:00', 'Singes colobes', 'Rencontre avec les primates de la côte.', 'Colobus Conservation', 'animaux', -4.2850, 39.5900, 2),
  ((select id from public.days where day_number = 8), '20:00', 'Grande finale et trophées', 'Beach-volley nocturne puis remise des prix.', 'Villa, Diani', 'jeu', -4.3100, 39.5800, 3),
  ((select id from public.days where day_number = 9), '13:00', 'Transfert à l''aéroport', 'Vol retour depuis Mombasa.', 'Aéroport de Mombasa', 'transport', -4.0348, 39.5944, 1);

insert into public.games (name, emoji, description, rules, max_points, day_id, sort) values
  ('Quiz swahili', '📚', 'Testez votre swahili de voyage.', '20 questions, 1 point par bonne réponse. Les équipes répondent sur ardoise.', 20, (select id from public.days where day_number = 2), 1),
  ('Défi photo safari', '📸', 'La plus belle photo de la journée.', 'Chaque équipe soumet 1 photo. Vote du groupe : 10 points pour la gagnante, 6 pour la 2e, 3 pour la 3e.', 10, (select id from public.days where day_number = 3), 2),
  ('Bingo Big Five', '🐆', 'Repérez lion, léopard, éléphant, buffle et rhinocéros.', '2 points par animal du Big Five vu en premier par l''équipe, bonus de 5 points pour un carton complet.', 15, (select id from public.days where day_number = 4), 3),
  ('Saut maasaï', '🦘', 'Le concours de saut adumu avec nos hôtes.', 'Le meilleur sauteur de chaque équipe : 10 pts au 1er, 7 au 2e, 4 au 3e, 2 au 4e.', 10, (select id from public.days where day_number = 4), 4),
  ('Course de Hell''s Gate', '🚴', 'Course à vélo par équipes dans le parc.', 'Le temps du dernier membre arrivé compte. 15 pts au 1er, 10 au 2e, 6 au 3e, 3 au 4e.', 15, (select id from public.days where day_number = 6), 5),
  ('Château de sable', '🏰', 'Construction libre en 45 minutes.', 'Jury d''habitants de la plage ! Note sur 10.', 10, (select id from public.days where day_number = 7), 6),
  ('Beach-volley final', '🏐', 'Tournoi nocturne pour la grande finale.', 'Matchs en 15 points. 20 pts au vainqueur, 12 au finaliste, 6 aux autres.', 20, (select id from public.days where day_number = 8), 7);

insert into public.practical_info (category, title, content, emoji, sort) values
  ('Formalités', 'Autorisation de voyage (eTA)', 'Chaque voyageur doit demander son autorisation électronique de voyage en ligne avant le départ. Faites-la au moins 2 semaines avant et gardez une copie sur votre téléphone. Passeport valable 6 mois après le retour.', '🛂', 1),
  ('Santé', 'Vaccins et paludisme', 'Consultez votre médecin ou un centre de vaccinations internationales 6 semaines avant le départ (fièvre jaune, traitement antipaludique). Pensez au répulsif et à une petite trousse de pharmacie.', '💉', 2),
  ('Argent', 'Shilling kényan (KES)', 'La carte bancaire passe dans les lodges et hôtels. Prévoyez du liquide pour les pourboires et les marchés. Au Kenya, tout le monde paie avec M-Pesa sur son téléphone.', '💵', 3),
  ('Pratique', 'Prises électriques', 'Prises de type G (comme au Royaume-Uni), 240 V. Apportez un adaptateur — et une multiprise pour le groupe !', '🔌', 4),
  ('Pratique', 'Décalage horaire', 'Le Kenya est à UTC+3 : 2 heures de plus qu''en France en hiver.', '🕒', 5),
  ('Valise', 'Que mettre dans son sac ?', 'Vêtements aux couleurs neutres (beige, kaki) pour les safaris, évitez le bleu foncé et le noir qui attirent les mouches tsé-tsé. Une polaire pour les matins frais, lampe frontale, jumelles, maillot, crème solaire. Les sacs plastiques sont interdits au Kenya.', '🎒', 6),
  ('Culture', 'Quelques mots de swahili', 'Jambo = Bonjour · Karibu = Bienvenue · Asante (sana) = Merci (beaucoup) · Pole pole = Doucement · Hakuna matata = Pas de souci · Kwaheri = Au revoir', '🗣️', 7),
  ('Culture', 'Bons usages', 'Demandez toujours avant de photographier quelqu''un. Restez dans le véhicule pendant les safaris et suivez les consignes du guide.', '🤝', 8),
  ('Urgences', 'Numéros utiles', 'Urgences : 999 ou 112. Ambassade de France à Nairobi : numéro à ajouter. Notre guide : numéro à ajouter.', '🚑', 9);

insert into public.scores (game_id, team_id, points, comment, status, reviewed_at) values
  ((select id from public.games where sort = 1), (select id from public.teams where sort = 1), 14, 'Exemple', 'validated', now()),
  ((select id from public.games where sort = 1), (select id from public.teams where sort = 2), 11, 'Exemple', 'validated', now()),
  ((select id from public.games where sort = 1), (select id from public.teams where sort = 3), 17, 'Exemple', 'validated', now()),
  ((select id from public.games where sort = 1), (select id from public.teams where sort = 4), 9, 'Exemple', 'validated', now()),
  ((select id from public.games where sort = 2), (select id from public.teams where sort = 2), 10, 'Exemple', 'validated', now()),
  ((select id from public.games where sort = 2), (select id from public.teams where sort = 4), 6, 'Exemple', 'validated', now()),
  ((select id from public.games where sort = 2), (select id from public.teams where sort = 1), 3, 'Exemple', 'pending', null);
