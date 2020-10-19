\connect baltimore_street_art
INSERT INTO public.person (first_name,middle_name,last_name,email,image_url,birth_date,death_date,username,bio,website,updated,updated_by) VALUES
	 ('Shane',NULL,'Knudsen','shaneknu@gmail.com',NULL,NULL,NULL,'circleofconfusion',NULL,NULL,'2020-10-10 15:46:56.980133',1),
	 ('Some',NULL,'Dude','some@dude.com',NULL,NULL,NULL,'somedude',NULL,NULL,'2020-10-10 15:47:43.018757',1),
	 ('Another',NULL,'Artist','another@dude.com',NULL,NULL,NULL,'anotherdude',NULL,NULL,'2020-10-10 15:48:01.69407',1);
INSERT INTO public.artwork (title,description,"statement","location",installation_date,updated,updated_by) VALUES
	 ('Artwork 1','work by some dude','its alright','SRID=4326;POINT (-76.61789 39.32645)'::geometry,NULL,'2020-10-10 15:53:00.24239',1),
	 ('Anonymous Artwork','work by unknown person',NULL,'SRID=4326;POINT (-76.61589 39.31234)'::geometry,NULL,'2020-10-10 21:38:26.172267',1),
	 ('Male/Female','Controversial statue in front of Penn Station.', NULL, 'SRID=4326;POINT(-76.6157214 39.3070056)'::geometry,NULL,'2020-10-11 20:00:00.000000',1);
INSERT INTO public.artist_artwork (artist_id,artwork_id) VALUES
	 (2,2);
INSERT INTO public.artwork_star (person_id,artwork_id,"timestamp") VALUES
	 (1,2,'2020-10-10 22:52:33.488501');
INSERT INTO artwork_article (artwork_id,article_url,article_title,updated_by)
	values (3,'https://www.baltimoresun.com/news/bs-xpm-2001-11-14-0111140274-story.html','Female, male, monumental', 1);
INSERT INTO artwork_image (artwork_id, image_url,uploaded_by) VALUES (3,'https://upload.wikimedia.org/wikipedia/en/d/db/BAL_Penn_station.png',1);