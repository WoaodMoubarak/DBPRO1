CREATE DATABASE FootballDB;
--2.1.a
Go
CREATE PROCEDURE  createAllTables
AS
create table SystemUser(
username varchar(20) PRIMARY KEY ,
UserPassword varchar(20)
);

create table Stadium(
ID int IDENTITY,
Stadiumname varchar(20),
Capacity int,
SLocation varchar(20),
StadiumStatus bit,
PRIMARY KEY (ID),
);
create table Club(
ID int IDENTITY,
Clubname varchar(20),
Clublocation varchar(20),
PRIMARY KEY (ID),
);
create table StadiumManager(
ID int IDENTITY,
Sname varchar(20),
username varchar(20),
StadiumID int,
PRIMARY KEY (ID),
FOREIGN KEY (username) REFERENCES SystemUser(username) on UPDATE CASCADE,
FOREIGN KEY (username) REFERENCES SystemUser(username) on DELETE CASCADE,
FOREIGN KEY (StadiumID) REFERENCES  Stadium(ID) on UPDATE CASCADE,
FOREIGN KEY (StadiumID) REFERENCES  Stadium(ID) on DELETE CASCADE,
);
create table ClubRepresentative(
ID int IDENTITY,
Cname varchar(20),
username varchar(20),
CID int
PRIMARY KEY (ID),
FOREIGN KEY (username) REFERENCES SystemUser(username) on UPDATE CASCADE,
FOREIGN KEY (username) REFERENCES SystemUser(username) on DELETE CASCADE,
FOREIGN KEY (CID) REFERENCES Club(ID) on UPDATE CASCADE,
FOREIGN KEY (CID) REFERENCES Club(ID) on DELETE CASCADE,
);
create table Fan(
NationalID varchar(20) ,
Fname varchar(20),
DOB DATETIME,
FAddress varchar(20),
Phone int,

FStatus bit,

username varchar(20),
PRIMARY KEY (NationalID) ,
FOREIGN KEY (username) REFERENCES SystemUser(username) on UPDATE CASCADE,
FOREIGN KEY (username) REFERENCES SystemUser(username) on DELETE CASCADE,
);


create table SportsAssociationManger(
ID int IDENTITY,
Mname varchar(20),
username varchar(20),
PRIMARY KEY (ID),
FOREIGN KEY (username) REFERENCES SystemUser(username) on UPDATE CASCADE,
FOREIGN KEY (username) REFERENCES SystemUser(username) on DELETE CASCADE,
);
create table SystemAdmin(
ID int IDENTITY,
Aname varchar(20),
username varchar(20),
PRIMARY KEY (ID),
FOREIGN KEY (username) REFERENCES SystemUser(username) on UPDATE CASCADE,
FOREIGN KEY (username) REFERENCES SystemUser(username) on DELETE CASCADE,
);
create table Matches(
ID int IDENTITY,
StartTime DATETIME,
EndTime DATETIME,

ClubIDhost int,
ClubIDguest int,
StadiumID int,
PRIMARY KEY (ID),
FOREIGN KEY (StadiumID) REFERENCES Stadium(ID)on UPDATE CASCADE,
FOREIGN KEY (StadiumID) REFERENCES Stadium(ID)on DELETE CASCADE,
FOREIGN KEY (ClubIDhost) REFERENCES Club(ID) on UPDATE CASCADE,
FOREIGN KEY (ClubIDhost) REFERENCES Club(ID) on DELETE CASCADE,
FOREIGN KEY (ClubIDguest) REFERENCES Club(ID) on DELETE NO ACTION,
check( EndTime>StartTime)
);

create table HostRequest(
ID int IDENTITY,
Match_ID int,
RequestStatus varchar(20),
StadiumMID int,
ClubRID int,
PRIMARY KEY (ID),
FOREIGN KEY (Match_ID) REFERENCES Matches(ID) on delete cascade,
FOREIGN KEY (Match_ID) REFERENCES Matches(ID) on update cascade,
FOREIGN KEY (ClubRID) REFERENCES  ClubRepresentative(ID)on DELETE NO ACTION,
FOREIGN KEY (StadiumMID) REFERENCES StadiumManager(ID) on DELETE NO ACTION,
check (RequestStatus IN ( 'unhandled', 'accepted' , 'rejected')),
);
create table Ticket(
ID int IDENTITY,
TicketStatus bit,
MatchID int,
FanID varchar(20),
PRIMARY KEY (ID),
FOREIGN KEY (MatchID) REFERENCES Matches(ID) on UPDATE CASCADE,
FOREIGN KEY (MatchID) REFERENCES Matches(ID) on DELETE CASCADE,
FOREIGN KEY (FanID) REFERENCES Fan(NationalID) on UPDATE CASCADE,
FOREIGN KEY (FanID) REFERENCES Fan(NationalID) on DELETE CASCADE,
);
Go


