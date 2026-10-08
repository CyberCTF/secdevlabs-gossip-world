-- The three tables the app's util/init_db.py creates at first start, created here with the same
-- definitions. Upstream's init_table_gossips() and init_table_comments() return a 1-tuple after
-- a successful CREATE TABLE, so the app's first start dies with "ValueError: not enough values to
-- unpack" and only comes up after restarts; with the tables already present it starts at once.
CREATE TABLE users (user VARCHAR(100) NOT NULL, password VARCHAR(100) NOT NULL);
CREATE TABLE gossips (id INT(10) NOT NULL AUTO_INCREMENT, author VARCHAR(100) NOT NULL, text VARCHAR(2000) NOT NULL, title VARCHAR(100) NOT NULL, subtitle VARCHAR(200), date DATE NOT NULL, PRIMARY KEY (id));
CREATE TABLE comments (author VARCHAR(100) NOT NULL, comment VARCHAR(100) NOT NULL, gossip_id INT NOT NULL, date DATE NOT NULL);
