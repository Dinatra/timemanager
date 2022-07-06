DELETE from clocks;
DELETE from workingtimes;
DELETE from users;

ALTER SEQUENCE users_id_seq RESTART WITH 1;
INSERT INTO users (id, username, email, inserted_at, updated_at) VALUES (4242, 'marc', 'marc@gmail.com', NOW(), NOW());
INSERT INTO users (id, username, email, inserted_at, updated_at) VALUES (8080, 'louis', 'louis@gmail.com', NOW(), NOW());
INSERT INTO users (id, username, email, inserted_at, updated_at) VALUES (5050, 'deleteme', 'deleteme@gmail.com', NOW(), NOW());

INSERT INTO clocks (time, status, user_id, inserted_at, updated_at) VALUES (NOW(), false, 4242, NOW(), NOW());
INSERT INTO clocks (time, status, user_id, inserted_at, updated_at) VALUES (NOW(), false, 4242, NOW(), NOW());

INSERT INTO "workingtimes" ("id", "start", "end", "user_id", "inserted_at", "updated_at") VALUES (4242, now(), now(), 8080, now(), now());
INSERT INTO "workingtimes" ("id", "start", "end", "user_id", "inserted_at", "updated_at") VALUES (9090, now(), now(), 8080, now(), now());
INSERT INTO "workingtimes" ("id", "start", "end", "user_id", "inserted_at", "updated_at") VALUES (4444, now(), now(), 8080, now(), now());