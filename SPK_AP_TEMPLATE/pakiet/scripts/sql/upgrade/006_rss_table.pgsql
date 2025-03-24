-- vim:ft=sql

BEGIN;

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
	CONSTRAINT rss_filter_pkey PRIMARY KEY (id),
	CONSTRAINT rss_filter_feed_fkey FOREIGN KEY(feed_id) REFERENCES rss_feed(id) ON DELETE CASCADE
);

COMMIT;

