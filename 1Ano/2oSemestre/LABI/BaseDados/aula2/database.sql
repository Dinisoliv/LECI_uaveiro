/* Drop tables if they already exist */
DROP TABLE IF EXISTS images;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS votes;

/* Images table */
CREATE TABLE images (
    id INTEGER PRIMARY KEY AUTOINCREMENT, /* primary key */
    name TEXT,
    author TEXT,
    path TEXT,
    datetime TEXT
);

/* Comments table */
CREATE TABLE comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT, /* primary key */
    idimg INTEGER, /* foreign key */
    user TEXT,
    comment TEXT,
    datetime TEXT,
    FOREIGN KEY(idimg) REFERENCES images(id)
);

/* Votes table */
CREATE TABLE votes (
    id INTEGER PRIMARY KEY AUTOINCREMENT, /* primary key */
    idimg INTEGER, /* foreign key */
    ups INTEGER,
    downs INTEGER,
    FOREIGN KEY(idimg) REFERENCES images(id)
);

