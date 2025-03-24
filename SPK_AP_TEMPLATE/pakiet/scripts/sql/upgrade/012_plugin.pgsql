-- vim:ft=sql

BEGIN;

CREATE TABLE task_plugin (
	task_id int4 NOT NULL,
	process JSON,
	current_plugin varchar(128),
	current_type varchar(64),
	current_status int4 DEFAULT 0,
	attributes JSON,
	response JSON,
	result JSON,
	pid int DEFAULT -1,
	CONSTRAINT task_plugin_pkey PRIMARY KEY (task_id),
	CONSTRAINT task_plugin_task_id_fkey FOREIGN KEY(task_id) REFERENCES download_queue(task_id) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMIT;

