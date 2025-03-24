BEGIN;

ALTER TABLE download_queue ADD COLUMN destination text;

UPDATE download_queue SET destination=share_folder FROM user_setting WHERE lower(download_queue.username)=lower(user_setting.username);

COMMIT;

