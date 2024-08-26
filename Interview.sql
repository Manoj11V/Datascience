-- create schema Dbinterview;
CREATE TABLE student

(

student_id   int,

first_name   varchar(200),

last_name    varchar(200),

email        varchar(200),

budget       int

);

INSERT INTO student VALUES (1, 'FirstName_1', 'LastName_1', 'email_1@domain.com', 1000);

INSERT INTO student VALUES (2, 'FirstName_2', 'LastName_2', 'email_2@domain.com', 2000);

INSERT INTO student VALUES (3, 'FirstName_3', 'LastName_3', 'email_3@domain.com', 3000);

INSERT INTO student VALUES (4, 'FirstName_4', 'LastName_4', 'email_4@domain.com', 4000);

INSERT INTO student VALUES (5, 'FirstName_5', 'LastName_5', 'email_5@domain.com', 5000);



CREATE TABLE district

(

district_id   int    ,

name          varchar(200),

address       varchar(1024),

state         varchar(200)

);

INSERT INTO district VALUES (1, 'First district', '', '');

INSERT INTO district VALUES (2, 'Second district', '', '');



CREATE TABLE school

(

school_id    int    ,

district_id  int    ,

name         varchar(200),

description  varchar(1024)

);

INSERT INTO school VALUES (1, 1, 'School #1', '');

INSERT INTO school VALUES (2, 1, 'School #2', '');

INSERT INTO school VALUES (3, 2, 'School #3', '');



CREATE TABLE class

(

class_id     int    ,

name         varchar(200),

school_id    int    ,

total_hours  int    ,

start_date   date   ,

end_date     date   

);

INSERT INTO class VALUES (1, 'ESL', 1, 12, '2020-09-01', '2020-10-31');

INSERT INTO class VALUES (2, 'Math', 1, 48, '2020-11-01', '2021-01-31');

INSERT INTO class VALUES (3, 'Literature', 2, 36, '2020-09-01', '2021-01-01');

INSERT INTO class VALUES (4, 'Physics', 3, 42, '2021-01-01', '2021-03-31');

INSERT INTO class VALUES (5, 'Physics-2', 3, 42, '2021-04-01', '2021-06-15');

INSERT INTO class VALUES (6, 'Environment', 1, 40, '2021-02-01', '2021-06-01');

INSERT INTO class VALUES (7, 'Physical Education', 1, 41, '2021-09-01', '2021-12-01');

CREATE TABLE student_class

(

student_id int,

class_id  int

);

INSERT INTO student_class VALUES (1, 1);

INSERT INTO student_class VALUES (1, 2);

INSERT INTO student_class VALUES (1, 6);

INSERT INTO student_class VALUES (2, 4);

INSERT INTO student_class VALUES (2, 5);

INSERT INTO student_class VALUES (3, 4);

INSERT INTO student_class VALUES (3, 5);

INSERT INTO student_class VALUES (3, 2);

INSERT INTO student_class VALUES (3, 3);

INSERT INTO student_class VALUES (4, 1);

INSERT INTO student_class VALUES (4, 2);

INSERT INTO student_class VALUES (4, 6);



CREATE TABLE student_class_log

(

student_id  int       ,       

class_id    int       ,    

event_type  varchar(200)   ,

timestamp   timestamp 

);



INSERT INTO student_class_log VALUES (1, 1, 'added', '2021-12-01 00:00:01');

INSERT INTO student_class_log VALUES (1, 2, 'added', '2021-12-01 00:00:02');

INSERT INTO student_class_log VALUES (1, 6, 'added', '2021-12-01 00:00:03');

INSERT INTO student_class_log VALUES (2, 4, 'added', '2021-12-01 00:00:04');

INSERT INTO student_class_log VALUES (2, 5, 'added', '2021-12-01 00:00:05');

INSERT INTO student_class_log VALUES (3, 4, 'added', '2021-12-01 00:00:06');

INSERT INTO student_class_log VALUES (3, 5, 'added', '2021-12-01 00:00:07');

INSERT INTO student_class_log VALUES (3, 2, 'added', '2021-12-01 00:00:08');