--2.1.b
create procedure  dropAllTables
AS

drop table Ticket;
drop table HostRequest;
drop table Matches;
drop table StadiumManager;
drop table ClubRepresentative;
drop table Fan;
drop table SportsAssociationManger;
drop table SystemAdmin;
drop table Club;
drop table Stadium;
drop table SystemUser;
GO



--2.1.c
Go
create procedure dropAllProceduresFunctionsViews
AS
drop procedure createAllTables;
drop procedure dropAllTables;
drop procedure clearAllTables;
drop view allAssocManagers;
drop view  allClubRepresentatives
drop view  allStadiumManagers;
drop view  allFans;
drop view  allMatches;
drop view allTickets;
drop view  allClubs;
drop view  allStadiums;
drop view  allRequests;
drop procedure  addAssociationManager;
drop procedure  addNewMatch;
drop view clubsWithNoMatches;
drop procedure  deleteMatch;
drop procedure  deleteMatchesOnStadium;
drop procedure  addClub;
drop procedure  addTicket;
drop procedure deleteClub;
drop procedure  addStadium;
drop procedure deleteStadium;
drop procedure  blockFan;
drop procedure  unblockFan;
drop procedure  addRepresentative
drop function viewAvailableStadiumsOn;
drop procedure addHostRequest;
drop function allUnassignedMatches;
drop procedure addStadiumManager;
drop function allPendingRequests;
drop procedure acceptRequest;
drop procedure rejectRequest;
drop procedure addFan;
drop function upcomingMatchesOfClub;
drop function availableMatchesToAttend;
drop procedure purchaseTicket;
drop procedure updateMatchHost;
drop view matchesPerTeam;
drop view clubsNeverMatched;
drop function clubsNeverPlayed;
drop function matchWithHighestAttendance;
drop function matchesRankedByAttendance;
drop function requestsFromClub;
GO

--2.1.d
Go
create procedure  clearAllTables
AS
DELETE FROM Ticket;
DELETE FROM  HostRequest;
DELETE FROM  Matches;
DELETE FROM  StadiumManager;
DELETE FROM  ClubRepresentative;
DELETE FROM  Fan;
DELETE FROM  SportsAssociationManger;
DELETE FROM SystemAdmin;
DELETE FROM  Club;
DELETE FROM  Stadium;
DELETE FROM SystemUser;

GO



--2.2 -a
GO
CREATE VIEW allAssocManagers AS
SELECT U.username,U.Userpassword ,M.Mname
FROM SportsAssociationManger M inner join SystemUser U on M.username=U.username
--2.2 -b
Go
CREATE VIEW allClubRepresentatives AS
SELECT C.username,U.UserPassword, C.Cname, Club.Clubname
FROM  ClubRepresentative C
inner join Club 
On C.CID = Club.ID
inner join SystemUser U on C.username=U.username

--2.2 -c
Go
CREATE VIEW allStadiumManagers AS
SELECT M.username,U.UserPassword,M.Sname , S.Stadiumname
FROM StadiumManager M
inner join Stadium S
on M.StadiumID = S.ID
inner join SystemUser U on M.username=U.username

--2.2 -d
Go
CREATE VIEW allFans AS
SELECT U.username,U.UserPassword,F.Fname ,F.NationalID , F.DOB  ,F.FStatus
FROM Fan F inner join SystemUser U on F.username=U.username

--2.2 -e
Go
CREATE VIEW allMatches AS
SELECT C1.Clubname AS 'Host Club', C2.Clubname As 'Guest Club' , M.StartTime
FROM Club C1
Inner join Matches M
on C1.ID = M.ClubIDhost
inner join Club C2
On C2.ID = M.ClubIDguest

--2.2 -f
Go
CREATE VIEW allTickets AS
SELECT C1.Clubname AS 'Host name',C2.Clubname AS 'Guest Club',Stadium.Stadiumname , Matches.StartTime
From Ticket 
inner join Matches
on Ticket.MatchID = Matches.ID
inner join Club C1
on Matches.ClubIDhost = C1.ID
inner join Club C2
on Matches.ClubIDguest = C2.ID
inner join Stadium
on Stadium.ID = Matches.StadiumID

--2.2 -g
Go
CREATE VIEW allClubs AS
SELECT Club.Clubname , Club.Clublocation
FROM Club

