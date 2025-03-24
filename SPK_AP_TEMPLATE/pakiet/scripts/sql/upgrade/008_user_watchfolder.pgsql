BEGIN;

ALTER TABLE user_setting ADD COLUMN enable_watchffolder bool DEFAULT FALSE;
ALTER TABLE user_setting ADD COLUMN delete_watchtorrent bool DEFAULT FALSE;
ALTER TABLE user_setting ADD COLUMN watchfolder text;

COMMIT;

