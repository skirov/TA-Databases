DELIMITER $$
DROP PROCEDURE IF EXISTS insert_million_rows $$

CREATE PROCEDURE InsertMilionRowsInDB () 
BEGIN
DECLARE counter INT DEFAULT 0;
	START TRANSACTION;
	WHILE counter < 1000000 DO
		INSERT INTO Logs(LogDate, LogText)
		VALUES(TIMESTAMPADD(DAY, FLOOR(1 + RAND() * 10000), '1990-01-01'),
		CONCAT('Sample text ', counter));
SET counter = counter + 1;
END WHILE;
END $$

CALL InsertMilionRowsInDB ();

SELECT * FROM logs PARTITION(p2);

SELECT * FROM logs WHERE YEAR(LogDate) = 1995;