--2.2 -h
Go
CREATE VIEW allStadiums AS
SELECT Stadiumname , Stadium.SLocation , Stadium.Capacity , StadiumStatus
FROM Stadium

--2.2 -i
Go
CREATE VIEW allRequests AS
SELECT CR.username as 'Club Representative',SM.username AS 'Stadium Manager',R.RequestStatus 
FROM HostRequest R
inner join ClubRepresentative CR
on R.ClubRID = CR.ID
inner join StadiumManager SM
on R.StadiumMID = SM.ID

GO


--2.3.i
Go
create procedure addAssociationManager
@xname varchar(20), @username varchar(20), @xpassword varchar(20),
@success bit output
As
declare @flag varchar(20)
select @flag=U.username
from SystemUser U
Where U.username=@username
if @flag IS NULL
BEGIN
SET @success  ='1'
insert into SystemUser Values (@username,@xpassword); 
insert  into SportsAssociationManger   (Mname,username)Values (@xname,@username);
END
ELSE
SET @success  ='0'
Go 


--2.3.ii
create procedure addNewMatch
@hostName varchar(20),@guestName varchar(20),@startTime DATETIME ,@endTime DATETIME ,@success bit OUTPUT
As

declare @hostclub int
declare @guestclub int

select @hostclub=ID
FROM Club C
WHERE C.clubname=@hostName

select @guestclub=ID
FROM Club C
WHERE C.clubname=@guestName 
if @guestclub IS NOT NULL AND @hostclub IS NOT NULL
BEGIN
SET @success='1'
insert into Matches (StartTime,EndTime,ClubIDhost,ClubIDguest) VALUES (@startTime,@endTime,@hostclub,@guestclub);
END
ELSE
SET @success='0'

--2.3.iii  --view
GO
create VIEW clubsWithNoMatches
AS
select C.Clubname
From Club C
WHERE NOT EXISTS (SELECT *
        FROM Matches M
        WHERE M.ClubIDguest=C.ID OR M.ClubIDhost=C.ID)
        

--2.3.iv
GO
create procedure deleteMatch
@hostClub varchar(20) ,@guestClub varchar(20),@startTime DATETIME ,@endTime DATETIME
AS
declare @hostclub1 int
declare @guestclub1 int
declare @matchID int

select @hostclub1=ID
FROM Club C
WHERE C.clubname=@hostClub

select @guestclub1=ID
FROM Club C
WHERE C.clubname=@guestClub 

DELETE FROM Matches WHERE ClubIDguest=@guestclub1 AND ClubIDhost=@hostclub1 AND StartTime=@startTime AND EndTime=@endTime ;

--2.3.v
GO
create procedure deleteMatchesOnStadium
@stadiumName varchar(20)
AS
declare @stadiumID int
declare @matchID int

select @stadiumID=S.ID
from Stadium S
Where S.Stadiumname=@stadiumName
select @matchID=M.ID
from Matches M
Where StadiumID=@stadiumID AND EndTime>CURRENT_TIMESTAMP

DELETE FROM Matches WHERE ID=@matchID
--2.3.vi
GO 
create procedure addClub
@clubname varchar(20),@Location varchar(20)
AS
insert into Club (Clubname,Clublocation) VALUES(@clubname,@Location);

--2.3.vii
Go
create procedure addTicket
@hostname varchar(20),@guestname varchar(20),@startTime DATETIME
AS
declare @matchID int
declare @hostclub1 int
declare @guestclub1 int

select @hostclub1=ID
FROM Club C
WHERE C.clubname=@hostname

select @guestclub1=ID
FROM Club C
WHERE C.clubname=@guestname 

select @matchID=M.ID
from Matches M
WHERE M.ClubIDguest=@guestclub1 AND M.ClubIDhost=@hostclub1 AND M.StartTime=@startTime

insert into Ticket (TicketStatus,MatchID) values (1,@matchID);

--2.3.viii
Go
create procedure deleteClub
@clubname varchar(20)
AS
declare @clubID int
select @clubID=ID
from Club C
WHERE C.Clubname=@clubname

UPDATE Matches set ClubIDguest=NULL where ClubIDguest=@clubID

DELETE FROM Club
WHERE Clubname=@clubname
--2.3.ix
GO
create procedure addStadium 
@stadiumname varchar(20),@Location varchar(20),@capacity int
AS
insert into Stadium (Stadiumname,SLocation,Capacity) VALUES (@stadiumname,@Location,@capacity);