INSERT INTO student_class_log VALUES (4, 1, 'added', '2021-12-01 00:00:09');

INSERT INTO student_class_log VALUES (4, 2, 'added', '2021-12-01 00:00:10');

INSERT INTO student_class_log VALUES (4, 6, 'added', '2021-12-01 00:00:11');

INSERT INTO student_class_log VALUES (4, 6, 'removed', '2021-12-01 00:00:12');

INSERT INTO student_class_log VALUES (4, 6, 'added', '2021-12-01 00:00:13');

INSERT INTO student_class_log VALUES (5, 5, 'added', '2021-12-01 00:00:14');

INSERT INTO student_class_log VALUES (5, 5, 'removed', '2021-12-01 00:00:15');

INSERT INTO student_class_log VALUES (3, 3, 'added', '2021-12-01 00:00:16');



CREATE TABLE inperson_event

(

student_id       int      ,

class_id         int      ,

has_materials    boolean  ,

is_homework_done boolean  ,

superviser_id    int      ,

event_type       varchar(200),

timestamp        timestamp

);

INSERT INTO inperson_event VALUES(1, 1, true, true, NULL, 'present', '2021-01-01 00:00:00');

INSERT INTO inperson_event VALUES(1, 1, true, true, NULL, 'left_early', '2021-01-01 00:00:01');

INSERT INTO inperson_event VALUES(1, 1, true, true, NULL, 'present', '2021-01-01 00:00:02');

INSERT INTO inperson_event VALUES(1, 1, true, true, NULL, 'left_early', '2021-01-01 00:00:03');

INSERT INTO inperson_event VALUES(1, 2, false, false, NULL, 'absence_unexcused', '2021-01-01 00:00:04');

INSERT INTO inperson_event VALUES(1, 6, false, false, NULL, 'absence_unexcused', '2021-01-01 00:00:05');

INSERT INTO inperson_event VALUES(3, 2, false, false, NULL, 'absence_unexcused', '2021-01-01 00:00:06');

-- 2/4/3 pers: 8 visits + 1 add -> 3 labs + 1 add -> 1 test + 1 add -> grad

INSERT INTO inperson_event VALUES(2, 4, true, false, NULL, 'present', '2021-01-01 00:00:07');

INSERT INTO inperson_event VALUES(2, 4, true, false, NULL, 'present', '2021-01-01 00:00:08');

INSERT INTO inperson_event VALUES(2, 4, true, true, NULL, 'present', '2021-01-01 00:00:09');

INSERT INTO inperson_event VALUES(2, 4, true, true, NULL, 'lab', '2021-01-01 00:00:10');

INSERT INTO inperson_event VALUES(2, 4, true, false, NULL, 'present', '2021-01-01 00:00:11');

INSERT INTO inperson_event VALUES(2, 4, true, false, NULL, 'present', '2021-01-01 00:00:12');

INSERT INTO inperson_event VALUES(2, 4, true, true, NULL, 'present', '2021-01-01 00:00:13');

INSERT INTO inperson_event VALUES(2, 4, true, true, 3, 'lab', '2021-01-01 00:00:14');

INSERT INTO inperson_event VALUES(2, 4, true, false, NULL, 'present', '2021-01-01 00:00:15');

INSERT INTO inperson_event VALUES(2, 4, true, true, NULL, 'present', '2021-01-01 00:00:16');

INSERT INTO inperson_event VALUES(2, 4, true, true, 3, 'lab', '2021-01-01 00:00:17');

INSERT INTO inperson_event VALUES(2, 4, true, false, NULL, 'tested', '2021-01-01 00:00:18');

INSERT INTO inperson_event VALUES(2, 4, true, true, NULL, 'additional_visit', '2021-01-01 00:00:20');

INSERT INTO inperson_event VALUES(2, 4, true, true, 3, 'additional_lab', '2021-01-01 00:00:21');

INSERT INTO inperson_event VALUES(2, 4, true, false, NULL, 'additionally_tested', '2021-01-01 00:00:22');

INSERT INTO inperson_event VALUES(2, 4, false, false, NULL, 'graduated', '2021-01-01 00:00:22');

