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

# Hiển thị số lượng sinh viên ở từng nơi
select count(StudentID) as SOLUONGHOCSINH, Address
from Student
group by Address;

# Tính điểm trung bình các môn học của mỗi học viên
select S.StudentID, StudentName, AVG(Mark)
from Student S
join Mark M on S.StudentID = M.StudentID
group by StudentID, StudentName;

# Hiển thị những bạn học viên có điểm trung bình các môn học lớn hơn 15
select S.StudentID, StudentName, AVG(Mark) as DIEMTRUNGBINH
from Student S
join Mark M on S.StudentID = M.StudentID
group by StudentID, StudentName
having DIEMTRUNGBINH > 15;

# Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);