--2.3.x
GO
create procedure deleteStadium
@Stadiumname varchar(20),@success bit OUTPUT
AS
declare @flag varchar(20)
select @flag=U.Stadiumname
from Stadium U
Where U.Stadiumname=@Stadiumname
if @flag IS NOT NULL
BEGIN
SET @success='1'
delete FROM Stadium
WHERE Stadiumname=@Stadiumname
END
ELSE
SET @success='0'

--2.3.xi
GO
create procedure blockFan
@FanID varchar(20)
AS
UPDATE Fan
SET FStatus='0'
Where NationalID= @FanID

--2.3.xii

GO
create procedure unblockFan
@FanID varchar(20)
AS
UPDATE Fan
SET FStatus='1'
Where NationalID= @FanID

--2.3.xiii
Go
create procedure addRepresentative
@xname varchar(20),@clubname varchar(20),@username varchar(20), @xpassword varchar(20),@success bit output
As
declare @clubID int
select @clubID=C.ID
from CLub C
Where C.Clubname=@clubname

declare @flag varchar(20)
select @flag=U.username
from SystemUser U
Where U.username=@username
if @flag IS NULL
BEGIN 
SET @success='1'
insert into SystemUser Values (@username,@xpassword); 
insert  into ClubRepresentative(Cname,username,CID)Values (@xname,@username,@clubID);
END
ELSE
SET @success='0'
GO

--2.3-xv
GO
CREATE PROCEDURE addHostRequest
 @club varchar(20),
 @stadium varchar(20),
 @startdate datetime,
 @success bit OUTPUT
 AS 
 DECLARE @clubID int
 SELECT @clubID =C.ID
 FROM Club C
 where C.Clubname = @club

 DECLARE @stadiumID int
 SELECT @stadiumID = S.ID
 FROM Stadium S
 WHERE S.Stadiumname = @stadium

 DECLARE @CR varchar(20)
 DECLARE @CRID int
 DECLARE @SM varchar(20)
 DECLARE @SMID int
 SELECT @CRID = C.ID
 FROM ClubRepresentative C
 WHERE C.CID = @clubID

 SELECT  @SMID = S.ID
 FROM StadiumManager S
 WHERE S.StadiumID = @stadiumID

 DECLARE @Match int
 
 SELECT @Match = M.ID
 FROM Matches M
 WHERE (M.ClubIDhost=@clubID)AND M.StartTime = @startdate
 if @stadiumID IS NOT NULL
 BEGIN
 SET @success='1'
 insert into HostRequest (Match_ID,RequestStatus,StadiumMID,ClubRID)values(@Match,'unhandled', @SMID,@CRID)
 END
 ELSE
 SET @success='0'

--2.3.xvii
GO
create procedure addStadiumManager
@xname varchar(20),@stadiumName varchar(20),@username varchar(20),@xpassword varchar(20),@success bit output
AS
declare @stadiumID int
select @stadiumID=S.ID
from Stadium S
WHERE S.Stadiumname=@stadiumName

declare @flag varchar(20)
select @flag=U.username
from SystemUser U
Where U.username=@username
if @flag IS NULL
BEGIN 
SET @success='1'
insert into SystemUser Values (@username,@xpassword); 
insert  into StadiumManager(Sname,username,StadiumID)Values (@xname,@username,@stadiumID);
END
ELSE
SET @success='0'
GO

--new view
GO
CREATE VIEW upcomingMatches
AS
SELECT  C.Clubname AS 'Host Club',C2.Clubname AS 'Guest Club', M.StartTime, M.EndTime
FROM Matches M
INNER JOIN Club C
ON M.ClubIDhost= C.ID
INNER JOIN Club C2 
ON M.ClubIDguest= C2.ID 
WHERE  M.StartTime>= CURRENT_TIMESTAMP 
--new view
GO 
CREATE VIEW alreadyMatches
AS
SELECT  C.Clubname AS 'Host Club',C2.Clubname AS 'Guest Club', M.StartTime, M.EndTime
FROM Matches M
INNER JOIN Club C
ON M.ClubIDhost= C.ID
INNER JOIN Club C2 
ON M.ClubIDguest= C2.ID 
WHERE  M.EndTime< CURRENT_TIMESTAMP 
--2.3.xix
GO 
create procedure acceptRequest
@username varchar(20),@hostclub varchar(20),@guestclub varchar(20),@starttime DATETIME,@success bit OUTPUT
AS 
declare @matchID int
declare @hostclub1 int
declare @guestclub1 int
declare @StadiumID int
DECLARE @SMID int

select @hostclub1=ID
FROM Club C
WHERE C.clubname=@hostclub

select @guestclub1=ID
FROM Club C
WHERE C.clubname=@guestclub 

