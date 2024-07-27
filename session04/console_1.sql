# 1. Liệt kê danh sách sinh viên, gồm các thông tin sau: Mã sinh viên, Họ sinh
# viên, Tên sinh viên, Học bổng. Danh sách sẽ được sắp xếp theo thứ tự Mã
# sinh viên tăng dần
use  quanlydiemsv;
select MaSV,HoSV,TenSV,HocBong from dmsv order by MaSV ;

# 2. Danh sách các sinh viên gồm thông tin sau: Mã sinh viên, họ tên sinh viên,
# Phái, Ngày sinh. Danh sách sẽ được sắp xếp theo thứ tự Nam/Nữ.
select MaSV,concat(HoSV,' ',TenSV), Phai, NgaySinh from dmsv order by Phai  ;

# 3. Thông tin các sinh viên gồm: Họ tên sinh viên, Ngày sinh, Học bổng. Thông
# tin sẽ được sắp xếp theo thứ tự Ngày sinh tăng dần và Học bổng giảm dần.
select concat(HoSV,' ',TenSV),  NgaySinh, HocBong from dmsv order by NgaySinh asc, HocBong desc  ;

# 4. Danh sách các môn học có tên bắt đầu bằng chữ T, gồm các thông tin: Mã
# môn, Tên môn, Số tiết.
    select  MaMH, TenMH, SoTiet from dmmh where TenMH like 'T%';
# 5. Liệt kê danh sách những sinh viên có chữ cái cuối cùng trong tên là I, gồm
# các thông tin: Họ tên sinh viên, Ngày sinh, Phái.
select concat(HoSV,' ',TenSV), NgaySinh, Phai from dmsv where TenSV like '%I';

#
# 6. Danh sách những khoa có ký tự thứ hai của tên khoa có chứa chữ N, gồm
# các thông tin: Mã khoa, Tên khoa.

    select MaKhoa,TenKhoa from dmkhoa where TenKhoa like '_N%';
# 7. Liệt kê những sinh viên mà họ có chứa chữ Thị.
    select * from dmsv where HoSV like '%thi%';
# 8. Cho biết danh sách các sinh viên có học bổng lớn hơn 100,000, gồm các
# thông tin: Mã sinh viên, Họ tên sinh viên, Mã khoa, Học bổng. Danh sách sẽ
# được sắp xếp theo thứ tự Mã khoa giảm dần
select MaSV ,concat(HoSV,' ',TenSV),MaKhoa, HocBong  from dmsv where HocBong >100000;
# 9. Liệt kê các sinh viên có học bổng từ 150,000 trở lên và sinh ở Hà Nội, gồm
# các thông tin: Họ tên sinh viên, Mã khoa, Nơi sinh, Học bổng.
select  concat(HoSV,' ',TenSV),MaKhoa,NoiSinh, HocBong  from dmsv where HocBong > 150000 and NoiSinh = 'Ha Noi';
# 10. Danh sách các sinh viên của khoa Anh văn và khoa Vật lý, gồm các thông
# tin: Mã sinh viên, Mã khoa, Phái.
select MaSV,MaKhoa,Phai from dmsv where MaKhoa in('AV','VL');
# 11. Cho biết những sinh viên có ngày sinh từ ngày 01/01/1991 đến ngày
# 05/06/1992 gồm các thông tin: Mã sinh viên, Ngày sinh, Nơi sinh, Học
# bổng.
    select  * from dmsv where  NgaySinh between '1991-01-01' and '1992-06-05';
# 12. Danh sách những sinh viên có học bổng từ 80.000 đến 150.000, gồm các
# thông tin: Mã sinh viên, Ngày sinh, Phái, Mã khoa.

# 13. Cho biết những môn học có số tiết lớn hơn 30 và nhỏ hơn 45, gồm các thông
# tin: Mã môn học, Tên môn học, Số tiết.

# 14. Liệt kê những sinh viên nam của khoa Anh văn và khoa tin học, gồm các
# thông tin: Mã sinh viên, Họ tên sinh viên, tên khoa, Phái.
    select * from dmsv where Phai = 'nam' and  MaKhoa in ('AV','TH');
# 15. Liệt kê những sinh viên nữ, tên có chứa chữ N
select * from dmsv where Phai = 'nu' and  (TenSV like '%n%' or HoSV like '%n%');