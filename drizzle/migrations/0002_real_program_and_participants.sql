
delete from public.scores;
delete from public.games;
delete from public.activities;
delete from public.days;
delete from public.participants where user_id is null;
delete from public.teams;

insert into public.teams (name, emoji, color, motto, sort) values
  ('Équipe 1', '🦁', 'ochre', null, 1),
  ('Équipe 2', '🦒', 'acacia', null, 2),
  ('Équipe 3', '🦩', 'flamingo', null, 3),
  ('Équipe 4', '🐘', 'lagoon', null, 4);

insert into public.participants (display_name, emoji, team_id)
select p.name, p.emoji, t.id
from (values
  ('Baptiste','🦁',1),('Cécile','🦁',1),('Mathieu','🦁',1),('Estelle','🦁',1),('Elsa','🦁',1),('Mats','🦁',1),
  ('Mégane','🦒',2),('Othman','🦒',2),('Augustin','🦒',2),('Pauline','🦒',2),('Alexis','🦒',2),('Lina','🦒',2),
  ('Jeremy','🦩',3),('Justina','🦩',3),('Lucas','🦩',3),('Marie','🦩',3),('Marion','🦩',3),
  ('Lola','🐘',4),('Florian','🐘',4),('Paul','🐘',4),('Bastien','🐘',4),('Ludo','🐘',4),('Nao','🐘',4)
) as p(name, emoji, team_sort)
join public.teams t on t.sort = p.team_sort;

insert into public.days (day_number, date, title, location, region, summary, description, accommodation, lat, lng) values
  (1, '2026-12-30', 'Arrivée des copains', 'Nairobi', 'nairobi', 'Tout le monde atterrit et se retrouve à la maison.', 'Arrivées échelonnées en fin de journée et retrouvailles à la maison de Nairobi.', 'Maison Nairobi, 36 Riviera Cres', -1.2124, 36.8012),
  (2, '2026-12-31', 'Kick off & réveillon', 'Nairobi · Karunguru', 'nairobi', 'Lancement du voyage, plantation de café et soirée du réveillon.', 'Petit-déjeuner traiteur, kick off du voyage, déjeuner et visite de la plantation de café Karunguru Coffee Estate. Retour à la maison pour la soirée du 31 avec le concours coin coin.', 'Maison Nairobi, 36 Riviera Cres', -1.2124, 36.8012),
  (3, '2027-01-01', 'Bonne année & Ngong Hills', 'Nairobi · Ngong Hills', 'nairobi', 'Brunch, randonnée dans les Ngong Hills et resto.', 'Brunch traiteur pour bien commencer l''année, randonnée dans les Ngong Hills, dîner au restaurant puis soirée chill à la maison avec un quiz.', 'Maison Nairobi, 36 Riviera Cres', -1.2124, 36.8012),
  (4, '2027-01-02', 'Karura & musée national', 'Nairobi', 'nairobi', 'Forêt de Karura, pique-nique et Kenya National Museum.', 'Balade et pique-nique dans la forêt de Karura, visite du Kenya National Museum, puis soirée chill à la maison avec un Cache Cache Pastis.', 'Maison Nairobi, 36 Riviera Cres', -1.2124, 36.8012),
  (5, '2027-01-03', 'Cap sur le Masai Mara', 'Narok · Masai Mara', 'mara', 'Route vers le Mara, déjeuner à Narok et premier safari.', 'Départ après le petit-déjeuner, pause déjeuner à Narok, arrivée au Wild Nest Mara Camp et premier safari en fin d''après-midi.', 'Wild Nest Mara Camp', -1.4500, 35.1500),
  (6, '2027-01-04', 'Journée safari', 'Masai Mara', 'mara', 'Safari toute la journée et blind test au camp.', 'Grande journée de safari dans la réserve du Masai Mara. Dîner au camp et soirée chill avec un blind test.', 'Wild Nest Mara Camp', -1.4500, 35.1500),
  (7, '2027-01-05', 'Route vers Nyamira', 'Narok · Nyamira', 'nyamira', 'Trajet via Narok jusqu''aux collines de thé de Nyamira.', 'Départ tôt du camp, déjeuner à Narok puis route vers Nyamira. Courses, chill et soirée à l''hôtel.', 'Nyamira Hostel', -0.6518, 34.9342),
  (8, '2027-01-06', 'Thé, Cillah & théâtre', 'Nyamira', 'nyamira', 'Usine de thé, accueil chez Cillah, rando et challenge théâtre.', 'Visite d''une usine de thé, accueil et visite de la maison de Cillah avec déjeuner chez elle, randonnée, puis challenge théâtre avant la soirée à l''hôtel.', 'Nyamira Hostel', -0.6518, 34.9342),
  (9, '2027-01-07', 'Retour à Nairobi', 'Nyamira → Nairobi', 'nyamira', 'Dernière visite d''usine de thé et longue route du retour.', 'Visite matinale d''une usine de thé, route vers Nairobi avec pause déjeuner à Narok, dîner traiteur et soirée à la maison.', 'Maison Nairobi, 36 Riviera Cres', -1.2124, 36.8012),
  (10, '2027-01-08', 'Top Chef & perles Kazuri', 'Nairobi', 'nairobi', 'Top Chef à la maison, atelier bijoux Kazuri et rooftop.', 'Concours Top Chef à la maison, atelier de fabrication de bijoux chez Kazuri Beads, puis resto avec le « Top et Flop » du voyage et rooftop.', 'Maison Nairobi, 36 Riviera Cres', -1.2124, 36.8012),
  (11, '2027-01-09', 'La Fête', 'Nairobi', 'nairobi', 'La grande fête du voyage, toute la journée.', 'Petit-déjeuner traiteur puis grande fête jusqu''au bout de la nuit.', 'Maison Nairobi, 36 Riviera Cres', -1.2124, 36.8012),
  (12, '2027-01-10', 'Kwaheri Kenya', 'Nairobi', 'nairobi', 'Brunch, derniers souvenirs au Masai Market.', 'Brunch traiteur, puis derniers achats au Masai Market (à confirmer) avant le départ.', 'Maison Nairobi, 36 Riviera Cres', -1.2124, 36.8012);