select @matchID=M.ID
from Matches M
WHERE M.ClubIDguest=@guestclub1 AND M.ClubIDhost=@hostclub1 AND M.StartTime=@starttime

select @StadiumID=M.StadiumID, @SMID = M.ID
from StadiumManager M
where M.username=@username
If @matchID IS NOT NULL AND @hostclub1 IS NOT NULL AND @guestclub1 IS NOT NULL 
BEGIN
SET @success='1'
UPDATE HostRequest
SET RequestStatus='accepted'
Where Match_ID= @matchID AND StadiumMID = @SMID

update Matches set StadiumID=@StadiumID where ID=@matchID

--to generate tickets
DECLARE @stadiumCapacity int
SELECT @stadiumCapacity = S.Capacity
FROM Stadium S
WHERE S.ID = @StadiumID

DECLARE @i int = 0
WHILE @i<@stadiumCapacity
BEGIN
insert into Ticket(TicketStatus,MatchID) values(1,@matchID)
print @i
SET @i = @i +1
END
END
ELSE
SET @success='0'

--2.3.xx
GO 
create procedure rejectRequest
@username varchar(20),@hostclub varchar(20),@guestclub varchar(20),@starttime DATETIME,@success bit OUTPUT
AS 
declare @matchID int
declare @hostclub1 int
declare @guestclub1 int

select @hostclub1=ID
FROM Club C
WHERE C.clubname=@hostclub

select @guestclub1=ID
FROM Club C
WHERE C.clubname=@guestclub 

select @matchID=M.ID
from Matches M
WHERE M.ClubIDguest=@guestclub1 AND M.ClubIDhost=@hostclub1 AND M.StartTime=@starttime

--
DECLARE @SMID int 
SELECT @SMID = SM.ID
FROM StadiumManager SM
WHERE SM.username = @username
If @matchID IS NOT NULL AND @hostclub1 IS NOT NULL AND @guestclub1 IS NOT NULL 
BEGIN 
SET @success='1'
UPDATE HostRequest
SET RequestStatus='rejected'
Where Match_ID= @matchID AND StadiumMID = @SMID
END
ELSE
SET @success='0'

--2.xxi
GO 
create procedure addFan
@name varchar(20),@username varchar(20),@password varchar(20), @nationalID varchar(20), @birthdate DATETIME,@address varchar(20),@number int, @success bit OUTPUT
AS
declare @flag varchar(20)
select @flag=U.username
from SystemUser U
Where U.username=@username
if @flag IS NULL
BEGIN 
SET @success='1'
INSERT INTO SystemUser VALUES (@username,@password);
INSERT INTO Fan (NationalID,Fname,Phone,FAddress,FStatus,DOB,username)values(@nationalID,@name,@number,@address,'1',@birthdate,@username);
END
ELSE
SET @success='0'
GO

--2.3.xxiv
GO 
create procedure purchaseTicket
@nationalID varchar(20),@hostname varchar(20),@guestname varchar(20),@startTime DATETIME
AS
declare @matchID int
declare @hostclub1 int
declare @guestclub1 int
--

select @hostclub1=ID
FROM Club C
WHERE C.clubname=@hostname

select @guestclub1=ID
FROM Club C
WHERE C.clubname=@guestname

select @matchID=M.ID
from Matches M
WHERE M.ClubIDguest=@guestclub1 AND M.ClubIDhost=@hostclub1 AND M.StartTime=@startTime



UPDATE TOP (1) Ticket SET TicketStatus='0',FanID=@nationalID WHERE MatchID=@matchID AND TicketStatus='1'

--2.3.xxv
Go
create procedure updateMatchHost
@hostname varchar(20), @guestname varchar(20),@startTime DATETIME
AS
declare @matchID int
declare @hostclub1 int
declare @guestclub1 int

select @hostclub1=ID
FROM Club C
WHERE C.clubname=@hostname

select @guestclub1=ID
FROM Club C
WHERE C.clubname=@guestname

select @matchID=M.ID
from Matches M
WHERE M.ClubIDguest=@guestclub1 AND M.ClubIDhost=@hostclub1 AND M.StartTime=@startTime

UPDATE Matches SET ClubIDhost=@guestclub1 ,ClubIDguest=@hostclub1 WHERE ID=@matchID ;

--2.3.xxvi
Go
create view matchesPerTeam
AS
SELECT C.Clubname AS 'club name',COUNT(M.ID) AS 'Matches per club'
FROM Club C inner join Matches M ON C.ID=M.ClubIDhost OR C.ID=M.ClubIDguest
WHERE M.EndTime<CURRENT_TIMESTAMP 
GROUP BY C.Clubname

