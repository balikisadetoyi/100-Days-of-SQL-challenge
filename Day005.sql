--DATE:11/04/2026
--QUESTION:Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:
--The scores should be ranked from the highest to the lowest.
--If there is a tie between two scores, both should have the same ranking.
--After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
--Return the result table ordered by score in descending order.

--SOLUTION:
SELECT score,
DENSE_RANK() OVER (ORDER BY Score DESC) AS rank
FROM Scores

--QUESTION:Write a solution to find the first login date for each player.

--SOLUTION:
SELECT player_id,
min(event_date) AS first_login
FROM Activity
GROUP BY player_id
