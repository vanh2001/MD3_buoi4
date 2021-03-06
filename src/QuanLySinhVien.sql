create database QuanLySinhVien;

use QuanLySinhVien;

create table Class(
                      classID int auto_increment,
                      ClassName nvarchar(50),
                      StartDate datetime,
                      Status boolean,
                      primary key (classID)
);

create table Student(
                        StudentID int auto_increment,
                        StudentName nvarchar(50),
                        Address nvarchar(50),
                        Phone nvarchar(10),
                        Status boolean,
                        ClassID int,
                        primary key (StudentID),
                        foreign key (ClassID) references Class (classID)
);

create table Subject(
                        SubID int auto_increment,
                        SubName nvarchar(20),
                        Credit int,
                        Status boolean,
                        primary key (SubID)
);

create table Mark(
                     MarkID int auto_increment,
                     SubID int,
                     StudentID int,
                     Mark int,
                     ExamTimes int,
                     primary key (MarkID),
                     foreign key (SubID) references Subject (SubID),
                     foreign key (StudentID) references Student (StudentID)
);

insert into Class values ('A1', '2008-12-20', 1);
insert into Class (ClassName, StartDate, Status) values ('A2', '2008-12-22', 1);
insert into Class (ClassName, StartDate, Status) values ('B3', current_date, 0);
select * from Class;

insert into Student (StudentName, Address, Phone, Status, ClassID) VALUES ('Hung', 'Ha Noi', '0912113113', 1,1);
insert into Student (StudentName, Address, Status, ClassID) VALUES ('Hoa', 'Hai Phong', 1,1);
insert into Student (StudentName, Address, Phone, Status, ClassID) VALUES ('Manh', 'HCM', '0123123123', 0,2);
select * from Student;

insert into Subject (SubName, Credit, Status) VALUES ('CF', 5, 1);
insert into Subject (SubName, Credit, Status) VALUES ('C', 6, 1);
insert into Subject (SubName, Credit, Status) VALUES ('HDJ', 5, 1);
insert into Subject (SubName, Credit, Status) VALUES ('RDBMS', 10, 1);

insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUES (1,1,8,1);
insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUES (1,2,10,2);
insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUES (2,1,12,1);

# Hi???n th??? s??? l?????ng sinh vi??n ??? t???ng n??i
select count(StudentID) as SOLUONGHOCSINH, Address
from Student
group by Address;

# T??nh ??i???m trung b??nh c??c m??n h???c c???a m???i h???c vi??n
select S.StudentID, StudentName, AVG(Mark)
from Student S
join Mark M on S.StudentID = M.StudentID
group by StudentID, StudentName;

# Hi???n th??? nh???ng b???n h???c vi??n c?? ??i???m trung b??nh c??c m??n h???c l???n h??n 15
select S.StudentID, StudentName, AVG(Mark) as DIEMTRUNGBINH
from Student S
join Mark M on S.StudentID = M.StudentID
group by StudentID, StudentName
having DIEMTRUNGBINH > 15;

# Hi???n th??? th??ng tin c??c h???c vi??n c?? ??i???m trung b??nh l???n nh???t.
SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);

# Hi???n th??? t???t c??? c??c th??ng tin m??n h???c (b???ng subject) c?? credit l???n nh???t.
select SubID, SubName, Credit  as TINCHI
from Subject
group by SubID
having TINCHI >= ALL (select max(Credit) from Subject);

# Hi???n th??? c??c th??ng tin m??n h???c c?? ??i???m thi l???n nh???t.
select S.SubID, S.SubName, MAX(Mark) as DIEMTHI
from Subject S
join Mark M on S.SubID = M.SubID
group by S.SubID, S.SubName
having DIEMTHI >= ALL (select max(Mark) from Mark);

# Hi???n th??? c??c th??ng tin sinh vi??n v?? ??i???m trung b??nh c???a m???i sinh vi??n,
# x???p h???ng theo th??? t??? ??i???m gi???m d???n
select StudentName,Address, Phone, avg(Mark) as DIEMTRUNGBINH
from Student S
join Mark M on S.StudentID = M.StudentID
order by DIEMTRUNGBINH



