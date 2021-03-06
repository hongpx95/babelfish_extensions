select nchar(65);
select nchar(0x1);
select nchar(1) + nchar(2);
select nchar(66) + nchar(0x43);
select nchar(0x55) + nchar(0x103);
GO

-- 0x10FFFF is max value for nchar if the database supports the SC flag
-- See SQL Server documentation for more details
select nchar(1114111);
select nchar(0x10FFFF);
GO

select nchar(1114112);
select nchar(0x110000);
select nchar(0);
select nchar(-1);
GO