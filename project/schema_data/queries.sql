USE [olympic]
GO

--Query 1:  Total countries attended 2010 Winter Olympic
SELECT COUNT([NOC]) AS [Q1: Total Countries]
FROM attend a
LEFT JOIN olympic_game g
ON a.gID = g.gID
WHERE g.gYear = 2010		--result: 82 countries occurred in 2010 Winter Olympic

--Query 2: Total sport events that 2010 Winter Olympic had
SELECT COUNT([eID]) AS [Q2: Total Events]
FROM has h
LEFT JOIN olympic_game g
ON h.gID = g.gID
WHERE g.gYear = 2010		--result: 86 sport events occurred in 2010 Winter Olympic

--Query 3: # Canadian athletes participated in 2010 Winter Olympic
SELECT COUNT(ap.[aID]) AS [Q3: # Participated athletes]
FROM athlete_participation ap
LEFT JOIN olympic_game g
ON ap.gID = g.gID
LEFT JOIN athlete a
ON ap.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
WHERE tl.NOC = 'CAN' AND g.gYear = 2010		--result: 198 Canadian athletes

--Query 4: # Canadian athletes participated in 2010 Winter Olympic that got medals
SELECT COUNT(DISTINCT w.[aID]) AS [Q4: # Participated athletes got medals]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN medal m
ON w.mID = m.mID
WHERE tl.NOC = 'CAN' AND g.gYear = 2010 AND m.type <> 'NA'		--result: 85 Canadian athletes won medals in 2010 Winter Olympic

--Query 5: Total sport events that Canadian athletes won real medals 
SELECT COUNT(DISTINCT w.eID) AS [Q5: Total sport events]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN medal m
ON w.mID = m.mID
WHERE tl.NOC = 'CAN' AND g.gYear = 2010 AND m.type <> 'NA'		--result: 24 sport events won by Canadian athletes in 2010 Winter Olympic

--Query 5 bonus: Name of these sport events
SELECT e.eName, a.aName, m.type
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN medal m
ON w.mID = m.mID
LEFT JOIN olympic_event e
ON w.eID = e.eID
WHERE tl.NOC = 'CAN' AND g.gYear = 2010 AND m.type <> 'NA'
ORDER BY e.[eName]												--result: 24 sport events won by Canadian athletes in 2010 Winter Olympic

--Query 6: A query returns top 5 sport events the specific country “won” most real medals (except “NA” medal) in a specific Olympic-game.
SELECT TOP 5 e.[eName], COUNT(w.mID) AS [Count medals]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN medal m
ON w.mID = m.mID
LEFT JOIN olympic_event e
ON w.eID = e.eID
WHERE tl.NOC = 'CAN' AND g.gYear = 2010 AND m.type <> 'NA'		--results: top 5 sport events Canadian athletes won most medals in 2010 Winter Olympic
GROUP BY e.[eName]
ORDER BY [Count medals] DESC

--Query 7: A query returns count of gold, silver, bronze medals the specific country “won” (except “NA” medal) in a specific Olympic-game.
SELECT m.type AS [Medal], COUNT(w.mID) AS [Count medals]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN medal m
ON w.mID = m.mID
LEFT JOIN olympic_event e
ON w.eID = e.eID
WHERE tl.NOC = 'CAN' AND g.gYear = 2010 AND m.type <> 'NA'		--results: Gold/Silver/Bronze medal counts that Canadian athletes won in 2010 Winter Olympic
GROUP BY m.type

--Query 8: Total medals Canadian athletes won in 2010 Winter Olympic
SELECT COUNT(w.mID) AS [Q8: Total medals]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN medal m
ON w.mID = m.mID
WHERE tl.NOC = 'CAN' AND g.gYear = 2010 AND m.type <> 'NA'		--result: 89 medals won by Canadian athletes in 2010 Winter Olympic

--Query 9: A query returns top 5 countries that have “won” (count) most (GOLD) medals (except “NA” medal) in a specific Olympic-game.
SELECT TOP 5 c.country, COUNT(w.mID) AS [Count medals]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN country c
ON tl.NOC = c.NOC
LEFT JOIN medal m
ON w.mID = m.mID
WHERE g.gYear = 2010 AND m.type = 'Gold'		--results: top 5 countries won most GOLD medals in 2010 Winter Olympic
GROUP BY c.country
ORDER BY [Count medals] DESC

--Query 10:	A query returns top 5 countries that have “won” (count) most (GOLD) medals (except “NA” medal) in a specific Olympic-game, based on gender Male of athlete.
SELECT TOP 5 c.country, COUNT(w.mID) AS [Count medals]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN country c
ON tl.NOC = c.NOC
LEFT JOIN medal m
ON w.mID = m.mID
WHERE g.gYear = 2010 AND m.type = 'Gold' AND a.asex = 'M'		--results: top 5 countries won most GOLD medals in 2010 Winter Olympic based on gender
GROUP BY c.country
ORDER BY [Count medals] DESC

--Query 11:	A query returns top 5 countries that have “won” (count) most (GOLD) medals (except “NA” medal) in a specific Olympic-game, based on gender Female of athlete.
SELECT TOP 5 c.country, COUNT(w.mID) AS [Count medals]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN country c
ON tl.NOC = c.NOC
LEFT JOIN medal m
ON w.mID = m.mID
WHERE g.gYear = 2010 AND m.type = 'Gold' AND a.asex = 'F'		--results: top 5 countries won most GOLD medals in 2010 Winter Olympic based on gender
GROUP BY c.country
ORDER BY [Count medals] DESC

--Query 12: A query returns total medals from 1986 to 2016 of a specific country.
SELECT c.country AS [Country], g.gYear AS [Year], g.season AS [Season], COUNT(w.mID) AS [Count medals]
FROM win w
LEFT JOIN olympic_game g
ON w.gID = g.gID
LEFT JOIN athlete a
ON w.aID = a.aID
LEFT JOIN team_list tl
ON a.tID = tl.tID
LEFT JOIN country c
ON tl.NOC = c.NOC
LEFT JOIN medal m
ON w.mID = m.mID
WHERE m.type <> 'NA'		--results: Count medals from 1986 to 2016 of countries.
GROUP BY c.country, g.gYear, g.season
ORDER BY [Country], [Year], [Season]

--Query 13:	A query returns top 5 athletes with the most medals “won” from 1986 to 2016 (except “NA” medal).
SELECT TOP 5 a.aName AS [Athleth Name], COUNT(w.mID) AS [Count medals]
FROM win w
LEFT JOIN athlete a
ON w.aID = a.aID
WHERE w.mID <> 4
GROUP BY a.aname
ORDER BY [Count medals] DESC

--Query 14:	A query returns top 5 events with the most medals “won” from 1986 to 2016 (except “NA” medal).
SELECT TOP 5 e.sport AS [Athleth Name], COUNT(w.mID) AS [Count medals]
FROM win w
LEFT JOIN olympic_event e
ON w.eID = e.eID
WHERE w.mID <> 4
GROUP BY e.sport
ORDER BY [Count medals] DESC