-- vim:ft=sql

BEGIN;

CREATE TABLE thumbnail (
	thumbnail_id SERIAL,
	task_id int4 NOT NULL,
	file_index int4 NOT NULL,
	thumbnail_index int4 NOT NULL,
	thumbnail_second int4,
	thumbnail_filename text,
	create_time bigint,
	CONSTRAINT thumbnail_id_pkey PRIMARY KEY (thumbnail_id),
	CONSTRAINT thumbnail_task_id_fkey FOREIGN KEY(task_id) REFERENCES download_queue(task_id) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMIT;

