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

-- vyber v�etk�ch �tudentov, ktor� dostali aspo� z jednoho predmetu 
-- zn�mku 1
-- dopl� ich ID, Meno a Zn�mku

-- form�t 
-- Student(ID, Name, BT_SupervisorID, DT_SupervisorID)
-- CourseStudent(StudentID, CourseID, Grade)
select Student.ID, Student.Name, CourseStudent.Grade
from Student
inner join CourseStudent
on CourseStudent.StudentID = Student.ID
where CourseStudent.Grade = 1

-- vyber v�etk�ch �tudentov, ktor� u� maj� zn�mku z 
-- kurzu s menom 'Video Retrieval'
-- dopl� ich ID, Meno a Zn�mku

-- form�t
-- Student(ID, Name, BT_SupervisorID, DT_SupervisorID)
-- Course(ID, Name, TeacherID)
-- CourseStudent(StudentID, CourseID, Grade)
select Student.ID, Student.Name, CourseStudent.Grade
from Student
inner join CourseStudent
	on CourseStudent.StudentID = Student.ID and CourseStudent.Grade is not null
inner join Course 
	on CourseStudent.CourseID = Course.ID and Course.Name = 'Video retrieval'


-- �tudenti, ktor� maj� ako ved�ceho diplomovky niekoho s menom Jane
-- vyp� ich ID a Meno
select Student.ID, Student.Name 
from Student 
inner join Teacher
	on Teacher.ID = Student.DT_SupervisorID
where 
	Teacher.Name = 'Jane'


-- u�itelia, ktor� s� ved�ci aj diplomky aj bakal�rky nejak�ho �tudenta
select distinct Teacher.*
from Teacher 
inner join Student 
	on Student.BT_SupervisorID = Teacher.ID and Student.DT_SupervisorID = Teacher.ID

-- u�itelia s rovnak�m menom ako �tudent, ktor�ho ved�
select Teacher.ID, Student.ID, Teacher.Name
from Teacher
inner join Student
	on Student.BT_SupervisorID = Teacher.ID or Student.DT_SupervisorID = Teacher.ID
where
	Teacher.Name = Student.Name

-- kurzy vyp�san� v porad� pod�a po�tu �tudentov, ktor� s� na nich zap�san�
select Course.Name, T2.Students
from Course 

inner join (
	select CourseID, count(StudentID) as Students
	from CourseStudent
	group by CourseID) as T2
	
	on T2.CourseID = Course.ID

order by T2.Students

-- kurzy strieden� pod�a po�tu �tudentov, ktor� e�te nedostali �iadnu zn�mku
select Course.Name, T2.Students
from Course

inner join(
	select CourseID, count(StudentID) as Students
	from CourseStudent
	where Grade is null
	group by CourseID) as T2

	on T2.CourseID = Course.ID

order by T2.Students

-- �tudenti, ktor� nenav�tevuj� �iadne kurzy
select Student.*
from Student
left outer join CourseStudent
	on CourseStudent.StudentID = Student.ID
where 
	CourseStudent.StudentID is null

-- �tudenti s najvy���m po�tom nav�tevovan�ch kurzov
select top(1) Student.ID, Student.Name, T2.sCount
from Student
inner join (
		select StudentID, count(CourseID) as sCount
		from CourseStudent
		group by StudentID ) as T2
	on T2.StudentID = Student.ID

order by T2.sCount DESC

-- �tudenti, ktor� nav�tevuj� Tomove kurzy
select Student.ID, Student.Name 
from Student
inner join CourseStudent 
	on CourseStudent.StudentID = Student.ID
inner join Course 
	on Course.ID = CourseStudent.CourseID
inner join Teacher 
	on Teacher.ID = Course.TeacherID

where Teacher.Name = 'Tom'