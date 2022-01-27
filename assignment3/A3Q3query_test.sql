USE [A3Q3]
GO

SELECT table1.B, table1.C, F, E, A, D FROM table1
JOIN table2
ON table1.B = table2.B AND table1.C = table2.C

SELECT table1.B, table1.C, F, E, A, D FROM table1
LEFT JOIN table2
ON table1.B = table2.B AND table1.C = table2.C

SELECT table2.B, table2.C, F, E, A, D FROM table1
RIGHT JOIN table2
ON table1.B = table2.B AND table1.C = table2.C

SELECT table1.B, table1.C, F, E, A, D FROM table1
FULL OUTER JOIN table2
ON table1.B = table2.B AND table1.C = table2.C

SELECT table2.B, table2.C, F, E, A, D FROM table1
FULL OUTER JOIN table2
ON table1.B = table2.B AND table1.C = table2.C