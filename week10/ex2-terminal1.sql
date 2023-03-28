-- Terminal 1
BEGIN TRANSACTION;
-- 1. Displaying the accounts table
SELECT *
FROM users;
-- Output [1]:
-- | username | fullname         | balance | group_id |
-- +----------+------------------+---------+----------+
-- | jones    | Alice Jones      | 82      | 1        |
-- | bitdiddl | Ben Bitdiddle    | 65      | 1        |
-- | mike     | Michael Dole     | 73      | 2        |
-- | alyssa   | Alyssa P. Hacker | 79      | 3        |
-- | bbrown   | Bob Brown        | 100     | 3        |

-- 3. Displaying the accounts table
SELECT *
FROM users;
-- Output [3]:
-- | username | fullname         | balance | group_id |
-- +----------+------------------+---------+----------+
-- | jones    | Alice Jones      | 82      | 1        |
-- | bitdiddl | Ben Bitdiddle    | 65      | 1        |
-- | mike     | Michael Dole     | 73      | 2        |
-- | alyssa   | Alyssa P. Hacker | 79      | 3        |
-- | bbrown   | Bob Brown        | 100     | 3        |

-- 5. Committing the transaction and comparing the accounts table
-- from both sessions again
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

-- 7. Updating the balance for the Alice’s account by +10
UPDATE users
SET balance = balance + 10
WHERE username = 'ajones';

SELECT *
FROM users
WHERE username = 'ajones';
-- Output [7]:
-- | username | fullname         | balance | group_id |
-- | ajones   | Alice Jones      | 92      | 1        |

-- 9. Committing the transaction and comparing the accounts table
COMMIT;
SELECT *
FROM users
WHERE username = 'ajones';
-- Output [9]:
-- | username | fullname         | balance | group_id |
-- | ajones   | Alice Jones      | 92      | 1        |

-- Balance is not 112 because the transaction was not committed
-- from the second terminal session
