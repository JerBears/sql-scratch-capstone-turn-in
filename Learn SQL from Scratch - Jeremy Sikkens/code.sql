Slide 2
 SELECT question, 
 	COUNT(*)
 FROM survey
 GROUP BY question;


Slide 3
SELECT DISTINCT COUNT(q.user_id),
	COUNT(h.user_id),
COUNT(p.user_id),
1.0 * COUNT(h.user_id) / COUNT(q.user_id) AS 'Quiz to Try On',
1.0 * COUNT(p.user_id) / COUNT(h.user_id) AS 'Try On to Purchase',
1.0 * COUNT(p.user_id) / COUNT(q.user_id) AS 'Avg. completion rate’
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON q.user_id = p.user_id
LIMIT 10;


Slide 4
WITH funnels AS
(SELECT DISTINCT q.user_id,
	t.user_id IS NOT NULL AS 'is_home_try_on',
  	p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz as 'q'
LEFT JOIN home_try_on AS 't'
	ON q.user_id = t.user_id
LEFT JOIN purchase AS 'p'
	ON q.user_id = p.user_id)
SELECT COUNT(*) AS 'dist_num_quiz',
	SUM(is_home_try_on) AS 'dist_num_try_on',
  	SUM(is_purchase) AS 'dist_num_purchase',
 	 1.0 * SUM(is_home_try_on) / COUNT(*) AS 'quiz_to_try_on',
 	 1.0 * SUM(is_purchase) / SUM(is_home_try_on) AS 'try_on_to_purchase'
FROM funnels;


Slide 5
SELECT 	COUNT(h.user_id) AS 'Home Try On Users',
  	COUNT(DISTINCT CASE
    		WHEN h.number_of_pairs = '3 pairs' THEN h.user_id
    		END) AS '3 pairs',
  	COUNT(DISTINCT CASE
    		WHEN h.number_of_pairs = '5 pairs' THEN h.user_id   
    		END) AS '5 pairs'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON q.user_id = p.user_id
LIMIT 10;


Slide 6
SELECT 
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '3 pairs' THEN h.user_id
    END) AS 'Purchase after 3 pairs',
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '5 pairs' THEN h.user_id   
    END) AS 'Purchase after 5 pairs'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON q.user_id = p.user_id
WHERE p.user_id IS NOT NULL
GROUP BY h.number_of_pairs
LIMIT 10;

Slide 7
SELECT
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '3 pairs' THEN h.user_id
    END) AS 'Purchase after 3 pairs',
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '5 pairs' THEN h.user_id   
    END) AS 'Purchase after 5 pairs'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON q.user_id = p.user_id
WHERE p.user_id IS NOT NULL
	AND q.style LIKE 'Women%s Styles'
GROUP BY h.number_of_pairs;


Slide 8
SELECT
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '3 pairs' THEN h.user_id
    END) AS 'Purchase after 3 pairs',
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '5 pairs' THEN h.user_id   
    END) AS 'Purchase after 5 pairs'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON q.user_id = p.user_id
WHERE p.user_id IS NOT NULL
	AND q.style LIKE 'Men%s Styles'
GROUP BY h.number_of_pairs;


Slide 9
SELECT
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '3 pairs' THEN h.user_id
    END) AS 'Purchase after 3 pairs',
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '5 pairs' THEN h.user_id   
    END) AS 'Purchase after 5 pairs'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON q.user_id = p.user_id
WHERE p.user_id IS NOT NULL
	AND q.style LIKE '%skip%'
GROUP BY h.number_of_pairs;


Slide 10
SELECT COUNT(user_id) AS '# of Users',
	style AS 'Style'
FROM quiz
WHERE style LIKE 'I%m not sure. Let%s skip it.'
GROUP BY style;


Slide 11
SELECT q.color AS 'Quiz color', 
	COUNT(p.user_id) AS '# of Purchases',
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '3 pairs' THEN h.user_id
    END) AS '3 Pairs',
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '5 pairs' THEN h.user_id   
    END) AS '5 Pairs'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON q.user_id = p.user_id
WHERE p.user_id IS NOT NULL
GROUP BY q.color
ORDER BY COUNT(p.user_id) DESC;


Slide 12
SELECT q.color AS 'Quiz color', 
	COUNT(p.user_id) AS '# of Purchases',
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '3 pairs' THEN h.user_id
    END) AS '3 Pairs',
  COUNT(DISTINCT CASE
    WHEN h.number_of_pairs = '5 pairs' THEN h.user_id   
    END) AS '5 Pairs'
FROM quiz AS q
LEFT JOIN home_try_on AS h
	ON q.user_id = h.user_id
LEFT JOIN purchase AS p
	ON q.user_id = p.user_id
WHERE p.user_id IS NOT NULL
GROUP BY q.color
ORDER BY COUNT(p.user_id) DESC;