--2.3.xxvii
GO
create view clubsNeverMatched
AS 
SELECT  C1.Clubname AS 'Club1', C2.Clubname AS 'Club2'
FROM Club C1 , Club C2 
WHERE C1.ID < C2.ID AND NOT EXISTS(SELECT *
                                    FROM Matches M 
                                    WHERE ((M.ClubIDhost=C1.ID AND M.ClubIDguest=C2.ID)
                                    OR(M.ClubIDhost=C2.ID AND M.ClubIDguest=C1.ID)))
 Go
 
 -------------------------
 --Functions
 --2.3.xiv
CREATE FUNCTION viewAvailableStadiumsOn
(@date datetime )
Returns table
as return SELECT S.Stadiumname,S.SLocation,S.Capacity FROM Stadium S left outer join Matches M
on S.ID = M.StadiumID
WHERE S.StadiumStatus = 1 AND (@date Not BETWEEN M.StartTime AND M.EndTime or M.StartTime IS NULL)
Go

--2.3.xvi
CREATE FUNCTION allUnassignedMatches
(@hostclub varchar(20))
RETURNS TABLE
AS
RETURN SELECT  C2.Clubname AS 'Guest club', M.StartTime
FROM Club C 
INNER JOIN Matches M 
ON M.ClubIDhost= C.ID 
INNER JOIN Club C2 
ON M.ClubIDguest= C2.ID 
WHERE C.Clubname = @hostclub AND M.StadiumID is NULL





GO
--2.3.xviii
CREATE FUNCTION allPendingRequests
(@Musername varchar(20))
Returns table
AS
Return SELECT CR.Cname ,C.Clubname,M.StartTime
FROM HostRequest H 
INNER JOIN  ClubRepresentative CR
ON H.ClubRID= CR.ID
INNER JOIN Matches M
ON M.ID=H.Match_ID
INNER JOIN Club C
ON M.ClubIDguest=C.ID
INNER JOIN  StadiumManager S
ON H.StadiumMID=S.ID
WHERE S.username=@Musername AND H.RequestStatus = 'unhandled'
GO
--2.3.xxii
CREATE FUNCTION upcomingMatchesOfClub
(@clubname varchar(20))
Returns table 
AS
Return SELECT  C.Clubname ,C2.Clubname AS 'Competeing Club', M.StartTime, S.Stadiumname
FROM Club C 
INNER JOIN Matches M
ON M.ClubIDhost= C.ID OR M.ClubIDguest = C.ID
INNER JOIN Club C2 
ON M.ClubIDguest= C2.ID OR M.ClubIDhost = C2.ID
INNER JOIN Stadium S 
ON S.ID=M.StadiumID
WHERE C.Clubname=@clubname AND  M.StartTime> CURRENT_TIMESTAMP AND C.Clubname<> C2.Clubname
GO



--2.3.xxiii
CREATE FUNCTION availableMatchesToAttend
(@Mdate datetime)
Returns table
AS
Return SELECT C.Clubname AS 'host Club',C2.Clubname AS 'guest club',M.StartTime,S.Stadiumname
FROM Club C 
INNER JOIN Matches M
ON M.ClubIDhost= C.ID 
INNER JOIN Club C2 
ON M.ClubIDguest= C2.ID 
INNER JOIN Stadium S 
ON S.ID=M.StadiumID
inner join Ticket T
on T.MatchID = M.ID
WHERE @Mdate <= M.StartTime AND T.TicketStatus = 1
GROUP BY C.Clubname,C2.Clubname,M.StartTime,S.Stadiumname
GO

--2.3.xxviii
CREATE FUNCTION clubsNeverPlayed 
(@clubname varchar(20))
Returns table
AS
Return 
SELECT C.Clubname
FROM Club C
WHERE NOT EXISTS (SELECT DISTINCT C2.Clubname
                    FROM Club C2
                     INNER JOIN Matches M
                       ON C2.ID = M.ClubIDguest OR C2.ID = M.ClubIDhost
                        WHERE (M.ClubIDguest = C.ID OR M.ClubIDhost  = C.ID )AND C2.Clubname = @clubname) AND C.Clubname <> @clubname 
      
--2.3.xxix
GO
CREATE FUNCTION matchWithHighestAttendance
()
Returns table
AS

RETURN select  top(1) C.Clubname AS 'Host Club',C1.Clubname AS 'Guest Club'
       from Matches M 
       inner join Ticket T 
       on M.ID=T.MatchID 
       inner join Club C 
       on C.ID=M.ClubIDhost
       inner join Club C1 
       on M.ClubIDguest=C1.ID
       WHERE T.TicketStatus = 0
       GROUP BY C.Clubname,C1.Clubname
       ORDER BY COUNT(T.ID) desc
       
     
 GO


