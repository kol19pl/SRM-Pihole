BEGIN;

ALTER TABLE download_queue ADD COLUMN completed_time int DEFAULT 0;

COMMIT;

