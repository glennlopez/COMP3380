USE [A3Q3]
GO

SELECT people.personID, name, activityName FROM people
JOIN activities
ON people.personID = activities.personID

SELECT people.personID, name, activityName FROM people
LEFT JOIN activities
ON people.personID = activities.personID

SELECT people.personID, name, activityName FROM people
RIGHT JOIN activities
ON people.personID = activities.personID

SELECT* FROM people
FULL OUTER JOIN activities
ON people.personID = activities.personID



--SELECT *
--  FROM [A3Q3].[dbo].[activities]

--SELECT *
--  FROM [A3Q3].[dbo].[people]