insert into public.activities (day_id, start_time, title, description, place, category, lat, lng, sort)
select d.id, a.t, a.title, a.descr, a.place, a.cat, a.lat, a.lng, a.s
from (values
  (1, '18:00', 'Arrivée des copains', 'Arrivées échelonnées jusque tard dans la soirée.', 'Maison Nairobi', 'hebergement', -1.2124, 36.8012, 1),

  (2, '07:00', 'Petit-déjeuner', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 1),
  (2, '10:30', 'Kick off', 'Lancement officiel du voyage et présentation des équipes.', 'Maison Nairobi', 'jeu', null, null, 2),
  (2, '11:30', 'Trajet', '', '', 'transport', null, null, 3),
  (2, '12:30', 'Déjeuner à Karunguru', 'Repas sur le domaine de Karunguru Coffee Estate.', 'Karunguru Coffee Estate', 'repas', -1.0596, 36.9582, 4),
  (2, '14:00', 'Visite de la plantation de café', 'Du caféier à la tasse.', 'Karunguru Coffee Estate', 'visite', -1.0596, 36.9582, 5),
  (2, '16:45', 'Trajet vers la maison', '', '', 'transport', null, null, 6),
  (2, '17:00', 'Chill', 'Temps libre.', 'Maison Nairobi', 'detente', null, null, 7),
  (2, '19:00', 'Repas maison', 'Dîner du réveillon par le traiteur.', 'Maison Nairobi', 'repas', null, null, 8),
  (2, '20:45', 'Soirée maison + concours coin coin', 'Soirée du 31 décembre.', 'Maison Nairobi', 'jeu', null, null, 9),

  (3, '09:00', 'Brunch', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 1),
  (3, '11:30', 'Trajet', '', '', 'transport', null, null, 2),
  (3, '12:30', 'Rando Ngong Hills', 'Randonnée sur la crête des Ngong Hills.', 'Ngong Hills', 'visite', -1.3950, 36.6400, 3),
  (3, '16:45', 'Trajet vers le resto', '', '', 'transport', null, null, 4),
  (3, '17:00', 'Resto', 'Dîner au restaurant.', '', 'repas', null, null, 5),
  (3, '19:45', 'Trajet vers la maison', '', '', 'transport', null, null, 6),
  (3, '20:45', 'Soirée chill maison + quiz', '', 'Maison Nairobi', 'jeu', null, null, 7),

  (4, '07:00', 'Petit-déjeuner', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 1),
  (4, '09:30', 'Trajet', '', '', 'transport', null, null, 2),
  (4, '10:00', 'Karura Forest + pique-nique', 'Balade en forêt et pique-nique.', 'Karura Forest', 'visite', -1.2387, 36.8326, 3),
  (4, '13:45', 'Trajet', '', '', 'transport', null, null, 4),
  (4, '14:15', 'Kenya National Museum', 'Histoire, culture et nature du Kenya.', 'Nairobi National Museum', 'culture', -1.2739, 36.8150, 5),
  (4, '16:45', 'Trajet vers la maison', '', '', 'transport', null, null, 6),
  (4, '17:00', 'Chill', 'Temps libre.', 'Maison Nairobi', 'detente', null, null, 7),
  (4, '18:00', 'Repas maison', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 8),
  (4, '20:45', 'Soirée chill maison + Cache Cache Pastis', '', 'Maison Nairobi', 'jeu', null, null, 9),

  (5, '07:00', 'Petit-déjeuner', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 1),
  (5, '08:00', 'Trajet vers le Masai Mara', '', '', 'transport', null, null, 2),
  (5, '11:00', 'Déjeuner à Narok', '', 'Narok', 'repas', -1.0887, 35.8715, 3),
  (5, '12:00', 'Trajet vers le Masai Mara', '', '', 'transport', null, null, 4),
  (5, '15:00', 'Safari', 'Premier safari dans la réserve.', 'Réserve du Masai Mara', 'safari', -1.4900, 35.1400, 5),
  (5, '17:15', 'Repas au camp', '', 'Wild Nest Mara Camp', 'repas', null, null, 6),
  (5, '20:00', 'Soirée chill au camp', '', 'Wild Nest Mara Camp', 'detente', null, null, 7),

  (6, '06:45', 'Petit-déjeuner', '', 'Wild Nest Mara Camp', 'repas', null, null, 1),
  (6, '07:15', 'Safari', 'Safari toute la journée.', 'Réserve du Masai Mara', 'safari', -1.5200, 35.0500, 2),
  (6, '17:15', 'Repas au camp', '', 'Wild Nest Mara Camp', 'repas', null, null, 3),
  (6, '19:45', 'Soirée chill au camp + Blind Test', '', 'Wild Nest Mara Camp', 'jeu', null, null, 4),

  (7, '06:45', 'Petit-déjeuner', '', 'Wild Nest Mara Camp', 'repas', null, null, 1),
  (7, '07:15', 'Trajet vers Narok', '', '', 'transport', null, null, 2),
  (7, '11:00', 'Déjeuner à Narok', '', 'Narok', 'repas', -1.0887, 35.8715, 3),
  (7, '12:00', 'Trajet vers Nyamira', '', '', 'transport', null, null, 4),
  (7, '15:45', 'Courses + chill', '', 'Nyamira', 'detente', null, null, 5),
  (7, '16:45', 'Repas à l''hôtel', '', 'Nyamira Hostel', 'repas', null, null, 6),
  (7, '18:00', 'Soirée hôtel', '', 'Nyamira Hostel', 'detente', null, null, 7),

  (8, '07:00', 'Petit-déjeuner', '', 'Nyamira Hostel', 'repas', null, null, 1),
  (8, '09:00', 'Visite de l''usine de thé', '', 'Usine de thé, Nyamira', 'visite', -0.6465, 35.0534, 2),
  (8, '10:00', 'Accueil + visite de la maison de Cillah', '', 'Chez Cillah', 'culture', null, null, 3),
  (8, '11:00', 'Repas chez Cillah', '', 'Chez Cillah', 'repas', null, null, 4),
  (8, '12:00', 'Randonnée', '', 'Nyamira', 'visite', null, null, 5),
  (8, '15:45', 'Chill', '', 'Nyamira Hostel', 'detente', null, null, 6),
  (8, '16:45', 'Repas à l''hôtel', '', 'Nyamira Hostel', 'repas', null, null, 7),
  (8, '17:45', 'Challenge Théâtre', '', 'Nyamira Hostel', 'jeu', null, null, 8),
  (8, '19:00', 'Soirée hôtel', '', 'Nyamira Hostel', 'detente', null, null, 9),

  (9, '06:45', 'Petit-déjeuner', '', 'Nyamira Hostel', 'repas', null, null, 1),
  (9, '07:15', 'Trajet vers l''usine de thé', '', '', 'transport', null, null, 2),
  (9, '08:15', 'Visite de l''usine de thé', '', 'Usine de thé', 'visite', -0.6557, 34.8751, 3),
  (9, '09:15', 'Trajet vers Nairobi', '', '', 'transport', null, null, 4),
  (9, '12:00', 'Déjeuner à Narok', '', 'Narok', 'repas', -1.0887, 35.8715, 5),
  (9, '13:00', 'Trajet vers Nairobi', '', '', 'transport', null, null, 6),
  (9, '18:45', 'Repas maison', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 7),
  (9, '20:45', 'Soirée maison', '', 'Maison Nairobi', 'detente', null, null, 8),

  (10, '07:00', 'Petit-déjeuner', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 1),
  (10, '08:45', 'Trajet', '', '', 'transport', null, null, 2),
  (10, '09:30', 'Top Chef à la maison', 'Concours de cuisine par équipes.', 'Maison Nairobi', 'jeu', null, null, 3),
  (10, '12:00', 'Repas maison', '', 'Maison Nairobi', 'repas', null, null, 4),
  (10, '13:00', 'Trajet', '', '', 'transport', null, null, 5),
  (10, '14:00', 'Fabrication de bijoux – Kazuri Beads', 'Atelier de perles en céramique.', 'Kazuri Beads, Karen', 'culture', -1.3487, 36.7054, 6),
  (10, '16:00', 'Trajet vers le resto', '', '', 'transport', null, null, 7),
  (10, '17:15', 'Resto + Top et Flop → Rooftop', 'Le bilan du voyage, puis verre en rooftop.', '', 'repas', null, null, 8),
  (10, '20:45', 'Soirée maison', '', 'Maison Nairobi', 'detente', null, null, 9),

  (11, '07:30', 'Petit-déjeuner', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 1),
  (11, '09:30', 'Trajet', '', '', 'transport', null, null, 2),
  (11, '10:30', 'Fête', 'La grande fête du voyage !', '', 'culture', null, null, 3),

  (12, '09:00', 'Brunch', 'Servi par le traiteur.', 'Maison Nairobi', 'repas', null, null, 1),
  (12, '13:00', 'Trajet vers les activités', '', '', 'transport', null, null, 2),
  (12, '14:00', 'Masai Market ?', 'À confirmer.', 'Masai Market', 'culture', null, null, 3)
) as a(dn, t, title, descr, place, cat, lat, lng, s)
join public.days d on d.day_number = a.dn;

