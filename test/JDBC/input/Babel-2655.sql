CREATE TABLE t2218(c1 INT)
INSERT INTO t2218 VALUES (2218)
go

CREATE FUNCTION f2218() RETURNS INT AS BEGIN DECLARE @return INT SET @return = 0 SELECT @return=c1 from t2218 RETURN @return END
go

select f2218()
go

drop function f2218
go

CREATE PROCEDURE p2655
AS
BEGIN
   DECLARE @return INT SET @return = 0 SELECT @return=c1 from t2218
END
GO

exec p2655
go

drop procedure p2655
drop table t2218
go