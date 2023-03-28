-- Exercise 1
-- Creating a table of accounts with the following fields:
-- - unique ID;
-- - name;
-- - credit;
-- - currency.
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts
(
    id       INTEGER PRIMARY KEY,
    name     VARCHAR(255),
    credit   INTEGER,
    currency VARCHAR(3)
);

-- Generating and inserting 3 accounts into the table, each account has 1000 RUB on the account
INSERT INTO accounts (id, name, credit, currency)
VALUES (1, 'Mark John', 1000, 'RUB'),
       (2, 'Pepino Pizza', 1000, 'RUB'),
       (3, 'Kyle Broflovski', 1000, 'RUB');

-- Accounts Table - Ex1 - A
SELECT *
FROM accounts;

-- Creating a function for transactions between accounts
DROP FUNCTION IF EXISTS transaction;
CREATE OR REPLACE FUNCTION transaction(sender_id INTEGER, receiver_id INTEGER, amount INTEGER)
    RETURNS VOID AS
$$
BEGIN
    UPDATE accounts SET credit = credit - amount WHERE id = sender_id;
    UPDATE accounts SET credit = credit + amount WHERE id = receiver_id;
END;
$$ LANGUAGE plpgsql;

-- Performing transactions between accounts
-- T1: account 1 send 500 RUB to account 3
-- T2: account 2 send 700 RUB to account 1
-- T3: account 2 send to 100 RUB to account 3
-- Return credit for all account
BEGIN TRANSACTION;
SAVEPOINT T1;
DO
$$
    BEGIN
        PERFORM transaction(1, 3, 500);
    END
$$;

SAVEPOINT T2;
DO
$$
    BEGIN
        PERFORM transaction(2, 1, 700);
    END
$$;

SAVEPOINT T3;
DO
$$
    BEGIN
        PERFORM transaction(2, 3, 100);
    END
$$;

-- Accounts Table after transactions - Ex1 - A
SELECT *
FROM accounts;

ROLLBACK TO T3;
-- SELECT * FROM accounts;
ROLLBACK TO T2;
-- SELECT * FROM accounts;
ROLLBACK TO T1;
-- SELECT * FROM accounts;
COMMIT;
END TRANSACTION;

-- Accounts Table rolled back - Ex1 - A
SELECT *
FROM accounts;

-- Add field "bank_name" to the table "accounts"
ALTER TABLE accounts
    ADD COLUMN bank_name VARCHAR(255);

-- Account 1 & 3 is Sberbank, Account 2 is Tinkoff
UPDATE accounts
SET bank_name = 'Sberbank'
WHERE id IN (1, 3);
UPDATE accounts
SET bank_name = 'Tinkoff'
WHERE id = 2;

-- Fees should be saved in new Record (Account 4)
INSERT INTO accounts (id, name, credit, currency, bank_name)
VALUES (4, 'Fees', 0, 'RUB', 'Fees');

-- Accounts Table with fees collector - Ex1 - B
SELECT *
FROM accounts;

-- Redefining the transaction function to satisfy the following conditions for each transaction:
-- - internal transaction’s fee is 0 RUB;
-- - external transaction’s fee is 30 RUB
CREATE OR REPLACE FUNCTION transaction(sender_id INTEGER, receiver_id INTEGER, amount INTEGER)
    RETURNS VOID AS
$$
DECLARE
    bank1 VARCHAR(255);
    bank2 VARCHAR(255);
    fee   INTEGER;
BEGIN
    SELECT bank_name INTO bank1 FROM accounts WHERE id = sender_id;
    SELECT bank_name INTO bank2 FROM accounts WHERE id = receiver_id;

    IF bank1 = bank2 THEN
        fee = 0;
    ELSE
        fee = 30;
    END IF;

    UPDATE accounts SET credit = credit - amount - fee WHERE id = sender_id;
    UPDATE accounts SET credit = credit + amount WHERE id = receiver_id;
    UPDATE accounts SET credit = credit + fee WHERE id = 4;
END;
$$ LANGUAGE plpgsql;

-- Performing transactions between accounts
-- T1: account 1 send 500 RUB to account 3
-- T2: account 2 send 700 RUB to account 1
-- T3: account 2 send to 100 RUB to account 3
-- Return credit for all account
BEGIN TRANSACTION;
SAVEPOINT T1;
DO
$$
    BEGIN
        PERFORM transaction(1, 3, 500);
    END
$$;

SAVEPOINT T2;
DO
$$
    BEGIN
        PERFORM transaction(2, 1, 700);
    END
$$;

SAVEPOINT T3;
DO
$$
    BEGIN
        PERFORM transaction(2, 3, 100);
    END
$$;

-- Accounts Table after transactions - Ex1 - B
SELECT *
FROM accounts;

ROLLBACK TO T3;
-- SELECT * FROM accounts;
ROLLBACK TO T2;
-- SELECT * FROM accounts;
ROLLBACK TO T1;
-- SELECT * FROM accounts;
END TRANSACTION;

-- Creating new table called "ledger" to show all transactions
DROP TABLE IF EXISTS ledger;
CREATE TABLE ledger
(
    id      SERIAL PRIMARY KEY,
    from_id INTEGER,
    to_id   INTEGER,
    fee     INTEGER,
    amount  INTEGER,
    date    TIMESTAMP
);

-- Redefining the transaction function to keep a record of all transactions in the "ledger" table
CREATE OR REPLACE FUNCTION transaction(sender_id INTEGER, receiver_id INTEGER, amount INTEGER)
    RETURNS VOID AS
$$
DECLARE
    bank1 VARCHAR(255);
    bank2 VARCHAR(255);
    fee   INTEGER;
BEGIN
    SELECT bank_name INTO bank1 FROM accounts WHERE id = sender_id;
    SELECT bank_name INTO bank2 FROM accounts WHERE id = receiver_id;

    IF bank1 = bank2 THEN
        fee = 0;
    ELSE
        fee = 30;
    END IF;

    UPDATE accounts SET credit = credit - amount - fee WHERE id = sender_id;
    UPDATE accounts SET credit = credit + amount WHERE id = receiver_id;
    UPDATE accounts SET credit = credit + fee WHERE id = 4;

    INSERT INTO ledger (from_id, to_id, fee, amount, date) VALUES (sender_id, receiver_id, fee, amount, NOW());
END;
$$ LANGUAGE plpgsql;

-- Performing transactions between accounts
-- T1: account 1 send 500 RUB to account 3
-- T2: account 2 send 700 RUB to account 1
-- T3: account 2 send to 100 RUB to account 3
-- Return credit for all account
BEGIN TRANSACTION;
SAVEPOINT T1;
DO
$$
    BEGIN
        PERFORM transaction(1, 3, 500);
    END
$$;

SAVEPOINT T2;
DO
$$
    BEGIN
        PERFORM transaction(2, 1, 700);
    END
$$;

SAVEPOINT T3;
DO
$$
    BEGIN
        PERFORM transaction(2, 3, 100);
    END
$$;

-- Accounts Table after transactions - Ex1 - C
SELECT *
FROM accounts;
-- Ledger Table after transactions - Ex1 - C
SELECT *
FROM ledger;

ROLLBACK TO T3;
-- SELECT * FROM accounts;
ROLLBACK TO T2;
-- SELECT * FROM accounts;
ROLLBACK TO T1;
-- SELECT * FROM accounts;
END TRANSACTION;
