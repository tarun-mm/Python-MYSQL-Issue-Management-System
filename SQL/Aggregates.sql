Use Issues_PES1UG20CS462;

-- 1) Show oldest issue.
Select Issue_desc, min(Issue_date) from Issue;

-- 2) Show the count of different types of file types in attachments.
Select Count(Distinct Attachment_file_type) as Attachment_file_types from Attachment;

-- 3) Show the count of different file types in attachments.
Select Attachment_file_type, Count(Attachment_ID) as Count from Attachment Group by Attachment_file_type;

-- 4) Show the count of different users according to their roles
Select Role_ID, Role_name, Count(User_ID) from Role Natural Join User Group By Role_ID;