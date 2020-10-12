-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: Shane Knudsen


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: baltimore_street_art | type: DATABASE --
DROP DATABASE IF EXISTS baltimore_street_art;
CREATE DATABASE baltimore_street_art;
\connect baltimore_street_art
-- -- ddl-end --
-- 

-- object: public.person | type: TABLE --
-- DROP TABLE IF EXISTS public.person CASCADE;
CREATE TABLE public.person (
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	first_name varchar(64),
	middle_name varchar(128),
	last_name varchar(64),
	email varchar(128),
	image_url varchar(512),
	birth_date date,
	death_date date,
	username varchar(32),
	bio text,
	website varchar(512),
	updated timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_by integer,
	CONSTRAINT person_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.person OWNER TO postgres;
-- ddl-end --

-- object: public.following | type: TABLE --
-- DROP TABLE IF EXISTS public.following CASCADE;
CREATE TABLE public.following (
	"followerId" integer NOT NULL,
	"followingId" integer NOT NULL,
	CONSTRAINT following_pk PRIMARY KEY ("followerId","followingId")

);
-- ddl-end --
-- ALTER TABLE public.following OWNER TO postgres;
-- ddl-end --

-- object: postgis | type: EXTENSION --
-- DROP EXTENSION IF EXISTS postgis CASCADE;
CREATE EXTENSION postgis
;
-- ddl-end --

-- object: public.artwork_star | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork_star CASCADE;
CREATE TABLE public.artwork_star (
	person_id integer NOT NULL,
	artwork_id integer NOT NULL,
	"timestamp" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT artwork_star_pk PRIMARY KEY (person_id,artwork_id)

);
-- ddl-end --
-- ALTER TABLE public.artwork_star OWNER TO postgres;
-- ddl-end --

-- object: public.flag_type | type: TYPE --
-- DROP TYPE IF EXISTS public.flag_type CASCADE;
CREATE TYPE public.flag_type AS
 ENUM ('new','offensive','off_topic','incorrect','spam','not_public','dead_link','removed');
-- ddl-end --
-- ALTER TYPE public.flag_type OWNER TO postgres;
-- ddl-end --

-- object: public.artwork_image | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork_image CASCADE;
CREATE TABLE public.artwork_image (
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	artwork_id integer NOT NULL,
	image_url varchar(512),
	"timestamp" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	uploaded_by integer NOT NULL,
	CONSTRAINT artwork_image_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.artwork_image IS E'Images associated with artwork';
-- ddl-end --
-- ALTER TABLE public.artwork_image OWNER TO postgres;
-- ddl-end --

-- object: public.tour | type: TABLE --
-- DROP TABLE IF EXISTS public.tour CASCADE;
CREATE TABLE public.tour (
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	title varchar(128) NOT NULL,
	description text,
	"createdById" integer NOT NULL,
	updated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"updatedBy" integer NOT NULL,
	CONSTRAINT tour_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN public.tour.title IS E'Title of the tour';
-- ddl-end --
-- ALTER TABLE public.tour OWNER TO postgres;
-- ddl-end --

-- object: public.tour_artwork | type: TABLE --
-- DROP TABLE IF EXISTS public.tour_artwork CASCADE;
CREATE TABLE public.tour_artwork (
	"tourId" integer NOT NULL,
	"artworkId" integer NOT NULL,
	"order" integer,
	CONSTRAINT tour_artwork_pk PRIMARY KEY ("tourId","artworkId")

);
-- ddl-end --
-- ALTER TABLE public.tour_artwork OWNER TO postgres;
-- ddl-end --

-- object: public.artist_artwork | type: TABLE --
-- DROP TABLE IF EXISTS public.artist_artwork CASCADE;
CREATE TABLE public.artist_artwork (
	artist_id integer NOT NULL,
	artwork_id integer NOT NULL,
	CONSTRAINT artist_artwork_pk PRIMARY KEY (artist_id,artwork_id)

);
-- ddl-end --
-- ALTER TABLE public.artist_artwork OWNER TO postgres;
-- ddl-end --

-- object: public.artwork_article | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork_article CASCADE;
CREATE TABLE public.artwork_article (
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	artwork_id integer NOT NULL,
	article_url varchar(512),
	article_title varchar(256),
	"timestamp" timestamp DEFAULT CURRENT_TIMESTAMP,
	updated_by integer NOT NULL,
	CONSTRAINT artwork_article_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.artwork_article OWNER TO postgres;
-- ddl-end --

-- object: public.tag | type: TABLE --
-- DROP TABLE IF EXISTS public.tag CASCADE;
CREATE TABLE public.tag (
	tag varchar(64) NOT NULL,
	CONSTRAINT tag_pk PRIMARY KEY (tag)

);
-- ddl-end --
-- ALTER TABLE public.tag OWNER TO postgres;
-- ddl-end --

-- object: public.artwork_tag | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork_tag CASCADE;
CREATE TABLE public.artwork_tag (
	artwork_id integer NOT NULL,
	tag varchar(64) NOT NULL,
	CONSTRAINT artwork_tag_pk PRIMARY KEY (artwork_id,tag)

);
-- ddl-end --
-- ALTER TABLE public.artwork_tag OWNER TO postgres;
-- ddl-end --

-- object: public.adjudication | type: TYPE --
-- DROP TYPE IF EXISTS public.adjudication CASCADE;
CREATE TYPE public.adjudication AS
 ENUM ('remove','keep');
-- ddl-end --
-- ALTER TYPE public.adjudication OWNER TO postgres;
-- ddl-end --

-- object: public.flag | type: TABLE --
-- DROP TABLE IF EXISTS public.flag CASCADE;
CREATE TABLE public.flag (
	id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	"flagTimestamp" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	comment varchar(1024),
	"flaggedBy" integer NOT NULL,
	"reviewedBy" integer,
	"reviewTimestamp" timestamp,
	review_adjudication public.adjudication,
	CONSTRAINT flag_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.flag OWNER TO postgres;
-- ddl-end --

-- object: public.artwork_article_flag | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork_article_flag CASCADE;
CREATE TABLE public.artwork_article_flag (
	"flagId" integer NOT NULL,
	"artworkArticleId" integer NOT NULL,
	CONSTRAINT artwork_article_flag_pk PRIMARY KEY ("flagId","artworkArticleId")

);
-- ddl-end --
-- ALTER TABLE public.artwork_article_flag OWNER TO postgres;
-- ddl-end --

-- object: public.artwork_image_flag | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork_image_flag CASCADE;
CREATE TABLE public.artwork_image_flag (
	"flagId" integer NOT NULL,
	"artworkImageId" integer NOT NULL,
	CONSTRAINT artwork_image_flag_pk PRIMARY KEY ("flagId","artworkImageId")

);
-- ddl-end --
-- ALTER TABLE public.artwork_image_flag OWNER TO postgres;
-- ddl-end --

-- object: public.artwork_flag | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork_flag CASCADE;
CREATE TABLE public.artwork_flag (
	"flagId" integer NOT NULL,
	"artworkId" integer NOT NULL,
	CONSTRAINT artwork_flag_pk PRIMARY KEY ("flagId","artworkId")

);
-- ddl-end --
-- ALTER TABLE public.artwork_flag OWNER TO postgres;
-- ddl-end --

-- object: public.person_flag | type: TABLE --
-- DROP TABLE IF EXISTS public.person_flag CASCADE;
CREATE TABLE public.person_flag (
	"flagId" integer NOT NULL,
	"personId" integer NOT NULL,
	CONSTRAINT person_flag_pk PRIMARY KEY ("flagId","personId")

);
-- ddl-end --
-- ALTER TABLE public.person_flag OWNER TO postgres;
-- ddl-end --

-- object: public.artist_artwork_flag | type: TABLE --
-- DROP TABLE IF EXISTS public.artist_artwork_flag CASCADE;
CREATE TABLE public.artist_artwork_flag (
	"flagId" integer NOT NULL,
	"artistId" integer NOT NULL,
	"artworkId" integer NOT NULL,
	CONSTRAINT artist_artwork_flag_pk PRIMARY KEY ("flagId","artistId","artworkId")

);
-- ddl-end --
-- ALTER TABLE public.artist_artwork_flag OWNER TO postgres;
-- ddl-end --

-- object: public.tour_flag | type: TABLE --
-- DROP TABLE IF EXISTS public.tour_flag CASCADE;
CREATE TABLE public.tour_flag (
	"flagId" integer NOT NULL,
	"tourId" integer NOT NULL,
	CONSTRAINT tour_flag_pk PRIMARY KEY ("flagId","tourId")

);
-- ddl-end --
-- ALTER TABLE public.tour_flag OWNER TO postgres;
-- ddl-end --

-- object: public.tag_flag | type: TABLE --
-- DROP TABLE IF EXISTS public.tag_flag CASCADE;
CREATE TABLE public.tag_flag (
	"flagId" integer NOT NULL,
	tag varchar(64) NOT NULL,
	CONSTRAINT tag_flag_pk PRIMARY KEY ("flagId",tag)

);
-- ddl-end --
-- ALTER TABLE public.tag_flag OWNER TO postgres;
-- ddl-end --

-- object: public.artwork_tag_flag | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork_tag_flag CASCADE;
CREATE TABLE public.artwork_tag_flag (
	"flagId" integer NOT NULL,
	"artworkId" integer NOT NULL,
	tag varchar(64) NOT NULL,
	CONSTRAINT artwork_tag_flag_pk PRIMARY KEY ("flagId","artworkId",tag)

);
-- ddl-end --
-- ALTER TABLE public.artwork_tag_flag OWNER TO postgres;
-- ddl-end --

-- object: public.artwork | type: TABLE --
-- DROP TABLE IF EXISTS public.artwork CASCADE;
CREATE TABLE public.artwork (
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	title varchar(128) NOT NULL,
	description text,
	statement text,
	location geography(POINT) NOT NULL,
	installation_date date,
	updated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_by integer NOT NULL,
	CONSTRAINT artwork_pk PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON COLUMN public.artwork.statement IS E'Artist''s statement';
-- ddl-end --
COMMENT ON COLUMN public.artwork.location IS E'Lat/Lon of artwork';
-- ddl-end --
-- ALTER TABLE public.artwork OWNER TO postgres;
-- ddl-end --

-- object: public.artist_tag | type: TABLE --
-- DROP TABLE IF EXISTS public.artist_tag CASCADE;
CREATE TABLE public.artist_tag (
	artist_id integer NOT NULL,
	tag varchar(64) NOT NULL,
	CONSTRAINT artist_tag_pk PRIMARY KEY (artist_id,tag)

);
-- ddl-end --
-- ALTER TABLE public.artist_tag OWNER TO postgres;
-- ddl-end --

-- object: "person_updatedBy_ref" | type: CONSTRAINT --
-- ALTER TABLE public.person DROP CONSTRAINT IF EXISTS "person_updatedBy_ref" CASCADE;
ALTER TABLE public.person ADD CONSTRAINT "person_updatedBy_ref" FOREIGN KEY (updated_by)
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: follower_fk | type: CONSTRAINT --
-- ALTER TABLE public.following DROP CONSTRAINT IF EXISTS follower_fk CASCADE;
ALTER TABLE public.following ADD CONSTRAINT follower_fk FOREIGN KEY ("followerId")
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: following_fk | type: CONSTRAINT --
-- ALTER TABLE public.following DROP CONSTRAINT IF EXISTS following_fk CASCADE;
ALTER TABLE public.following ADD CONSTRAINT following_fk FOREIGN KEY ("followingId")
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: updated_by_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork DROP CONSTRAINT IF EXISTS updated_by_fk CASCADE;
ALTER TABLE public.artwork ADD CONSTRAINT updated_by_fk FOREIGN KEY (updated_by)
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --
COMMENT ON CONSTRAINT updated_by_fk ON public.artwork  IS E'Person ID of the person who last updated this entry';
-- ddl-end --


-- object: star_person_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork_star DROP CONSTRAINT IF EXISTS star_person_id_fk CASCADE;
ALTER TABLE public.artwork_star ADD CONSTRAINT star_person_id_fk FOREIGN KEY (person_id)
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: star_artwork_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork_star DROP CONSTRAINT IF EXISTS star_artwork_id_fk CASCADE;
ALTER TABLE public.artwork_star ADD CONSTRAINT star_artwork_id_fk FOREIGN KEY (artwork_id)
REFERENCES public.artwork (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: image_artwork_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork_image DROP CONSTRAINT IF EXISTS image_artwork_fk CASCADE;
ALTER TABLE public.artwork_image ADD CONSTRAINT image_artwork_fk FOREIGN KEY (artwork_id)
REFERENCES public.artwork (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: artwork_image_uploaded_by_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork_image DROP CONSTRAINT IF EXISTS artwork_image_uploaded_by_fk CASCADE;
ALTER TABLE public.artwork_image ADD CONSTRAINT artwork_image_uploaded_by_fk FOREIGN KEY (uploaded_by)
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "tour_personId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.tour DROP CONSTRAINT IF EXISTS "tour_personId_fk" CASCADE;
ALTER TABLE public.tour ADD CONSTRAINT "tour_personId_fk" FOREIGN KEY ("createdById")
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "tour_updatedBy_fk" | type: CONSTRAINT --
-- ALTER TABLE public.tour DROP CONSTRAINT IF EXISTS "tour_updatedBy_fk" CASCADE;
ALTER TABLE public.tour ADD CONSTRAINT "tour_updatedBy_fk" FOREIGN KEY ("updatedBy")
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "tour_artwork_tourId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.tour_artwork DROP CONSTRAINT IF EXISTS "tour_artwork_tourId_fk" CASCADE;
ALTER TABLE public.tour_artwork ADD CONSTRAINT "tour_artwork_tourId_fk" FOREIGN KEY ("tourId")
REFERENCES public.tour (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "tour_artwork_artworkId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.tour_artwork DROP CONSTRAINT IF EXISTS "tour_artwork_artworkId_fk" CASCADE;
ALTER TABLE public.tour_artwork ADD CONSTRAINT "tour_artwork_artworkId_fk" FOREIGN KEY ("artworkId")
REFERENCES public.artwork (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: artist_artwork_artist_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.artist_artwork DROP CONSTRAINT IF EXISTS artist_artwork_artist_id_fk CASCADE;
ALTER TABLE public.artist_artwork ADD CONSTRAINT artist_artwork_artist_id_fk FOREIGN KEY (artist_id)
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: artist_artwork_artwork_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.artist_artwork DROP CONSTRAINT IF EXISTS artist_artwork_artwork_id_fk CASCADE;
ALTER TABLE public.artist_artwork ADD CONSTRAINT artist_artwork_artwork_id_fk FOREIGN KEY (artwork_id)
REFERENCES public.artwork (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: artwork_article_updated_by_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork_article DROP CONSTRAINT IF EXISTS artwork_article_updated_by_fk CASCADE;
ALTER TABLE public.artwork_article ADD CONSTRAINT artwork_article_updated_by_fk FOREIGN KEY (updated_by)
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: artwork_article_artwork_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork_article DROP CONSTRAINT IF EXISTS artwork_article_artwork_id_fk CASCADE;
ALTER TABLE public.artwork_article ADD CONSTRAINT artwork_article_artwork_id_fk FOREIGN KEY (artwork_id)
REFERENCES public.artwork (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: artwork_tag_artwork_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork_tag DROP CONSTRAINT IF EXISTS artwork_tag_artwork_id_fk CASCADE;
ALTER TABLE public.artwork_tag ADD CONSTRAINT artwork_tag_artwork_id_fk FOREIGN KEY (artwork_id)
REFERENCES public.artwork (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: artwork_tag_tag_id_fk | type: CONSTRAINT --
-- ALTER TABLE public.artwork_tag DROP CONSTRAINT IF EXISTS artwork_tag_tag_id_fk CASCADE;
ALTER TABLE public.artwork_tag ADD CONSTRAINT artwork_tag_tag_id_fk FOREIGN KEY (tag)
REFERENCES public.tag (tag) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "flag_flaggedBy_fk" | type: CONSTRAINT --
-- ALTER TABLE public.flag DROP CONSTRAINT IF EXISTS "flag_flaggedBy_fk" CASCADE;
ALTER TABLE public.flag ADD CONSTRAINT "flag_flaggedBy_fk" FOREIGN KEY ("flaggedBy")
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "flag_reviewedBy_fk" | type: CONSTRAINT --
-- ALTER TABLE public.flag DROP CONSTRAINT IF EXISTS "flag_reviewedBy_fk" CASCADE;
ALTER TABLE public.flag ADD CONSTRAINT "flag_reviewedBy_fk" FOREIGN KEY ("reviewedBy")
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artwork_article_flag_artworkArticleId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artwork_article_flag DROP CONSTRAINT IF EXISTS "artwork_article_flag_artworkArticleId_fk" CASCADE;
ALTER TABLE public.artwork_article_flag ADD CONSTRAINT "artwork_article_flag_artworkArticleId_fk" FOREIGN KEY ("artworkArticleId")
REFERENCES public.artwork_article (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artwork_article_flag_flagId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artwork_article_flag DROP CONSTRAINT IF EXISTS "artwork_article_flag_flagId_fk" CASCADE;
ALTER TABLE public.artwork_article_flag ADD CONSTRAINT "artwork_article_flag_flagId_fk" FOREIGN KEY ("flagId")
REFERENCES public.flag (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artwork_image_flag_flagId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artwork_image_flag DROP CONSTRAINT IF EXISTS "artwork_image_flag_flagId_fk" CASCADE;
ALTER TABLE public.artwork_image_flag ADD CONSTRAINT "artwork_image_flag_flagId_fk" FOREIGN KEY ("flagId")
REFERENCES public.flag (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artwork_image_flag_artworkImageId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artwork_image_flag DROP CONSTRAINT IF EXISTS "artwork_image_flag_artworkImageId_fk" CASCADE;
ALTER TABLE public.artwork_image_flag ADD CONSTRAINT "artwork_image_flag_artworkImageId_fk" FOREIGN KEY ("artworkImageId")
REFERENCES public.artwork_image (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artwork_flag_flagId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artwork_flag DROP CONSTRAINT IF EXISTS "artwork_flag_flagId_fk" CASCADE;
ALTER TABLE public.artwork_flag ADD CONSTRAINT "artwork_flag_flagId_fk" FOREIGN KEY ("flagId")
REFERENCES public.flag (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artwork_flag_artworkId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artwork_flag DROP CONSTRAINT IF EXISTS "artwork_flag_artworkId_fk" CASCADE;
ALTER TABLE public.artwork_flag ADD CONSTRAINT "artwork_flag_artworkId_fk" FOREIGN KEY ("artworkId")
REFERENCES public.artwork (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "person_flag_flagId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.person_flag DROP CONSTRAINT IF EXISTS "person_flag_flagId_fk" CASCADE;
ALTER TABLE public.person_flag ADD CONSTRAINT "person_flag_flagId_fk" FOREIGN KEY ("flagId")
REFERENCES public.flag (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "person_flag_personId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.person_flag DROP CONSTRAINT IF EXISTS "person_flag_personId_fk" CASCADE;
ALTER TABLE public.person_flag ADD CONSTRAINT "person_flag_personId_fk" FOREIGN KEY ("personId")
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artist_artwork_flag_flagId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artist_artwork_flag DROP CONSTRAINT IF EXISTS "artist_artwork_flag_flagId_fk" CASCADE;
ALTER TABLE public.artist_artwork_flag ADD CONSTRAINT "artist_artwork_flag_flagId_fk" FOREIGN KEY ("flagId")
REFERENCES public.flag (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artist_artwork_flag_artistArtworkId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artist_artwork_flag DROP CONSTRAINT IF EXISTS "artist_artwork_flag_artistArtworkId_fk" CASCADE;
ALTER TABLE public.artist_artwork_flag ADD CONSTRAINT "artist_artwork_flag_artistArtworkId_fk" FOREIGN KEY ("artistId","artworkId")
REFERENCES public.artist_artwork (artist_id,artwork_id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "tour_flag_flagId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.tour_flag DROP CONSTRAINT IF EXISTS "tour_flag_flagId_fk" CASCADE;
ALTER TABLE public.tour_flag ADD CONSTRAINT "tour_flag_flagId_fk" FOREIGN KEY ("flagId")
REFERENCES public.flag (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "tour_flag_tourId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.tour_flag DROP CONSTRAINT IF EXISTS "tour_flag_tourId_fk" CASCADE;
ALTER TABLE public.tour_flag ADD CONSTRAINT "tour_flag_tourId_fk" FOREIGN KEY ("tourId")
REFERENCES public.tour (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "tag_flag_flagId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.tag_flag DROP CONSTRAINT IF EXISTS "tag_flag_flagId_fk" CASCADE;
ALTER TABLE public.tag_flag ADD CONSTRAINT "tag_flag_flagId_fk" FOREIGN KEY ("flagId")
REFERENCES public.flag (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: tag_flag_tag_fk | type: CONSTRAINT --
-- ALTER TABLE public.tag_flag DROP CONSTRAINT IF EXISTS tag_flag_tag_fk CASCADE;
ALTER TABLE public.tag_flag ADD CONSTRAINT tag_flag_tag_fk FOREIGN KEY (tag)
REFERENCES public.tag (tag) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artwork_tag_flag_artworkTag_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artwork_tag_flag DROP CONSTRAINT IF EXISTS "artwork_tag_flag_artworkTag_fk" CASCADE;
ALTER TABLE public.artwork_tag_flag ADD CONSTRAINT "artwork_tag_flag_artworkTag_fk" FOREIGN KEY ("artworkId",tag)
REFERENCES public.artwork_tag (artwork_id,tag) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artwork_tag_flag_flagId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artwork_tag_flag DROP CONSTRAINT IF EXISTS "artwork_tag_flag_flagId_fk" CASCADE;
ALTER TABLE public.artwork_tag_flag ADD CONSTRAINT "artwork_tag_flag_flagId_fk" FOREIGN KEY ("flagId")
REFERENCES public.flag (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: "artist_tag_artistId_fk" | type: CONSTRAINT --
-- ALTER TABLE public.artist_tag DROP CONSTRAINT IF EXISTS "artist_tag_artistId_fk" CASCADE;
ALTER TABLE public.artist_tag ADD CONSTRAINT "artist_tag_artistId_fk" FOREIGN KEY (artist_id)
REFERENCES public.person (id) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: artist_tag_tag_fk | type: CONSTRAINT --
-- ALTER TABLE public.artist_tag DROP CONSTRAINT IF EXISTS artist_tag_tag_fk CASCADE;
ALTER TABLE public.artist_tag ADD CONSTRAINT artist_tag_tag_fk FOREIGN KEY (tag)
REFERENCES public.tag (tag) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --


