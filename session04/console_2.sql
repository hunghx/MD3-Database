# use world;
#
# explain analyze select * from city where name = 'New Orleans';
# # -> Filter: (city.`Name` = 'New Orleans')  (cost=417 rows=410) (actual time=2.28..2.48 rows=1 loops=1)
# #     -> Table scan on city  (cost=417 rows=4104) (actual time=0.0684..2.04 rows=4078 loops=1)
#
# # -> Index lookup on city using Name (Name='New Orleans'), with index condition:
# # (city.`Name` = 'New Orleans')  (cost=0.35 rows=1) (actual time=0.0449..0.0465 rows=1
# # loops=1)
#
#
#
# alter table city
# add  index (Name); -- đánh chỉ mục ở cột name
#
# -- in ra những thanhf phố có tên bắt đầu bằng N
# select * from city where Name like 'N%';
#
#
# -- câu lệnh dựa trên kết qur của câu lệnh trc
# create view city_view
# as select * from city where Name like 'N%';
#
# select * from city_view;

-- Stored Procedure
use quanlydiemsv;
-- cạo 1 thủ tục lấy ra danh sách sinh viên theo tên

select * from dmsv where TenSV like 'input';

delimiter //
create procedure findByName (keyword varchar(50))
begin
    select * from dmsv where TenSV like concat('%',keyword,'%');
end
// delimiter
-- gọi thủ tục
call findByName('h');
call findByName('ch');


-- tạo thủ tục thêm mới sinh viên (8 tham số)
delimiter //
create procedure create_sv (
    _masv char(3),
    _hosv varchar(15),
    _TenSV varchar(7),
    _Phai char(7),
    _NgaySinh datetime,
    _NoiSinh varchar(20),
    _MaKhoa char(2),
    _HocBong float
)
begin
   insert into dmsv(MaSV, HoSV, TenSV, Phai, NgaySinh, NoiSinh, MaKhoa, HocBong)
       value (_masv,_hosv,_TenSV,_Phai,_NgaySinh,_NoiSinh,_MaKhoa,_HocBong);
end;
// delimiter
-- tạo thủ tục xóa sinh viên theo mã sinh viên (1 tham số)
select *  from dmsv;
call create_sv('F01','Nguyen Minh','Hung','Nam','2024-09-09','HN','AV',100000);


-- tính số lượng sinh viên nam và nữ trong trường

delimiter //
create procedure count_Nam_Nu (out countNam int, out countNu int)
begin
  select count(*) into countNam from dmsv where Phai = 'nam';
  select count(*) into countNu from dmsv where Phai = 'nu';

end;


-- call
call count_Nam_Nu(@a, @b);
select @a,@b;

-- trigger
-- kiểm tra ngày sinh trươc  khi thêm vào bảng xem có sau ngày hiện tại không
delimiter //
create trigger onBeforeInsertIntoSV
    before insert on dmsv -- trước khi chèn vào bảng dmsv
    for each row  -- thì thực hiện khối lệnh bên dưới
    begin
        -- lấy dữ liệu người dùng truyền vào
        if NEW.NgaySinh > now()
            then signal sqlstate '45000' set message_text = 'Ngay sinh ko thể sau ngay hiện tâij';
            end if;
    end //


delete from dmkhoa where MaKhoa = 'AV';
delete from dmsv where MaSV = 'A01';

-- trc khi xóa sinh viên thì xóa điểm trước
delimiter //
create trigger onBeforeDeleteSV
    before DELETE on dmsv
    for each row
    begin
        -- xóa kết quả của sinh viên đó
        delete from ketqua where MaSV = OLD.MaSV;
    end //

# Yêu cầu 2 ( Sử dụng lệnh SQL tạo View )
# 1.	View v_getRoomInfo Lấy ra danh sách của 10 phòng có giá cao nhất
#     select * from Room order by Price desc limit 10;
# 2.	View v_getBookingList hiển thị danh sách phiếu đặt hàng gồm: Id, BookingDate, Status, CusName, Email, Phone,TotalAmount ( Trong đó cột Status nếu = 0 Chưa duyệt, = 1  Đã duyệt, = 2 Đã thanh toán, = 3 Đã hủy )
select b.Id, b.BookingDate, case Status when 0 then 'chua duỵet'
                                when 1 then 'đa duyệt'
                                    when 2 then 'đã thanh toán'
                                        else 'đã hủy'
                                            end as status
    , c.CusName, c.Email, c.Phone, sum(bd.price) TotalAmount
from Booking b join Customer c on b.CustomerId = c.id
join BookingDetails bd on bd.bookingId = b.Id
where c.id = ?
group by b.id;
# Yêu cầu 3 ( Sử dụng lệnh SQL tạo thủ tục Stored Procedure )

# 1.	Thủ tục addRoomInfo thực hiện thêm mới Room, khi gọi thủ tục truyền đầy đủ các giá trị của bảng Room ( Trừ cột tự động tăng )
# 2.	Thủ tục getBookingByCustomerId hiển thị danh sách phieus đặt phòng của khách hàng theo Id khách hàng gồm: Id, BookingDate, Status, TotalAmount (Trong đó cột Status nếu = 0 Chưa duyệt, = 1  Đã duyệt,, = 2 Đã thanh toán, = 3 Đã hủy), Khi gọi thủ tục truyền vào id cảu khách hàng
# 3.	Thủ tục getRoomPaginate lấy ra danh sách phòng có phân trang gồm: Id, Name, Price, SalePrice, Khi gọi thủ tuc truyền vào limit và page

# Yêu cầu 4 ( Sử dụng lệnh SQL tạo Trigger )
# 1.	Tạo trigger tr_Check_Price_Value sao cho khi thêm hoặc sửa phòng Room nếu nếu giá trị của cột Price > 5000000 thì tự động chuyển về 5000000 và in ra thông báo ‘Giá phòng lớn nhất 5 triệu’

    delimiter //
    create trigger tr_Check_Price_Value
    before insert  on Room
    for each row
    begin
        if NEW.Price > 5000000
            then new.price = 5000000;
            end if;
    end //
# 2.	Tạo trigger tr_check_Room_NotAllow khi thực hiện đặt pòng, nếu ngày đến (StartDate) và ngày đi (EndDate) của đơn hiện tại mà phòng đã có người đặt rồi thì
#

delimiter //
create trigger tr_Check_Price_Value
    before insert  on BookingDetails
    for each row
begin
    declare countBooking int;
    select count(*) into countBooking from BookingDetails b where b.RoomId = New.RoomId and ((NEW.startDate between b.startDate and endDate) or(NEW.endDate between b.startDate and endDate));
        if (countBooking > 0) then
            signal  sqlstate '45000' set message_text ='Phòng này đã có người đặt trong thời gian này, vui lòng chọn thời gian khác';
        end if ;
    end //