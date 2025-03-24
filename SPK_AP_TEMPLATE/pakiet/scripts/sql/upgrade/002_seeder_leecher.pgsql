BEGIN;

ALTER TABLE download_queue ADD COLUMN seeders int DEFAULT 0;
ALTER TABLE download_queue ADD COLUMN leechers int DEFAULT 0;


COMMIT;

