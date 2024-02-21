CREATE DATABASE Course3
USE Course3

CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50),
	GroupId INT FOREIGN KEY REFERENCES Groups(GroupId)
)

CREATE TABLE Groups 
(
	GroupId INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50),
	IsDeleted BIT DEFAULT 0
)

CREATE TABLE DeletedStudents
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(50),
	GroupId INT
)

DROP TABLE DeletedStudents

INSERT INTO Groups(Name)
VALUES
('PB302'),
('PF303'),
('CS203'),
('PB301'),
('CS104'),
('PB322')

INSERT INTO Students(Name, GroupId)
VALUES
('NAME1', 1),
('NAME2', 4),
('NAME3', 5),
('NAME4', 6),
('NAME5', 2),
('NAME6', 2),
('NAME7', 1),
('NAME8', 3),
('NAME9', 2)


INSERT INTO Students(Name, GroupId)
VALUES
('NAME11', 1),
('NAME12', 4),
('NAME13', 5),
('NAME14', 6),
('NAME15', 2),
('NAME16', 2),
('NAME17', 1),
('NAME18', 3),
('NAME19', 2)


CREATE TRIGGER TRG_DeleteStudent
ON Students
AFTER Delete
AS
BEGIN
INSERT INTO DeletedStudents
(Name, GroupId)
SELECT deleted.Name, deleted.GroupId FROM deleted
END

SELECT * FROM DeletedStudents


DELETE FROM Students WHERE Id = 13



CREATE TRIGGER TRG_UpdateIsDeleted
ON Groups
INSTEAD OF DELETE
AS
BEGIN
UPDATE Groups
SET IsDeleted = 1
FROM deleted 
WHERE Groups.GroupId = deleted.GroupId
END


DROP  TRIGGER TRG_UpdateIsDeleted

SELECT * FROM Groups 

SELECT * FROM  DeletedStudents