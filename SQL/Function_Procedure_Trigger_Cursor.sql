USE Issues_PES1UG20CS462;

-- Function to count unsolved issues before a specified date
DELIMITER $$
CREATE FUNCTION unsolved_issue_count(date_to_check DATE)
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE issue_count INT;
  SELECT COUNT(Issue_ID) INTO issue_count
  FROM Issue
  WHERE Issue_date < date_to_check;
  RETURN issue_count;
END; $$
-- DELIMITER;

-- Run the function
-- SELECT unsolved_issue_count(CURDATE());


-- Procedure to update status of an issue
-- DELIMITER $$
CREATE PROCEDURE expired_issue_clear()
BEGIN
  DELETE FROM Issue WHERE Status_ID = 4 OR Status_ID = 5;
END; $$
DELIMITER;

-- Run the procedure
-- CALL expired_issue_clear();


-- Trigger to backup solved issues
DELIMITER $$
CREATE TRIGGER backup_solved_issues
AFTER UPDATE
ON Issue FOR EACH ROW
BEGIN
  REPLACE INTO Backup_Issue SELECT * FROM Issue WHERE Status_ID = 4 OR Status_ID = 5;
  REPLACE INTO Backup_Attachment SELECT Attachment_ID, Attachment_file_name, Attachment_file_type, Attachment.Issue_ID FROM Issue JOIN Attachment ON Issue.Issue_ID = Attachment.Issue_ID WHERE Status_ID = 4 OR Status_ID = 5;
END; $$
-- DELIMITER;

-- Run the trigger
-- UPDATE Issue SET Status_ID = 4;

-- Cursor to
DELIMITER $$
CREATE PROCEDURE get_attachments (IN iss_ID INT, INOUT att_list VARCHAR(3000))
BEGIN
  DECLARE att_name VARCHAR(20);
  DECLARE att_type VARCHAR(10);
  DECLARE rows_empty INT DEFAULT 0;
  DECLARE attach_cursor CURSOR FOR
  SELECT Attachment_file_name, Attachment_file_type FROM Attachment WHERE Issue_ID = iss_ID;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET rows_empty=1;
  OPEN attach_cursor;
  get_attachs : LOOP
    FETCH attach_cursor INTO att_name, att_type;
    IF rows_empty = 1 THEN
      LEAVE get_attachs;
    END IF;
    SET att_list = CONCAT(att_name, ".", att_type, ", ", att_list);
  END LOOP get_attachs;
  CLOSE attach_cursor;
END; $$
-- DELIMITER;

-- Run the Cursor
-- SET @att_list = "";
-- CALL get_attachments(<Issue_ID>, @att_list);
-- SELECT @att_list;