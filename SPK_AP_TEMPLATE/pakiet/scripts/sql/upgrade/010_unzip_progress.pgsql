BEGIN;

ALTER TABLE download_queue ADD COLUMN unzip_progress int DEFAULT 0;

COMMIT;
