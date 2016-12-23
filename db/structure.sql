--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: queue_classic_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE queue_classic_jobs (
    id bigint NOT NULL,
    q_name text NOT NULL,
    method text NOT NULL,
    args json NOT NULL,
    locked_at timestamp with time zone,
    locked_by integer,
    created_at timestamp with time zone DEFAULT now(),
    scheduled_at timestamp with time zone DEFAULT now(),
    CONSTRAINT queue_classic_jobs_method_check CHECK ((length(method) > 0)),
    CONSTRAINT queue_classic_jobs_q_name_check CHECK ((length(q_name) > 0))
);


--
-- Name: lock_head(character varying); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lock_head(tname character varying) RETURNS SETOF queue_classic_jobs
    LANGUAGE plpgsql
    AS $_$
BEGIN
  RETURN QUERY EXECUTE 'SELECT * FROM lock_head($1,10)' USING tname;
END;
$_$;


--
-- Name: lock_head(character varying, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION lock_head(q_name character varying, top_boundary integer) RETURNS SETOF queue_classic_jobs
    LANGUAGE plpgsql
    AS $_$
DECLARE
  unlocked bigint;
  relative_top integer;
  job_count integer;
BEGIN
  -- The purpose is to release contention for the first spot in the table.
  -- The select count(*) is going to slow down dequeue performance but allow
  -- for more workers. Would love to see some optimization here...

  EXECUTE 'SELECT count(*) FROM '
    || '(SELECT * FROM queue_classic_jobs '
    || ' WHERE locked_at IS NULL'
    || ' AND q_name = '
    || quote_literal(q_name)
    || ' AND scheduled_at <= '
    || quote_literal(now())
    || ' LIMIT '
    || quote_literal(top_boundary)
    || ') limited'
  INTO job_count;

  SELECT TRUNC(random() * (top_boundary - 1))
  INTO relative_top;

  IF job_count < top_boundary THEN
    relative_top = 0;
  END IF;

  LOOP
    BEGIN
      EXECUTE 'SELECT id FROM queue_classic_jobs '
        || ' WHERE locked_at IS NULL'
        || ' AND q_name = '
        || quote_literal(q_name)
        || ' AND scheduled_at <= '
        || quote_literal(now())
        || ' ORDER BY id ASC'
        || ' LIMIT 1'
        || ' OFFSET ' || quote_literal(relative_top)
        || ' FOR UPDATE NOWAIT'
      INTO unlocked;
      EXIT;
    EXCEPTION
      WHEN lock_not_available THEN
        -- do nothing. loop again and hope we get a lock
    END;
  END LOOP;

  RETURN QUERY EXECUTE 'UPDATE queue_classic_jobs '
    || ' SET locked_at = (CURRENT_TIMESTAMP),'
    || ' locked_by = (select pg_backend_pid())'
    || ' WHERE id = $1'
    || ' AND locked_at is NULL'
    || ' RETURNING *'
  USING unlocked;

  RETURN;
END;
$_$;


--
-- Name: queue_classic_notify(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION queue_classic_notify() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ begin
  perform pg_notify(new.q_name, '');
  return null;
end $$;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    content character varying NOT NULL,
    user_id integer NOT NULL,
    ziltag_id integer NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: http_requests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE http_requests (
    id integer NOT NULL,
    env json DEFAULT '{}'::json NOT NULL,
    session_id character varying,
    referer character varying,
    params json DEFAULT '{}'::json NOT NULL,
    created_at timestamp without time zone NOT NULL,
    path character varying
);


--
-- Name: http_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE http_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: http_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE http_requests_id_seq OWNED BY http_requests.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE photos (
    id integer NOT NULL,
    user_id integer,
    image character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    source character varying,
    href character varying,
    natural_id character varying NOT NULL,
    website_id integer,
    host character varying,
    path character varying,
    width integer DEFAULT 0 NOT NULL,
    height integer DEFAULT 0 NOT NULL,
    namespace character varying
);


--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE photos_id_seq OWNED BY photos.id;


--
-- Name: queue_classic_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE queue_classic_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: queue_classic_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE queue_classic_jobs_id_seq OWNED BY queue_classic_jobs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: shorten_urls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE shorten_urls (
    id integer NOT NULL,
    url character varying NOT NULL,
    natural_id character varying NOT NULL,
    display_name character varying
);


--
-- Name: shorten_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE shorten_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shorten_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE shorten_urls_id_seq OWNED BY shorten_urls.id;


--
-- Name: sse_notifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sse_notifications (
    id integer NOT NULL,
    body json NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sse_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sse_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sse_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sse_notifications_id_seq OWNED BY sse_notifications.id;


--
-- Name: tracks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tracks (
    id integer NOT NULL,
    event character varying NOT NULL,
    token character varying NOT NULL,
    status character varying DEFAULT 'success'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_agent character varying,
    referer character varying
);


--
-- Name: tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tracks_id_seq OWNED BY tracks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    avatar character varying,
    username character varying,
    type character varying,
    has_created_first_ziltag boolean DEFAULT false,
    ziltag_notification boolean DEFAULT true NOT NULL,
    comment_notification boolean DEFAULT true NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: visitors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE visitors (
    id integer NOT NULL,
    email character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: visitors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE visitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: visitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE visitors_id_seq OWNED BY visitors.id;


--
-- Name: websites; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE websites (
    id integer NOT NULL,
    token character varying NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    url character varying,
    restricted boolean DEFAULT true NOT NULL
);


--
-- Name: websites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE websites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: websites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE websites_id_seq OWNED BY websites.id;


--
-- Name: ziltags; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ziltags (
    id integer NOT NULL,
    photo_id integer,
    user_id integer,
    x numeric NOT NULL,
    y numeric NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    natural_id character varying NOT NULL,
    share_image character varying,
    unsubscribers integer[] DEFAULT '{}'::integer[]
);


--
-- Name: ziltags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ziltags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ziltags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ziltags_id_seq OWNED BY ziltags.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY http_requests ALTER COLUMN id SET DEFAULT nextval('http_requests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY photos ALTER COLUMN id SET DEFAULT nextval('photos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY queue_classic_jobs ALTER COLUMN id SET DEFAULT nextval('queue_classic_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY shorten_urls ALTER COLUMN id SET DEFAULT nextval('shorten_urls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sse_notifications ALTER COLUMN id SET DEFAULT nextval('sse_notifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tracks ALTER COLUMN id SET DEFAULT nextval('tracks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY visitors ALTER COLUMN id SET DEFAULT nextval('visitors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY websites ALTER COLUMN id SET DEFAULT nextval('websites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ziltags ALTER COLUMN id SET DEFAULT nextval('ziltags_id_seq'::regclass);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: http_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY http_requests
    ADD CONSTRAINT http_requests_pkey PRIMARY KEY (id);


--
-- Name: photos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: queue_classic_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY queue_classic_jobs
    ADD CONSTRAINT queue_classic_jobs_pkey PRIMARY KEY (id);


--
-- Name: shorten_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY shorten_urls
    ADD CONSTRAINT shorten_urls_pkey PRIMARY KEY (id);


--
-- Name: sse_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sse_notifications
    ADD CONSTRAINT sse_notifications_pkey PRIMARY KEY (id);


--
-- Name: tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tracks
    ADD CONSTRAINT tracks_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: visitors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (id);


--
-- Name: websites_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY websites
    ADD CONSTRAINT websites_pkey PRIMARY KEY (id);


--
-- Name: ziltags_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ziltags
    ADD CONSTRAINT ziltags_pkey PRIMARY KEY (id);


--
-- Name: idx_qc_on_name_only_unlocked; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_qc_on_name_only_unlocked ON queue_classic_jobs USING btree (q_name, id) WHERE (locked_at IS NULL);


--
-- Name: idx_qc_on_scheduled_at_only_unlocked; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX idx_qc_on_scheduled_at_only_unlocked ON queue_classic_jobs USING btree (scheduled_at, id) WHERE (locked_at IS NULL);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_comments_on_ziltag_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_ziltag_id ON comments USING btree (ziltag_id);


--
-- Name: index_http_requests_on_path; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_http_requests_on_path ON http_requests USING btree (path);


--
-- Name: index_http_requests_on_session_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_http_requests_on_session_id ON http_requests USING btree (session_id);


--
-- Name: index_photos_on_host; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_photos_on_host ON photos USING btree (host);


--
-- Name: index_photos_on_namespace; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_photos_on_namespace ON photos USING btree (namespace);


--
-- Name: index_photos_on_natural_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_photos_on_natural_id ON photos USING btree (natural_id);


--
-- Name: index_photos_on_path; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_photos_on_path ON photos USING btree (path);


--
-- Name: index_photos_on_source_and_href_and_website_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_photos_on_source_and_href_and_website_id ON photos USING btree (source, href, website_id);


--
-- Name: index_photos_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_photos_on_user_id ON photos USING btree (user_id);


--
-- Name: index_photos_on_website_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_photos_on_website_id ON photos USING btree (website_id);


--
-- Name: index_shorten_urls_on_natural_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_shorten_urls_on_natural_id ON shorten_urls USING btree (natural_id);


--
-- Name: index_tracks_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tracks_on_token ON tracks USING btree (token);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: index_websites_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_websites_on_token ON websites USING btree (token);


--
-- Name: index_websites_on_url; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_websites_on_url ON websites USING btree (url);


--
-- Name: index_websites_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_websites_on_user_id ON websites USING btree (user_id);


--
-- Name: index_ziltags_on_natural_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ziltags_on_natural_id ON ziltags USING btree (natural_id);


--
-- Name: index_ziltags_on_photo_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ziltags_on_photo_id ON ziltags USING btree (photo_id);


--
-- Name: index_ziltags_on_unsubscribers; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ziltags_on_unsubscribers ON ziltags USING btree (unsubscribers);


--
-- Name: index_ziltags_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ziltags_on_user_id ON ziltags USING btree (user_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: queue_classic_notify; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER queue_classic_notify AFTER INSERT ON queue_classic_jobs FOR EACH ROW EXECUTE PROCEDURE queue_classic_notify();


--
-- Name: fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_1759f3f15c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT fk_rails_1759f3f15c FOREIGN KEY (ziltag_id) REFERENCES ziltags(id);


--
-- Name: fk_rails_473b2d255f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ziltags
    ADD CONSTRAINT fk_rails_473b2d255f FOREIGN KEY (photo_id) REFERENCES photos(id);


--
-- Name: fk_rails_4dec353e18; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ziltags
    ADD CONSTRAINT fk_rails_4dec353e18 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_6e9f17f192; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY websites
    ADD CONSTRAINT fk_rails_6e9f17f192 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: fk_rails_c0ad8f36e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT fk_rails_c0ad8f36e2 FOREIGN KEY (website_id) REFERENCES websites(id);


--
-- Name: fk_rails_c79d76afc0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY photos
    ADD CONSTRAINT fk_rails_c79d76afc0 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150407064303');

INSERT INTO schema_migrations (version) VALUES ('20150407092939');

INSERT INTO schema_migrations (version) VALUES ('20150407092940');

INSERT INTO schema_migrations (version) VALUES ('20150407092941');

INSERT INTO schema_migrations (version) VALUES ('20150407092942');

INSERT INTO schema_migrations (version) VALUES ('20150410090728');

INSERT INTO schema_migrations (version) VALUES ('20150420061017');

INSERT INTO schema_migrations (version) VALUES ('20150421111628');

INSERT INTO schema_migrations (version) VALUES ('20150423094452');

INSERT INTO schema_migrations (version) VALUES ('20150511161428');

INSERT INTO schema_migrations (version) VALUES ('20150517035932');

INSERT INTO schema_migrations (version) VALUES ('20150520175114');

INSERT INTO schema_migrations (version) VALUES ('20150525013519');

INSERT INTO schema_migrations (version) VALUES ('20150601083625');

INSERT INTO schema_migrations (version) VALUES ('20150617220110');

INSERT INTO schema_migrations (version) VALUES ('20150623073711');

INSERT INTO schema_migrations (version) VALUES ('20150623073748');

INSERT INTO schema_migrations (version) VALUES ('20150624015102');

INSERT INTO schema_migrations (version) VALUES ('20150710063357');

INSERT INTO schema_migrations (version) VALUES ('20150714053926');

INSERT INTO schema_migrations (version) VALUES ('20150813091344');

INSERT INTO schema_migrations (version) VALUES ('20150815130654');

INSERT INTO schema_migrations (version) VALUES ('20150825094627');

INSERT INTO schema_migrations (version) VALUES ('20150831193401');

INSERT INTO schema_migrations (version) VALUES ('20150901153643');

INSERT INTO schema_migrations (version) VALUES ('20150903210028');

INSERT INTO schema_migrations (version) VALUES ('20150904191432');

INSERT INTO schema_migrations (version) VALUES ('20150914133404');

INSERT INTO schema_migrations (version) VALUES ('20150914133736');

INSERT INTO schema_migrations (version) VALUES ('20150914135441');

INSERT INTO schema_migrations (version) VALUES ('20150916095756');

INSERT INTO schema_migrations (version) VALUES ('20150921111334');

INSERT INTO schema_migrations (version) VALUES ('20150921151526');

INSERT INTO schema_migrations (version) VALUES ('20150922105659');

INSERT INTO schema_migrations (version) VALUES ('20151001092007');

INSERT INTO schema_migrations (version) VALUES ('20151001190933');

INSERT INTO schema_migrations (version) VALUES ('20151001190934');

INSERT INTO schema_migrations (version) VALUES ('20151001190935');

INSERT INTO schema_migrations (version) VALUES ('20151001190936');

INSERT INTO schema_migrations (version) VALUES ('20151002104738');

INSERT INTO schema_migrations (version) VALUES ('20151004211150');

INSERT INTO schema_migrations (version) VALUES ('20151004215502');

INSERT INTO schema_migrations (version) VALUES ('20151006075302');

INSERT INTO schema_migrations (version) VALUES ('20151023045800');

INSERT INTO schema_migrations (version) VALUES ('20151023055633');

INSERT INTO schema_migrations (version) VALUES ('20151026044959');

INSERT INTO schema_migrations (version) VALUES ('20151026085656');

INSERT INTO schema_migrations (version) VALUES ('20151028083550');

INSERT INTO schema_migrations (version) VALUES ('20151108171329');

INSERT INTO schema_migrations (version) VALUES ('20151109052017');

INSERT INTO schema_migrations (version) VALUES ('20151130194955');

INSERT INTO schema_migrations (version) VALUES ('20151201074814');

INSERT INTO schema_migrations (version) VALUES ('20160202075115');

INSERT INTO schema_migrations (version) VALUES ('20160217160535');

INSERT INTO schema_migrations (version) VALUES ('20160226055302');

INSERT INTO schema_migrations (version) VALUES ('20160226063409');

INSERT INTO schema_migrations (version) VALUES ('20160311073414');

INSERT INTO schema_migrations (version) VALUES ('20160630162048');

INSERT INTO schema_migrations (version) VALUES ('20160711040036');

INSERT INTO schema_migrations (version) VALUES ('20160724045410');

INSERT INTO schema_migrations (version) VALUES ('20160731131546');

INSERT INTO schema_migrations (version) VALUES ('20160813135507');

INSERT INTO schema_migrations (version) VALUES ('20160820034544');

INSERT INTO schema_migrations (version) VALUES ('20160820040305');

INSERT INTO schema_migrations (version) VALUES ('20160820043133');

INSERT INTO schema_migrations (version) VALUES ('20160822044809');

INSERT INTO schema_migrations (version) VALUES ('20161108042731');

INSERT INTO schema_migrations (version) VALUES ('20161116100526');

INSERT INTO schema_migrations (version) VALUES ('20161116102122');

INSERT INTO schema_migrations (version) VALUES ('20161130070658');

INSERT INTO schema_migrations (version) VALUES ('20161217174516');

INSERT INTO schema_migrations (version) VALUES ('20161223174639');

