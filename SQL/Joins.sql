Use Issues_PES1UG20CS462;

-- 1) Show list of user names and their issue descriptions.
Select User_name, Issue_desc from User Natural Join Issue;

-- 2) Show attachments of user Varun.
Select Attachment_file_name, Attachment_file_type from User Natural Join Issue Natural Join Attachment WHERE User_name = "Varun";

-- 3) Show the type of issues which are currently under review.
Select Issue_desc, Issue_date, Type_desc from Status Natural Join Issue Natural Join Type Where Status.Status_ID = 2 order by Issue_date;

-- 4) Show student names and number of issues they have.
Select User_name, count(Issue_ID) from Role Natural Join User Natural Join Issue Where Role_name = "Student" Group by User_name;