BEGIN;

ALTER TABLE download_queue ADD COLUMN upload_rate int DEFAULT 0;
ALTER TABLE download_queue ADD COLUMN total_upload int8 DEFAULT 0;
ALTER TABLE download_queue ADD COLUMN seeding_ratio int DEFAULT 0;
ALTER TABLE download_queue ADD COLUMN seeding_interval int DEFAULT 0;
ALTER TABLE download_queue ADD COLUMN seeding_elapsed int DEFAULT 0;
ALTER TABLE download_queue ADD COLUMN task_flags int DEFAULT 0;

ALTER TABLE sysconf ADD COLUMN seeding_ratio int DEFAULT 0;
ALTER TABLE sysconf ADD COLUMN seeding_interval int DEFAULT 0;


COMMIT;

