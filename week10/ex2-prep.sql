-- Exercise 2: Isolation Levels
-- Creating a table with the following structure:
-- (username, fullname, balance, group_id)
DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    username VARCHAR(20) NOT NULL,
    fullname VARCHAR(50) NOT NULL,
    balance  INT         NOT NULL,
    group_id INT         NOT NULL,

    PRIMARY KEY (username)
);

-- Populating the table with some data
INSERT INTO users (username, fullname, balance, group_id)
VALUES ('jones', 'Alice Jones', 82, 1),
       ('bitdiddl', 'Ben Bitdiddle', 65, 1),
       ('mike', 'Michael Dole', 73, 2),
       ('alyssa', 'Alyssa P. Hacker', 79, 3),
       ('bbrown', 'Bob Brown', 100, 3);
