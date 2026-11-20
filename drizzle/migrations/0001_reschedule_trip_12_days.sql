
update public.days set day_number = 12, date = '2027-01-10' where day_number = 9;
update public.days set day_number = 10, date = '2027-01-08', title = 'Récifs et singes colobes',
  summary = 'Snorkeling avec les dauphins et rencontre avec les colobes.',
  description = 'Journée en mer au parc marin de Kisite-Mpunguti avec dauphins et snorkeling, puis rencontre avec les singes colobes de la côte.'
  where day_number = 8;
update public.days set day_number = 9, date = '2027-01-07' where day_number = 7;
update public.days set day_number = 7, date = '2027-01-05' where day_number = 6;
update public.days set day_number = 6, date = '2027-01-04' where day_number = 5;
update public.days set date = '2027-01-02' where day_number = 4;
update public.days set date = '2027-01-01', summary = 'Bonne année ! Route panoramique et premier safari au coucher du soleil.' where day_number = 3;
update public.days set date = '2026-12-31', title = 'Nairobi sauvage & réveillon', summary = 'Safari aux portes de la ville, éléphanteaux orphelins et réveillon.',
  description = 'Safari matinal dans le parc national de Nairobi, avec les gratte-ciel en toile de fond. Visite de l''orphelinat des éléphants, puis grande soirée du réveillon pour fêter 2027 ensemble !'
  where day_number = 2;
update public.days set date = '2026-12-30' where day_number = 1;

insert into public.days (day_number, date, title, location, region, summary, description, accommodation, lat, lng) values
  (5, '2027-01-03', 'La Mara au petit matin', 'Masai Mara', 'mara', 'Montgolfière en option, safari à pied et feu de camp.', 'Pour les courageux : survol de la savane en montgolfière au lever du soleil. Puis safari à pied avec un guide maasaï et soirée contes autour du feu.', 'Camp de toile, Masai Mara', -1.4300, 35.0800),
  (8, '2027-01-06', 'Flamants du lac Nakuru', 'Lac Nakuru', 'naivasha', 'Flamants roses, rhinocéros et belvédère du Baboon Cliff.', 'Excursion au parc national du lac Nakuru, célèbre pour ses flamants roses et ses rhinocéros blancs. Pique-nique au Baboon Cliff avec vue sur tout le lac.', 'Lodge au bord du lac Naivasha', -0.3667, 36.0833),
  (11, '2027-01-09', 'Grande finale à Diani', 'Diani Beach', 'diani', 'Journée libre, beach-volley et remise des trophées.', 'Matinée libre : kitesurf, plage ou sieste. Le soir, la grande finale des jeux et la remise des trophées de Karibu Kenya !', 'Villa à Diani Beach', -4.3100, 39.5800);

update public.activities set day_id = (select id from public.days where day_number = 11), start_time = '19:00'
  where title = 'Grande finale et trophées';
update public.games set day_id = (select id from public.days where day_number = 11) where name = 'Beach-volley final';

insert into public.activities (day_id, start_time, title, description, place, category, lat, lng, sort) values
  ((select id from public.days where day_number = 2), '21:00', 'Réveillon du Nouvel An', 'Dîner de fête, musique et compte à rebours vers 2027.', 'Hôtel à Karen', 'repas', -1.3192, 36.7100, 5),
  ((select id from public.days where day_number = 5), '05:30', 'Montgolfière (option)', 'Lever de soleil au-dessus de la savane, petit-déjeuner dans la brousse.', 'Réserve du Masai Mara', 'safari', -1.4200, 35.0600, 1),
  ((select id from public.days where day_number = 5), '10:00', 'Safari à pied', 'Traces, plantes et petits animaux avec un guide maasaï.', 'Abords du camp', 'safari', -1.4100, 35.0200, 2),
  ((select id from public.days where day_number = 5), '20:00', 'Feu de camp', 'Contes, étoiles et chamallows.', 'Camp, Masai Mara', 'culture', -1.4061, 35.0100, 3),
  ((select id from public.days where day_number = 8), '07:00', 'Parc du lac Nakuru', 'Flamants roses, rhinocéros blancs et lions arboricoles.', 'Parc national du lac Nakuru', 'safari', -0.3667, 36.0833, 1),
  ((select id from public.days where day_number = 8), '12:30', 'Pique-nique au Baboon Cliff', 'Vue panoramique sur le lac.', 'Baboon Cliff', 'repas', -0.3833, 36.0667, 2),
  ((select id from public.days where day_number = 11), '09:00', 'Matinée libre', 'Kitesurf, plage ou sieste au bord de la piscine.', 'Diani Beach', 'detente', -4.3170, 39.5810, 1);
