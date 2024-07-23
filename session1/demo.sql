# màn hình viets code (scripts) SQL 
# tạo cơ sở dữ liệu (đại diện cho dữ liệu của 1 ứng dụng)
# Cách 1 dùng tool workbench
# chuột phải -> create schema -> đặt tên CSDL và apply
# cách 2  : sử dụng câu lệnh + run : ctrl + Enter
CREATE Database quanlysinhvien; 

# Xóa CSDL 
DROP DAtaBase quanlySINHVIEN;
# selected vào database muốn tạo bảng (click đúp chuột) :( sinh ra lỗi : no database selected)
use quanlysinhvien;

# tạo bảng
create table Student(
        id int ,
        name varchar(100),
        age int 
);

# xóa bảng
DROP table Student;

        -- create database demo2  ;
        -- use demo2;
        -- create table Mark(
        --     id int,
        --     score  double
        -- );-- 
