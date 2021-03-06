-- procedure in function
CREATE PROCEDURE p2203_inner AS
  SELECT 1
GO

CREATE FUNCTION f2203() RETURNS INT AS
BEGIN
  DECLARE @return INT
  SET @return = 42
  EXEC p2203_inner -- should throw runtime error
  RETURN @return
END
GO

EXEC f2203
GO

-- EXEC function in function -> should be allowed
CREATE FUNCTION f2203_inner() RETURNS INT AS
BEGIN
  RETURN 42;
END
GO

CREATE FUNCTION f2203_2() RETURNS INT AS
BEGIN
  DECLARE @return INT
  EXEC @return = f2203_inner
  RETURN @return
END
GO

DECLARE @ret INT
EXEC @ret = f2203_2
SELECT @ret
GO

CREATE TABLE t2203(a int);
INSERT INTO t2203 VALUES (1);
GO

CREATE FUNCTION f2203_ie() RETURNS INT AS
BEGIN
  INSERT INTO t2203 EXEC p2203_inner;
  RETURN 0;
END
GO

CREATE FUNCTION f2203_i() RETURNS INT AS
BEGIN
  INSERT INTO t2203 VALUES (2);
  RETURN 0;
END
GO

CREATE FUNCTION f2203_u() RETURNS INT AS
BEGIN
  UPDATE t2203 SET a = 2;
  RETURN 0;
END
GO

CREATE FUNCTION f2203_d() RETURNS INT AS
BEGIN
  DELETE FROM t2203;
  RETURN 0;
END
GO

CREATE FUNCTION f2203_cv() RETURNS INT AS
BEGIN
  CREATE INDEX i2203 on t2203(a);
  RETURN 0;
END
GO

CREATE FUNCTION f2203_dt() RETURNS INT AS
BEGIN
  DROP TABLE t2203;
  RETURN 0;
END
GO

-- exec in trigger should be allowed
CREATE TABLE t2203_inserted_by_proc(a int);
GO

CREATE PROCEDURE p2203_2_inner AS
  INSERT INTO t2203_inserted_by_proc VALUES (42);
GO

CREATE TABLE t2203_2(a int);
INSERT INTO t2203_2 VALUES (1);
GO

CREATE TRIGGER tr2203_2 on t2203_2 FOR INSERT AS
BEGIN
  exec p2203_2_inner;
END
GO

INSERT INTO t2203_2 VALUES (2);
GO

SELECT * FROM t2203_2;
GO

-- value should be inserted by proc triggered by trigger.
SELECT * FROM t2203_inserted_by_proc;
GO

DROP PROCEDURE p2203_inner, p2203_2_inner;
GO

DROP FUNCTION f2203, f2203_inner, f2203_2;
GO

DROP TRIGGER tr2203_2;
GO

DROP TABLE t2203, t2203_2, t2203_inserted_by_proc;
GO
