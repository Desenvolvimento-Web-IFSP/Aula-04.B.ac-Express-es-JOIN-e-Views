--1)

SELECT 
    i.ID, 
    i.name, 
    COUNT(t.ID) AS [Number of sections]
FROM dbo.instructor AS i
LEFT OUTER JOIN dbo.teaches AS t ON i.ID = t.ID
GROUP BY i.ID, i.name;

--2)
SELECT 
    i.ID, 
    i.name,
    (SELECT COUNT(*) 
     FROM dbo.teaches AS t 
     WHERE t.ID = i.ID) AS [Number of sections]
FROM dbo.instructor AS i;

--3) 
SELECT 
    s.course_id, 
    s.sec_id, 
    t.ID, 
    s.semester, 
    s.year, 
    ISNULL(i.name, '-') AS name
FROM dbo.section AS s
LEFT OUTER JOIN dbo.teaches AS t 
    ON s.course_id = t.course_id 
    AND s.sec_id = t.sec_id 
    AND s.semester = t.semester 
    AND s.year = t.year
LEFT OUTER JOIN dbo.instructor AS i 
    ON t.ID = i.ID
WHERE s.semester = 'Spring' AND s.year = 2010;

--4)

WITH grade_points(grade, points) AS (
    SELECT 'A+', 4.0 UNION ALL
    SELECT 'A',  3.7 UNION ALL
    SELECT 'A-', 3.4 UNION ALL
    SELECT 'B+', 3.1 UNION ALL
    SELECT 'B',  2.7 UNION ALL
    SELECT 'B-', 2.4 UNION ALL
    SELECT 'C+', 2.1 UNION ALL
    SELECT 'C',  1.7 UNION ALL
    SELECT 'C-', 1.3
)
SELECT 
    s.ID, 
    s.name, 
    c.title, 
    c.dept_name, 
    t.grade, 
    gp.points, 
    c.credits, 
    (gp.points * c.credits) AS [Pontos totais]
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
JOIN grade_points gp ON t.grade = gp.grade;

--5)
    
CREATE VIEW coeficiente_rendimento AS
WITH grade_points(grade, points) AS (
    SELECT 'A+', 4.0 UNION ALL
    SELECT 'A',  3.7 UNION ALL
    SELECT 'A-', 3.4 UNION ALL
    SELECT 'B+', 3.1 UNION ALL
    SELECT 'B',  2.7 UNION ALL
    SELECT 'B-', 2.4 UNION ALL
    SELECT 'C+', 2.1 UNION ALL
    SELECT 'C',  1.7 UNION ALL
    SELECT 'C-', 1.3
)
SELECT 
    s.ID, 
    s.name, 
    c.title, 
    c.dept_name, 
    t.grade, 
    gp.points, 
    c.credits, 
    (gp.points * c.credits) AS [Pontos totais]
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
JOIN grade_points gp ON t.grade = gp.grade;


-- Select da view criada
SELECT * FROM coeficiente_rendimento;