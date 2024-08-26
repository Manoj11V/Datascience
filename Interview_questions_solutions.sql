
-- Write query that returns number of classes by class size. Order the result by decreasing class size.

select class_id,
       count(student_id) as cnt 
from student_class
group by class_id
order by cnt desc;
select	
    count(class_id) as number_of_classes, 
    class_size
from
    (select 
		class_id, 
        count(student_id) as class_size 
    from student_class
	group by  class_id ) as class_sizes
group by class_size
order by class_size desc;

/*We have a query that returns budget per hour for each class. 
Unfortunately,we missed the fact that a student could be assigned to multiple classes.
 If a student is assigned to multiple classes, budget of this student should be equally split among those classes.
Change the query to fix this oversight.*/
with stu_count as(select student_id,
       count(class_id) as cnt 
from student_class
group by student_id)
select sc.student_id ,sc.class_id,c.`name`,sum(s.budget/stc.cnt)*1.0/c.total_hours as budget_per_hours
from student s
join student_class sc on s.student_id=sc.student_id
join class c on sc.class_id=c.class_id
join stu_count stc on s.student_id=stc.student_id
group by sc.student_id ,
    sc.class_id, 
    c.name, 
    stc.cnt, 
    c.total_hours;
  
/*We have a query that returns students assigned to classes in the "Second district” district. 
Unfortunately, the table `student_class` was accidentally updated without possibility for recovery and 
is no longer usable. We found an alternative table - `student_class_log` -
 that contains a log of changes in this table. Fix the query so it uses this new table. 
PS. It doesn’t make sense to fix `student_class` because the process that corrupts data is
 still not well understood. */
 with new_student_class as (select student_id,class_id
 from student_class_log as scl
 where not exists (select 1 
 from student_class_log as scl_removed
 where scl.student_id=scl_removed.student_id
and scl.class_id=scl_removed.class_id
and scl_removed.event_type ="removed") 
union 
select distinct  student_id,class_id from 
(select student_id,class_id,count(event_type) over (partition by student_id,class_id) as num
from student_class_log) as x
where num>=3 and num % 2 <>0)


SELECT DISTINCT 

       st.student_id

     , st.first_name

     , st.last_name

  FROM district d

       INNER JOIN school s ON s.district_id = d.district_id

          INNER JOIN class c ON c.school_id = s.school_id

            INNER JOIN new_student_class nsc ON nsc.class_id = c.class_id

              INNER JOIN student st ON st.student_id = nsc.student_id

 WHERE d.name = 'Second district'; 
;
