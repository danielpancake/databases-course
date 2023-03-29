
-- 1. Begin transaction
BEGIN TRANSACTION;
SET default_transaction_isolation TO 'read committed';

-- 2. Reading accounts with group_id=2
SELECT * FROM users WHERE group_id=2;
-- | username | fullname     | balance | group_id |
-- +----------+--------------+---------+----------+
-- | mike     | Michael Dole | 73      | 2        |

-- 4. Reading accounts with group_id=2
SELECT * FROM users WHERE group_id=2;
-- | username | fullname     | balance | group_id |
-- +----------+--------------+---------+----------+
-- | mike     | Michael Dole | 73      | 2        |

-- 5. Updating accounts with group_id=2 balances by +15
UPDATE users SET balance=balance+15 WHERE group_id=2;

SELECT * FROM users WHERE group_id=2;
-- | username | fullname         | balance | group_id |
-- +----------+------------------+---------+----------+
-- | mike     | Michael Dole     | 88      | 2        |

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

-- 2. Reading accounts with group_id=2
SELECT * FROM users WHERE group_id=2;
-- | username | fullname     | balance | group_id |
-- +----------+--------------+---------+----------+
-- | mike     | Michael Dole | 73      | 2        |

-- 4. Reading accounts with group_id=2
SELECT * FROM users WHERE group_id=2;
-- | username | fullname     | balance | group_id |
-- +----------+--------------+---------+----------+
-- | mike     | Michael Dole | 73      | 2        |

-- 5. Updating accounts with group_id=2 balances by +15
UPDATE users SET balance=balance+15 WHERE group_id=2;

SELECT * FROM users WHERE group_id=2;
-- | username | fullname         | balance | group_id |
-- +----------+------------------+---------+----------+
-- | mike     | Michael Dole     | 88      | 2        |

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