--2.3.xxx
CREATE FUNCTION matchesRankedByAttendance
()
Returns table
AS

RETURN SELECT TOP 100 PERCENT C.Clubname AS 'Host Club',C1.Clubname AS 'Guest Club'
       from Matches M 
       inner join Ticket T 
       on M.ID=T.MatchID 
       inner join Club C 
       on C.ID=M.ClubIDhost
       inner join Club C1 
       on M.ClubIDguest=C1.ID
       WHERE T.TicketStatus = 0 AND M.EndTime<CURRENT_TIMESTAMP
       GROUP BY C.Clubname,C1.Clubname
       ORDER BY COUNT(T.ID) desc 
       
     
 GO
 --2.3 xxxi
 CREATE FUNCTION requestsFromClub
(@stadiumname varchar(20),
@clubname varchar(20))
Returns TABLE
AS

Return SELECT DISTINCT C1.Clubname As'host name' , C2.Clubname As' guest name'
FROM Club C1
inner join Matches M
on M.ClubIDhost = C1.ID
inner join Club C2
on M.ClubIDguest = C2.ID
inner join HostRequest R
on R.Match_ID = M.ID
inner join Stadium S
on R.StadiumMID = S.ID
inner join ClubRepresentative CR
on CR.ID = R.ClubRID
WHERE CR.CID = C1.ID AND C1.Clubname = @clubname AND S.Stadiumname = @stadiumname
GO


----------------------------------------------
DECLARE @success bit;
EXEC addAssociationManager @username = 'ahmed',@xname = 'ahmed',@xpassword = 'ghgh', @success = @success output;
EXEC addClub @clubname = 'Ahly',@location = 'cairo'
EXEC addClub @clubname = 'mshmsh',@location = 'cairo'

EXEC addClub @clubname = 'Zamalek',@location = 'cairo'
EXEC addClub @clubname = 'Liverpool',@location = 'UK'
EXEC addClub @clubname = 'Brazil',@location = 'Brazil'
EXEC addClub @clubname = 'Egypt',@location = 'Egypt'
EXEC addClub @clubname = 'Alex',@location = 'Alex'
EXEC addStadium @stadiumname='s1', @location= 'cairo', @capacity =200
EXEC addStadium @stadiumname='s2', @location= 'Alex', @capacity =150
EXEC addStadium @stadiumname='s3', @location= 'UK', @capacity =120
EXEC addStadium @stadiumname='s4', @location= 'USA', @capacity =300
EXEC addStadium @stadiumname='s5', @location= 'Brazil', @capacity =200
EXEC addStadium @stadiumname='rr', @location= 'cairo', @capacity =200

UPDATE Stadium
SET StadiumStatus = 1

UPDATE Stadium
SET StadiumStatus = 0
WHERE Capacity =200


EXEC addRepresentative 'Ali', 'ahly',  'Ali', 'efd',@success output;
EXEC addRepresentative @xname = 'Shahd', @clubname = 'Zamalek', @username = 'Shahd', @xpassword = 'efd', @success = @success output;
EXEC addRepresentative @xname = 'Clara', @clubname = 'Liverpool', @username = 'Clara', @xpassword = 'efd', @success = @success output;
EXEC addRepresentative @xname = 'Layla', @clubname = 'Brazil', @username = 'Layla', @xpassword = 'efd', @success = @success output;
EXEC addRepresentative @xname = 'Noor', @clubname = 'Egypt', @username = 'Noor', @xpassword = 'efd', @success = @success output;



EXEC addStadiumManager @xname = 'Ashraf',@stadiumname = 's1',@username = 'Ashraf', @xpassword = 'sdff', @success = @success output;
EXEC addStadiumManager @xname = 'Adel',@stadiumname = 's2',@username = 'Adel', @xpassword = 'sdff', @success = @success output;
EXEC addStadiumManager @xname = 'Rana',@stadiumname = 's3',@username = 'Rana', @xpassword = 'sdff', @success = @success output;
EXEC addStadiumManager @xname = 'Nada',@stadiumname = 's4',@username = 'Nada', @xpassword = 'sdff', @success = @success output;