insert into public.games (name, emoji, description, rules, max_points, day_id, sort)
select g.name, g.emoji, g.descr, g.rules, g.maxp, d.id, g.s
from (values
  ('Concours coin coin', '🦆', 'Le grand concours de la soirée du réveillon.', 'Règles annoncées sur place par l''organisateur.', 20, 2, 1),
  ('Quiz', '📚', 'Quiz par équipes à la maison.', 'Règles annoncées sur place par l''organisateur.', 20, 3, 2),
  ('Cache Cache Pastis', '🙈', 'Le cache-cache version soirée.', 'Règles annoncées sur place par l''organisateur.', 20, 4, 3),
  ('Blind Test', '🎵', 'Blind test au camp du Masai Mara.', 'Règles annoncées sur place par l''organisateur.', 20, 6, 4),
  ('Challenge Théâtre', '🎭', 'Impro et saynètes par équipes.', 'Règles annoncées sur place par l''organisateur.', 20, 8, 5),
  ('Top Chef à la maison', '👩‍🍳', 'Concours de cuisine par équipes.', 'Règles annoncées sur place par l''organisateur.', 20, 10, 6)
) as g(name, emoji, descr, rules, maxp, dn, s)
join public.days d on d.day_number = g.dn;

-- Link a new account to the participant with the same first name
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
declare
  v_name text;
  v_match uuid;
begin
  v_name := coalesce(nullif(trim(new.raw_user_meta_data->>'display_name'), ''), split_part(coalesce(new.email, 'Voyageur'), '@', 1));
  select id into v_match from public.participants
    where user_id is null and lower(trim(display_name)) = lower(v_name)
    order by created_at limit 1;
  if v_match is not null then
    update public.participants set user_id = new.id where id = v_match;
  else
    insert into public.participants (user_id, display_name) values (new.id, v_name)
      on conflict (user_id) do nothing;
  end if;
  insert into public.user_roles (user_id, role) values (new.id, 'participant')
    on conflict do nothing;
  if not exists (select 1 from public.user_roles where role = 'admin') then
    insert into public.user_roles (user_id, role) values (new.id, 'admin');
  end if;
  return new;
end $$;