-- 4/2/1 pers: 6 visits -> 2 labs + 2 field_exercise -> 1 test -> grad

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'present', '2021-01-01 00:00:23');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'present', '2021-01-01 00:00:24');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'lab', '2021-01-01 00:00:25');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'field_exercise', '2021-01-01 00:00:26');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'present', '2021-01-01 00:00:27');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'present', '2021-01-01 00:00:28');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'lab', '2021-01-01 00:00:29');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'field_exercise', '2021-01-01 00:00:30');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'present', '2021-01-01 00:00:31');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'present', '2021-01-01 00:00:32');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'tested', '2021-01-01 00:00:33');

INSERT INTO inperson_event VALUES(4, 2, true, true, NULL, 'graduated', '2021-01-01 00:00:35');

-- 3/5/3 pers: 10 visitis -> 5 labs -> 3 add test -> grad

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:36');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:37');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'lab', '2021-01-01 00:00:38');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:39');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:40');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'lab', '2021-01-01 00:00:41');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'additionally_tested', '2021-01-01 00:00:42');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:43');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:44');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'lab', '2021-01-01 00:00:45');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'additionally_tested', '2021-01-01 00:00:47');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:48');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:49');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'lab', '2021-01-01 00:00:50');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'additionally_tested', '2021-01-01 00:00:51');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:52');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-01 00:00:53');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'lab', '2021-01-01 00:00:54');

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'graduated', '2021-01-01 00:00:55');

-- we need some value on 2021-01-02 for covering BETWEEN solution in Q4

INSERT INTO inperson_event VALUES(3, 5, true, true, NULL, 'present', '2021-01-02 00:00:00');



CREATE TABLE virtual_event

(

student_id    int      ,

class_id      int      ,

platform      varchar(200),  

url           varchar(1024),  

event_type    varchar(200),

timestamp     timestamp

);

INSERT INTO virtual_event VALUES(1, 1, 'Zoom', 'http://esl.lessons.com/1', 'joined', '2021-01-01 00:12:00');

INSERT INTO virtual_event VALUES(1, 1, 'Zoom', 'http://esl.lessons.com/1', 'left_early', '2021-01-01 00:12:01');

-- 4/6/1 virt: 7 visits -> 4 exercises -> 2 tests -> 2 test_passed

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'joined', '2021-01-01 00:12:02');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'exercise', '2021-01-01 00:12:03');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'joined', '2021-01-01 00:12:04');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'exercise', '2021-01-01 00:12:05');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'joined', '2021-01-01 00:12:06');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'exercise', '2021-01-01 00:12:07');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'joined', '2021-01-01 00:12:08');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'exercise', '2021-01-01 00:12:09');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'tested', '2021-01-01 00:12:10');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/1', 'test_passed', '2021-01-01 00:12:11');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/2', 'joined', '2021-01-01 00:12:12');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/2', 'joined', '2021-01-01 00:12:13');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/2', 'joined', '2021-01-01 00:12:14');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/2', 'tested', '2021-01-01 00:12:15');

INSERT INTO virtual_event VALUES(4, 6, 'Zoom', 'http://env.lessons.com/2', 'test_passed', '2021-01-01 00:12:16');

-- 3/3/2 virt: 5 visits -> 2 exercises -> 2 tests -> 2 passed

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/1', 'joined', '2021-01-01 00:12:17');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/1', 'joined', '2021-01-01 00:12:18');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/1', 'joined', '2021-01-01 00:12:19');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/1', 'exercise', '2021-01-01 00:12:20');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/1', 'tested', '2021-01-01 00:12:21');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/1', 'test_passed', '2021-01-01 00:12:22');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/2', 'joined', '2021-01-01 00:12:23');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/2', 'joined', '2021-01-01 00:12:24');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/2', 'exercise', '2021-01-01 00:12:25');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/2', 'tested', '2021-01-01 00:12:26');

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/2', 'test_passed', '2021-01-01 00:12:27');

-- we need some value on 2021-01-02 for covering BETWEEN solution in Q4

INSERT INTO virtual_event VALUES(3, 3, 'Zoom', 'http://lit.lessons.com/2', 'joined', '2021-01-02 00:00:00'); 