USE universitatea

DECLARE @graph TABLE
(
	Current_Node SMALLINT,
	Next_Node SMALLINT
)

INSERT @graph
SELECT 0, NULL
UNION ALL
SELECT 5, 0
UNION ALL
SELECT 1, 0
UNION ALL
SELECT 2, 1
UNION ALL
SELECT 3, 2
UNION ALL
SELECT 4, 2;

WITH CTE_Graph AS(
	SELECT *
	FROM @graph
	WHERE Current_Node = 3
	UNION ALL
	SELECT graph.*
	FROM @graph AS graph
	INNER JOIN CTE_Graph
	ON graph.Current_Node = CTE_Graph.Next_Node
)

SELECT *
FROM CTE_Graph