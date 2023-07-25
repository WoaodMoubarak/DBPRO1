CREATE PROC userlogin
@user varchar(20),
@password varchar(20),
@success bit output,
@type int output,
@block bit output
AS
BEGIN
set @block = '1'
IF EXISTS(
SELECT username,userPassword
FROM SystemUser 
where @user = username AND @password = userPassword)
BEGIN
SET @success  ='1'
IF EXISTS(SELECT username
FROM Fan 
where @user=username)
set @type=0

ELSE
BEGIN
IF EXISTS(SELECT username
FROM StadiumManager
where @user=username)
set @type=1
ELSE
BEGIN
IF EXISTS(SELECT username
FROM ClubRepresentative
where @user=username)
set @type=2
ELSE
BEGIN
IF EXISTS(SELECT username
FROM SystemAdmin
where @user=username)
set @type=4
ELSE
set @type=3
END
END
END
END
ELSE
BEGIN
SET @success ='0'
SET @type = 1
END 
IF EXISTS( SELECT username FROM Fan WHERE FStatus = '0' AND username = @user)
SET @block = '0'
END


