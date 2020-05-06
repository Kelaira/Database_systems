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