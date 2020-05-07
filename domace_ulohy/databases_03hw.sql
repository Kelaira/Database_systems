create synonym Teacher for l.Teacher;
create synonym Student for l.Student;
create synonym Course for l.Course;
create synonym CourseStudent for l.CourseStudent;

drop synonym Teacher;
drop synonym Student;
drop synonym Course;
drop synonym CourseStudent;

select *
from Student

select *
from Teacher

select *
from Course 

select *
from CourseStudent

-- vyber všetkých študentov, ktorí dostali aspoò z jednoho predmetu 
-- známku 1
-- doplò ich ID, Meno a Známku

-- formát 
-- Student(ID, Name, BT_SupervisorID, DT_SupervisorID)
-- CourseStudent(StudentID, CourseID, Grade)
select Student.ID, Student.Name, CourseStudent.Grade
from Student
inner join CourseStudent
on CourseStudent.StudentID = Student.ID
where CourseStudent.Grade = 1

-- vyber všetkých študentov, ktorí už majú známku z 
-- kurzu s menom 'Video Retrieval'
-- doplò ich ID, Meno a Známku

-- formát
-- Student(ID, Name, BT_SupervisorID, DT_SupervisorID)
-- Course(ID, Name, TeacherID)
-- CourseStudent(StudentID, CourseID, Grade)
select Student.ID, Student.Name, CourseStudent.Grade
from Student
inner join CourseStudent
	on CourseStudent.StudentID = Student.ID and CourseStudent.Grade is not null
inner join Course 
	on CourseStudent.CourseID = Course.ID and Course.Name = 'Video retrieval'


-- študenti, ktorí majú ako vedúceho diplomovky niekoho s menom Jane
-- vypíš ich ID a Meno
select Student.ID, Student.Name 
from Student 
inner join Teacher
	on Teacher.ID = Student.DT_SupervisorID
where 
	Teacher.Name = 'Jane'


-- uèitelia, ktorí sú vedúci aj diplomky aj bakalárky nejakého študenta
select distinct Teacher.*
from Teacher 
inner join Student 
	on Student.BT_SupervisorID = Teacher.ID and Student.DT_SupervisorID = Teacher.ID

-- uèitelia s rovnakým menom ako študent, ktorého vedú
select Teacher.ID, Student.ID, Teacher.Name
from Teacher
inner join Student
	on Student.BT_SupervisorID = Teacher.ID or Student.DT_SupervisorID = Teacher.ID
where
	Teacher.Name = Student.Name

-- kurzy vypísané v poradí pod¾a poètu študentov, ktorí sú na nich zapísaní
select Course.Name, T2.Students
from Course 

inner join (
	select CourseID, count(StudentID) as Students
	from CourseStudent
	group by CourseID) as T2
	
	on T2.CourseID = Course.ID

order by T2.Students

-- kurzy striedené pod¾a poètu študentov, ktorí ešte nedostali žiadnu známku
select Course.Name, T2.Students
from Course

inner join(
	select CourseID, count(StudentID) as Students
	from CourseStudent
	where Grade is null
	group by CourseID) as T2

	on T2.CourseID = Course.ID

order by T2.Students

-- študenti, ktorí nenavštevujú žiadne kurzy
select Student.*
from Student
left outer join CourseStudent
	on CourseStudent.StudentID = Student.ID
where 
	CourseStudent.StudentID is null

-- študenti s najvyšším poètom navštevovaných kurzov
select top(1) Student.ID, Student.Name, T2.sCount
from Student
inner join (
		select StudentID, count(CourseID) as sCount
		from CourseStudent
		group by StudentID ) as T2
	on T2.StudentID = Student.ID

order by T2.sCount DESC

-- študenti, ktorí navštevujú Tomove kurzy
select Student.ID, Student.Name 
from Student
inner join CourseStudent 
	on CourseStudent.StudentID = Student.ID
inner join Course 
	on Course.ID = CourseStudent.CourseID
inner join Teacher 
	on Teacher.ID = Course.TeacherID

where Teacher.Name = 'Tom'