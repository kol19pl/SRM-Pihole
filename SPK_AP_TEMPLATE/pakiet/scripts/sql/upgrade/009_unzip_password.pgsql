BEGIN;

ALTER TABLE download_queue ADD COLUMN unzip_password text;

COMMIT;

