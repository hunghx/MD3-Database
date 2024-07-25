
# SELECT : lấy những gì
SELECT curdate();

select 'nam' `giới tính`,0  `số lượng`, 'helo'  `bio`;

# FROM : từ những bảng nào
-- 1 bảng
use  quanlydiemsv;
select * from dmsv;
select  * from dmkhoa;
-- nhiều bảng : có quan hệ
-- các loại join
-- vi dụ : bảng sinh viên và bảng khoa
-- Inner join : lấy dữ dữ liệu ở 2 bảng
select * from dmkhoa kh inner join dmsv s on s.MaKhoa = kh.MaKhoa;

-- Left join : lấy toàn bộ bản ghi của bảng tay trái
select * from dmsv s right join dmkhoa kh  on s.MaKhoa = kh.MaKhoa;
-- Right join :laaysy toàn bộ bản ghi bên tay phải

-- láy danh sách sinh viên bao gồm : mã sinh viên, tên sinh viên , ngày sinh, tên khoa
select s.MaSV `Mã SV`, concat(s.HoSV,' ',s.TenSV) `Tên SV`, s.NgaySinh `Ngay sinh`, kh.TenKhoa `Tên Khoa`
from dmsv s left join dmkhoa kh on s.MaKhoa = kh.MaKhoa;

# Where : điều kiện lấy
-- các điều kiện : =,>,<, >=,<=,<>,in , like , not, between , and, or
-- lấy ra những học sinh có ngày sinh sau ngày 1/1/1992
select  *
from dmsv
where NgaySinh > '1992-01-01';
-- sinh năm 1992 hoăc 1994
select  *
from dmsv
# where year(NgaySinh) = 1990 or year(NgaySinh) = 1992;
where year(NgaySinh) not in (1990,1992);

-- lấy ra những sinh viên có tên bắt đầu bằng chữ h
select  *
from dmsv
where TenSV like 'h_n%';
-- lưu ý trong like : kí tự _ đại diện cho 1 kí tự bất kì , kí tự % đại diện cho 0 hoặc 1 chuỗi

-- láy nhưng sinh viên có năm sinh trong đoạn 1991 - 1995
select  *
from dmsv
where year(NgaySinh) not between 1991 and 1995; -- year(ngaysinh) >=1991 and year(ngaysinh) <= 1995

# Group by : nhóm theo cột nào
-- bài toán : đếm số lượng nam nữ trong danh sach sinh viên
select Phai `Sex`, count(MaSV) `soos lượng` from dmsv
group by Phai;
-- kết luận : nhóm dữ liệu cần ca hàm làm việc với nhóm : count(), sum(), AVG(), MAX(), MIN(), ...

# Having
-- bài toán : tính điểm trung bình của từng học sinh : tên học sinh , điểm trung bình
select s.TenSV, avg(Diem)
from ketqua kq inner join dmsv s on kq.MaSV = s.MaSV
group by s.MaSV
having avg(Diem) > 6.5;
 -- in những sinh viên có điểm trung bình >6.5 ra màn hinh


# Order By : sắp xếp
select s.TenSV, avg(Diem) diem
from ketqua kq inner join dmsv s on kq.MaSV = s.MaSV
group by s.MaSV
having avg(Diem) > 6.5
order by diem asc ; -- asc(ascending) và desc (descending)

-- năm sinh giảm đần
select * from dmsv
order by year(NgaySinh) desc, TenSV desc ;

