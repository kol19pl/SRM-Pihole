-- vim:ft=sql

BEGIN;

create table sysconf (
	download_enabled int,
	download_when varchar(12),
	download_order int,
	seeding_ratio int,
	seeding_interval int
);

create table user_setting (
	username varchar(128),
	uid int4 DEFAULT -1,
	share_folder varchar(128),
	user_disabled bool default FALSE,
	delete_watchtorrent bool default FALSE,
	watchfolder text,
	enable_watchffolder bool default FALSE,
	CONSTRAINT user_setting_pkey PRIMARY KEY(username)
);

CREATE TABLE rss_feed (
	id SERIAL,
	username varchar(128) NOT NULL,
	title text,
	url text NOT NULL,
	last_update int4,
	is_updating bool DEFAULT FALSE,
	CONSTRAINT rss_feed_pkey PRIMARY KEY (id),
	CONSTRAINT rss_feed_username_fkey FOREIGN KEY(username) REFERENCES user_setting(username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE rss_item (
	id SERIAL,
	feed_id int4 NOT NULL,
	title text,
	url text,
	link text,
	date int4,
	size int8,
	is_new bool DEFAULT TRUE,
	CONSTRAINT rss_item_pkey PRIMARY KEY (id),
	CONSTRAINT rss_item_feed_fkey FOREIGN KEY(feed_id) REFERENCES rss_feed(id) ON DELETE CASCADE
);

CREATE TABLE rss_filter (
	id SERIAL,
	feed_id int4 NOT NULL,
	name text,
	match text,
	not_match text,
	destination text,
	enable bool DEFAULT TRUE,
	is_regex bool DEFAULT FALSE,
	CONSTRAINT rss_filter_pkey PRIMARY KEY (id),
	CONSTRAINT rss_filter_feed_fkey FOREIGN KEY(feed_id) REFERENCES rss_feed(id) ON DELETE CASCADE
);

create table download_queue (
	task_id SERIAL,
	username varchar(128),
	pid int,
	url text,
	filename varchar(1024),
	status int,
	created_time int,
	started_time int,
	total_size int8,
	current_size int8,
	current_rate int,
	extra_info text,
	total_peers int,
	connected_peers int,
	total_pieces int,
	downloaded_pieces int,
	available_pieces int,
	torrent	bytea,
	upload_rate int DEFAULT 0,
	total_upload int8 DEFAULT 0,
	seeding_ratio int DEFAULT 0,
	seeding_interval int DEFAULT 0,
	seeding_elapsed int DEFAULT 0,
	task_flags int DEFAULT 0,
	seeders int DEFAULT 0,
	leechers int DEFAULT 0,
	destination text,
	unzip_password text,
	unzip_progress int DEFAULT 0,
	given_filename text,
	referer text,
	cookie_path text,
	CONSTRAINT download_queue_pkey PRIMARY KEY(task_id)
);
CREATE INDEX download_queue_user_index ON download_queue USING BTREE (username);

CREATE FUNCTION "SYNODownloadTrigger"() RETURNS "trigger" AS '/var/packages/DownloadStation/target/lib/libsynotrigger.so' LANGUAGE 'c' IMMUTABLE;
CREATE TRIGGER "HaveTaskTrigger" AFTER INSERT OR UPDATE
   ON user_setting FOR EACH STATEMENT
   EXECUTE PROCEDURE "SYNODownloadTrigger"();
CREATE TRIGGER "HaveTaskTrigger" AFTER INSERT OR UPDATE
   ON download_queue FOR EACH STATEMENT
   EXECUTE PROCEDURE public."SYNODownloadTrigger"();


COMMIT;
