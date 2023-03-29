
-- 1. Begin transaction
BEGIN TRANSACTION;
SET default_transaction_isolation TO 'read committed';

-- 3. Moving Bob to group 2
UPDATE users SET group_id = 2 WHERE username='bbrown';

SELECT * FROM users WHERE group_id=2;
-- | username | fullname     | balance | group_id |
-- +----------+--------------+---------+----------+
-- | mike     | Michael Dole | 73      | 2        |
-- | bbrown   | Bob Brown    | 100     | 2        |

-- 6. Commit transaction
COMMIT;

SELECT * FROM users;
-- | username | fullname         | balance | group_id |
-- +----------+------------------+---------+----------+
-- | jones    | Alice Jones      | 82      | 1        |
-- | bitdiddl | Ben Bitdiddle    | 65      | 1        |
-- | alyssa   | Alyssa P. Hacker | 79      | 3        |
-- | bbrown   | Bob Brown        | 100     | 2        |
-- | mike     | Michael Dole     | 88      | 2        |

----------------------------------------------------------------------

-- 1. Begin transaction
BEGIN TRANSACTION;
SET default_transaction_isolation TO 'repeatable read';

-- 3. Moving Bob to group 2
UPDATE users SET group_id = 2 WHERE username='bbrown';
/* WAITING UNTIL COMMIT IN T1 */

SELECT * FROM users WHERE group_id=2;
-- | username | fullname     | balance | group_id |
-- +----------+--------------+---------+----------+
-- | mike     | Michael Dole | 88      | 2        |
-- | bbrown   | Bob Brown    | 100     | 2        |

-- 6. Commit transaction
COMMIT;

SELECT * FROM users;
-- | username | fullname         | balance | group_id |
-- +----------+------------------+---------+----------+
-- | jones    | Alice Jones      | 82      | 1        |
-- | bitdiddl | Ben Bitdiddle    | 65      | 1        |
-- | alyssa   | Alyssa P. Hacker | 79      | 3        |
-- | bbrown   | Bob Brown        | 100     | 2        |
-- | mike     | Michael Dole     | 88      | 2        |
