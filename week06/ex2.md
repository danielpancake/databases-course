# Original relational table

```sql
CREATE TABLE loan_books
  (
     school    VARCHAR(50),
     teacher   VARCHAR(30),
     course    VARCHAR(40),
     room      VARCHAR(10),
     grade     VARCHAR(15),
     book      VARCHAR(60),
     publisher VARCHAR(30),
     loandate  DATE,

     PRIMARY KEY (???)
  );
```

# Assumptions

For this task, let's assume that following statements are true:

- each `teacher` can work only in one `school`;
- each `teacher` only work with one `grade`;
- each `book` has a unique name (otherwise we should use tuple of `book` and `publisher` as a key);
- further assumptions are expressed in form of functional dependencies.

# 1NF

For a table to be in the First Normal Form, it have to obey four following rules:

- Using row order to convey information is not permitted
- Mixing data types within the same column is not permitted
- Repeating groups are not permitted
- Having a table without a primary key is not permitted

Right now, the table does not have any primary keys. Let us fix it. Assuming that each `teacher` works only in one `school`, let `teacher` and `course` be primary keys.

```sql
CREATE TABLE loan_books
  (
     school    VARCHAR(50),
     teacher   VARCHAR(30),
     course    VARCHAR(40),
     room      VARCHAR(10),
     grade     VARCHAR(15),
     book      VARCHAR(60),
     publisher VARCHAR(30),
     loandate  DATE,

     PRIMARY KEY (teacher, course)
  );
```

# 2NF

For a table to be in the Second Normal Form,

- each non-key attribute must functionally depend on the entire primary key.

Given table has the following functional dependencies:

- { teacher } &rarr; { school, grade, room };
- { book } &rarr; { publisher };
- { course, grade } &rarr; { book };
- { teacher, course } &rarr; { loandate }.

`school`, `grade`, and `room` does not depend on the primary key `course`, thus violating the condition. We can fix this issue, by splitting given table into two:

```sql
CREATE TABLE teachers
  (
     teacher VARCHAR(30),
     school  VARCHAR(50),
     room    VARCHAR(10),
     grade   VARCHAR(15),
     PRIMARY KEY (teacher)
  );

CREATE TABLE loan_books
  (
     teacher   VARCHAR(30),
     course    VARCHAR(40),
     book      VARCHAR(60),
     publisher VARCHAR(30),
     loandate  DATE,
     PRIMARY KEY (teacher, course)
  );
```

# 3NF

For a table to be in the Third Normal Form,

- every attribute in a table should depend on the key, the whole key, and nothing but the key.

In the table `loan_books` we have a dependency { book } &rarr; { publisher } that violates the condition, as `publisher` is not in the primary key.

Again, we can fix this issue, by splitting `loan_books` into two tables:

```sql
CREATE TABLE teachers
  (
     teacher VARCHAR(30),
     school  VARCHAR(50),
     room    VARCHAR(10),
     grade   VARCHAR(15),
     PRIMARY KEY (teacher)
  );

CREATE TABLE books
  (
     book      VARCHAR(60),
     publisher VARCHAR(30),
     PRIMARY KEY (book)
  );

CREATE TABLE loan_books
  (
     teacher  VARCHAR(30),
     course   VARCHAR(40),
     book     VARCHAR(60),
     loandate DATE,
     PRIMARY KEY (teacher, course)
  );
```

# BCNF

For a table to be in the Boyce Codd Normal Form,

- for any dependency A &rarr; B, A should be a super key.

```sql
CREATE TABLE teachers
  (
     teacher VARCHAR(30),
     school  VARCHAR(50),
     room    VARCHAR(10),
     grade   VARCHAR(15),
     PRIMARY KEY (teacher)
  );

CREATE TABLE books
  (
     book_id   INT,
     book_name VARCHAR(60),
     publisher VARCHAR(30),
     PRIMARY KEY (book_id)
  );

CREATE TABLE loaners
  (
     loaner_id INT,
     teacher   VARCHAR(30),
     course    VARCHAR(40),
     PRIMARY KEY (loaner_id)
  );

CREATE TABLE loan_books
  (
     loaner_id INT,
     book_id   INT,
     loandate  DATE,
     PRIMARY KEY (loaner_id)
  );
```
