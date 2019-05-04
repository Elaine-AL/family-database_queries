# how old is Ben Waynes now?
SELECT timestampdiff (
	YEAR, '1967-02-24 00:00:00', NOW()) 
    AS age;

# how much did the family only contribute in total?
SELECT SUM(c.amount)
	FROM ilayn_.contribution c
	RIGHT JOIN ilayn_.family f 
    ON c.idFam = f.id;