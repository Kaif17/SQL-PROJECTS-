use i1;
select * from correct_answer;
select * from question_paper_code;
select * from student_info;
select * from student_response;


alter table student_list rename to student_info;


select roll_number, student_name, class, section, school_name ,
sum(result) as math_correct,
sum(wrong) as math_wrong,
sum(yet_to_learn) as math_yet_to_learn,
sum(result)as math_score, 
avg(result) as math_average
from (
select i.*, c.question_paper_code, q.subject,
case when c.correct_option = s.option_marked then 1 else 0 end as result,
case when c.correct_option = s.option_marked then 0 else 1 end as wrong,
case when s.option_marked  = 'e'then 1 else 0 end as yet_to_learn
from correct_answer c 
join student_response s on c.question_paper_code = s.question_paper_code and c.question_number = s.question_number
join question_paper_code q on  c.question_paper_code = q.paper_code 
join student_info  i on i.roll_number = s.roll_number where subject = 'Math') as temp
group by roll_number, student_name, class, section, school_name 
order by roll_number;



select 
sum(result) as science_correct,
sum(wrong) as science_wrong,
sum(yet_to_learn) as science_yet_to_learn,
sum(result)as science_score, 
avg(result) as science_average
from (
select i.*, c.question_paper_code, q.subject,
case when c.correct_option = s.option_marked then 1 else 0 end as result,
case when c.correct_option = s.option_marked then 0 else 1 end as wrong,
case when s.option_marked  = 'e'then 1 else 0 end as yet_to_learn
from correct_answer c 
join student_response s on c.question_paper_code = s.question_paper_code and c.question_number = s.question_number
join question_paper_code q on  c.question_paper_code = q.paper_code 
join student_info  i on i.roll_number = s.roll_number where subject = 'science') as temp
group by roll_number, student_name, class, section, school_name 
order by roll_number;