EXEC addFan @name = 'Mai',@username ='Mai',@password ='hdhu', @nationalID ='2344', @birthdate = '2002/3/2',@address = 'Cairo',@number = 2324, @success = @success output;
EXEC addFan @name = 'Arwa',@username ='Arwa',@password ='hdhu', @nationalID ='456', @birthdate = '1989/3/2',@address = 'Cairo',@number = 2324, @success = @success output;
EXEC addFan @name = 'Mayar',@username ='Mayar',@password ='hdhu', @nationalID ='123', @birthdate = '1970/3/2',@address = 'Cairo',@number = 2324, @success = @success output;
EXEC addFan @name = 'Amr',@username ='Amr',@password ='hdhu', @nationalID ='586', @birthdate = '1999/3/2',@address = 'Cairo',@number = 2324, @success = @success output;

EXEC addNewMatch @hostname = 'Ahly',@guestname = 'Zamalek',@starttime = '2023/11/12 3:4:5', @endtime = '2023/11/12 4:4:5', @success = @success output;
EXEC addNewMatch @hostname = 'Brazil',@guestname = 'Liverpool',@starttime = '2023/11/12 9:00:00', @endtime = '2023/11/12 10:40:50', @success = @success output;
EXEC addNewMatch @hostname = 'Zamalek',@guestname = 'Liverpool',@starttime = '2025/11/12 9:00:00', @endtime = '2025/11/12 10:40:50', @success = @success output;
EXEC addNewMatch @hostname = 'Ahly',@guestname = 'Zamalek',@starttime = '2002/11/12 9:00:00', @endtime = '2002/11/12 10:40:50', @success = @success output;
EXEC addNewMatch @hostname = 'Zamalek',@guestname = 'Ahly',@starttime = '1990/11/12 9:00:00', @endtime = '1990/11/12 10:40:50', @success = @success output;
EXEC addNewMatch @hostname = 'Zamalek',@guestname = 'Brazil',@starttime = '2025/11/12 9:00:00', @endtime = '2025/11/12 10:00:00', @success = @success output;
EXEC addNewMatch @hostname = 'Egypt',@guestname = 'Brazil',@starttime = '2025/7/7 9:00:00', @endtime = '2025/7/7 10:00:00', @success = @success output;



EXEC addHostRequest  @club = 'Brazil', @stadium = 's1', @startdate  = '2024/11/11 16:00:00', @success = @success output;
EXEC addHostRequest  @club = 'Zamalek', @stadium = 's3', @startdate  =  '2025/11/12 9:00:00', @success = @success output;
EXEC addHostRequest  @club = 'Ahly', @stadium = 's3', @startdate  =  '2023/11/12 3:4:5', @success = @success output;
EXEC addHostRequest  @club = 'Ahly', @stadium = 's3', @startdate  =  '2002/11/12 9:00:00', @success = @success output;
EXEC addHostRequest  @club = 'Zamalek', @stadium = 's2', @startdate  =  '1990/11/12 9:00:00', @success = @success output;
EXEC addHostRequest  @club = 'Zamalek', @stadium = 's2', @startdate  =  '2025/11/12 9:00:00', @success = @success output;
EXEC addHostRequest  @club = 'Egypt', @stadium = 's4', @startdate  =  '2025/7/7 9:00:00', @success = @success output;

EXEC acceptRequest @username = 'Rana',@hostclub = 'Ahly',@guestclub = 'Zamalek',@starttime =  '2023/11/12 3:4:5', @success = @success output;
EXEC acceptRequest @username = 'Rana',@hostclub = 'Ahly',@guestclub = 'Zamalek',@starttime =  '2002/11/12 9:00:00', @success = @success output;
EXEC acceptRequest @username = 'Adel',@hostclub = 'Zamalek',@guestclub = 'Ahly',@starttime =  '1990/11/12 9:00:00', @success = @success output;
EXEC acceptRequest @username = 'Nada',@hostclub = 'Egypt',@guestclub = 'Brazil',@starttime =  '2025/7/7 9:00:00', @success = @success output;

EXEC purchaseTicket @nationalID = '123',@hostname = 'Ahly' , @guestname = 'Zamalek',@starttime = '2023/11/12 3:4:5', @success = @success output;
EXEC purchaseTicket @nationalID = '2344',@hostname = 'Zamalek' , @guestname = 'Ahly',@starttime = '1990/11/12 9:00:00', @success = @success output;

insert into SystemUser values ('Alaa','alaa');
insert into SystemAdmin values('Alaa','Alaa');

select * from SportsAssociationManger
select * from SystemUser
select * from Club
select * from Matches
select * from Stadium
select * from Ticket WHERE Ticket.TicketStatus = 0
select * from Fan
select * from ClubRepresentative
select * from HostRequest
select * from StadiumManager
select * from SystemAdmin

UPDATE Fan
SET FStatus = 0
where NationalID = 123
GO