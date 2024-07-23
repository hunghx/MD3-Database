# tạo csdl
create database demo02;
# selected đến csdl cần tạo bảng
use demo02;

# tạo bảng
--  bảng lớp học
create table Classes (
    -- khai ba các cột , thuộc tính
    -- thường khóa chính sẽ khai báo đầu tiên
    class_id int primary key auto_increment, -- tự tăng
    class_name varchar(50) not null unique
);
-- mối quan hệ : lớp hoc 1 - n học sinh
-- khóa ngoại ở bảng nhiều sẽ tham chiê tới khóa ngoại của bảng 1
-- bảng học sinh
create table Students(
    student_id char(6) primary key ,
    student_name varchar(50) not null ,
    date_of_birth date not null ,
    sex bit not null ,
    address varchar(50) check ( address in ('Hà nội', 'HCM')) ,
    phone_number char(15) unique  not null ,
    class_id int not null  ,
#     point int check ( point >=0 ),
    -- khóa ngoại
    foreign key (class_id) references classes(class_id)
);

-- sửa bảng
ALTER TABLE  Students
ADD column point int check ( point >=0 );

ALTER  table Students
ADD column image varchar(255) default 'example url';

-- thêm cột mô tả thông tin "bio" có điều kiện độ dài nội dụng ko đc dưới 10 kí tự
-- hàm lấy độ dài length(column)

# primary key : khóa chính - ko  được null và ko trùng lặp
# not null : ko được mang giá trị null
# unique : ko được mang giá trị trùng lặp
# foreign key : khóa ngoại - tham chiếu tới khóa chính của bảng khác
# check : kiểm tra điều kiện dựa trên biểu thức logic
# default : giá trị mặc định

-- thêm dữ liệu vào bảng
insert into classes(class_name)
value ('JV230506');

insert into Students(student_id, student_name, date_of_birth, sex, address, phone_number, class_id)
values
    ('S0011','Nguyễn Văn Y','1999-06-18',1,'Hồ CHí Minh City','09893488276',4),
    ('S0002','Nguyễn Văn B','1999-05-18',0,'Hồ CHí Minh City','0989663826',4),
    ('S0003','Nguyễn Văn C','1999-04-18',1,'Hồ CHí Minh City','0989433376',1),
    ('S0004','Nguyễn Văn D','1999-03-18',1,'Hồ CHí Minh City','0989483776',1)
;
-- Lấy dữ liệu vê
#     SELECT (columns) FROM Table_name
SELECT student_id,student_name,date_of_birth from students;

-- Cập nhật dữ liệu theo điều kiện (khóa chính)
UPDATE Classes set class_name = 'JV240808' where class_id = 4;

-- Xóa d liệu theo điều kiên (khóa chính)
DELETE FROM Classes where class_id = 5; -- chú ý khóa ngoại


# select S.student_id,S.student_name, S.phone_number, C.class_name from Students S join Classes C on S.class_id = C.class_id;

# create table Demo(
#     demo_id int  , -- 11 chữ số 10^11
#     test_id int  , -- 10^11 (10^11-1) ~ 10^22
#     name varchar(255),
#     primary key (demo_id,test_id)
# -- không thể có 2 khóa chinh trở lên trong
# -- 1 bảng nhưng có thể tạo 1 khóa chính từ nhiều cột :
#         -- composite key (khóa chính tổ hợp)
#     );

