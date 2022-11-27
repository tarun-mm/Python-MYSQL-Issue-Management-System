Use Issues_PES1UG20CS462;

-- 1) Show issues that are in issue or in backup_issue.
Select * from issue union (Select * from backup_issue);

-- 2) Show attachments in both attachment and backup_attachment.
Select * from attachment intersect (Select * from backup_attachment);

-- 3) Show issues in issue not in backup_issue.
Select Issue_ID from issue where Issue_ID except (select Issue_ID from backup_issue);

-- 4) Show attachments in attachment not in backup_attachment.
Select Attachment_ID from attachment where Attachment_ID not in (select Attachment_ID from backup_Attachment);