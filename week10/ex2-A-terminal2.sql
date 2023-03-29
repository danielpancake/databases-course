-- Terminal 2
BEGIN TRANSACTION;
-- 2. Updating  the username for “Alice Jones” as “ajones”
UPDATE users
SET username = 'ajones'
WHERE username = 'jones';

-- 4. Displaying the accounts table
SELECT *
FROM users;
-- Output [4]:
-- | username | fullname         | balance | group_id |
-- +----------+------------------+---------+----------+
-- | bitdiddl | Ben Bitdiddle    | 65      | 1        |
-- | mike     | Michael Dole     | 73      | 2        |
-- | alyssa   | Alyssa P. Hacker | 79      | 3        |
-- | bbrown   | Bob Brown        | 100     | 3        |
-- | ajones   | Alice Jones      | 82      | 1        |

-- 5. Committing the transaction and comparing the accounts table
-- from both sessions again
COMMIT;
SELECT *
FROM users;
-- Output [5]:
-- | username | fullname         | balance | group_id |
-- +----------+------------------+---------+----------+
-- | bitdiddl | Ben Bitdiddle    | 65      | 1        |
-- | mike     | Michael Dole     | 73      | 2        |
-- | alyssa   | Alyssa P. Hacker | 79      | 3        |
-- | bbrown   | Bob Brown        | 100     | 3        |
-- | ajones   | Alice Jones      | 82      | 1        |

-- 6. Starting a new transaction
BEGIN TRANSACTION;

-- 8. Updating the balance for the Alice’s account by +20
UPDATE users
SET balance = balance + 20
WHERE username = 'ajones';
-- Output [8]:
-- Does not respond until the transaction from the terminal 1
-- is committed.

SELECT *
FROM users
WHERE username = 'ajones';
-- Output [9]:
-- | username | fullname         | balance | group_id |
-- | ajones   | Alice Jones      | 112     | 1        |

-- 10. Rolling back the transaction
ROLLBACK;
SELECT *
FROM users
WHERE username = 'ajones';
-- Output [10]:
-- | username | fullname         | balance | group_id |
-- | ajones   | Alice Jones      | 92      | 1        |

-- +20 is not added to the balance of the account
