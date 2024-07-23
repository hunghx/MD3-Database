# chữa bt

create table Category(
    id int primary key  auto_increment,
    name varchar(100) not null  unique ,
    status tinyint default 1 check ( status in (0,1) )
);

create table Room (
    id int primary key  auto_increment,
    name varchar(150) not null ,
    status tinyint default 1 check ( status in (0,1) ),
    price float not null check ( price>= 100000 ),
    salePrice float default 0 ,
    createdDate date default(current_date),
    categoryId int not null ,
    foreign key (categoryId) references Category(id)
);

-- thêm dữ liệu
insert into category(name)
values
    ('VIP'),
    ('Single'),
    ('DOUBLE'),
    ('LUXURY'),
    ('PRESIDENT');

insert into Room (name, price, salePrice, categoryId)
values
    ('P101',1000000,100000,1),
    ('P102',1200000,100000,1),
    ('P104',1300000,100000,1),
    ('P105',1400000,100000,1),
    ('P201',1500000,100000,1),
    ('P202',1600000,100000,1),
    ('P203',1700000,100000,1),
    ('P204',1800000,100000,4),
    ('P505',1900000,100000,3),
    ('P301',2000000,100000,2),
    ('P302',3000000,100000,3),
    ('P303',4000000,100000,5),
    ('P304',5000000,100000,4),
    ('P305',10000000,100000,5);

-- ập nhật
update category set name = 'Hành động' where id = 2;
-- xóa
delete  from room where  id = 16;