BEGIN;

ALTER TABLE download_queue ADD COLUMN thumbnail_status int4 DEFAULT 0;

ALTER TABLE download_queue ADD COLUMN extra_data JSON;

COMMIT;

