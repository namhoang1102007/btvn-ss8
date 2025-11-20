-- bài 5
create table don_hang (
	id_don_hang INT PRIMARY KEY,
	id_khach_hang INT,
	danh_muc VARCHAR(100),
	tong_tien INT,
	ngay_dat DATE,
	trang_thai VARCHAR(50)
);
INSERT INTO don_hang (id_don_hang, id_khach_hang, danh_muc, tong_tien, ngay_dat,trang_thai ) 
VALUES
(1, 101, 'Dien tu', 15000000, '2023-01-15', 'Hoan thanh'),

(2, 102, 'Thoi trang', 2500000, '2023-01-20', 'Hoan thanh'),

(3, 101, 'Dien tu', 8000000, '2023-02-10', 'Hoan thanh'),

(4, 103, 'Gia dung', 5000000, '2023-02-12', 'Da huy'),

(5, 102, 'Thoi trang', 3000000, '2023-03-05', 'Hoan thanh'),

(6, 101, 'Gia dung', 4500000, '2023-03-08', 'Hoan thanh'),

(7, 104, 'Dien tu', 22000000, '2023-04-18', 'Hoan thanh'),

(8, 103, 'Thoi trang', 1800000, '2023-04-22', 'Hoan thanh'),

(9, 102, 'Dien tu', 12000000, '2022-12-10', 'Hoan thanh');

select a.id_khach_hang,sum(a.tong_tien) as tong_chi_tieu
from don_hang a
group by id_khach_hang
order by tong_chi_tieu desc;

SELECT danh_muc,COUNT(id_don_hang) AS so_luong_don
FROM don_hang
GROUP BY danh_muc;

SELECT id_khach_hang
FROM don_hang
GROUP BY id_khach_hang
HAVING COUNT(id_don_hang) > 1;

SELECT danh_muc,sUM(tong_tien) AS tong_doanh_thu
FROM don_hang
WHERE trang_thai = 'Hoan thanh'  
GROUP BY danh_muc                   
HAVING SUM(tong_tien) > 10000000;
create table giaodich(
	id_giao_dich int primary key,
    id_khach_hang int,
    id_san_pham int,
    ten_san_pham varchar(255),
    danh_muc varchar(100),
    so_luong int,
    don_gia int,
    ngay_giao_dich date,
    khu_vuc varchar(100)
);
insert into giaodich values 
	(1, 101, 1, 'Laptop A', 'Dien tu', 1, 20000000, '2023-01-15', 'Ha Noi'),
	(2, 102, 2, 'Dien thoai B', 'Dien tu', 2, 15000000, '2023-02-20', 'TP.HCM'),
	(3, 101, 3, 'Ao so mi C', 'Thoi trang', 5, 500000, '2023-03-10', 'Ha Noi'),
	(4, 103, 1, 'Laptop A', 'Dien tu', 1, 20000000, '2023-03-12', 'Da Nang'),
	(5, 102, 4, 'Quan jean D', 'Thoi trang', 3, 700000, '2023-04-05', 'TP.HCM'),
	(6, 101, 2, 'Dien thoai B', 'Dien tu', 1, 15000000, '2023-05-08', 'Ha Noi'),
	(7, 104, 5, 'Noi com dien E', 'Gia dung', 2, 2000000, '2023-05-18', 'TP.HCM'),
	(8, 103, 3, 'Ao so mi C', 'Thoi trang', 10, 500000, '2023-06-22', 'Da Nang'),
	(9, 102, 1, 'Laptop A', 'Dien tu', 1, 21000000, '2023-07-10', 'TP.HCM'),
	(10, 105, 6, 'May xay sinh to F', 'Gia dung', 1, 1500000, '2022-12-01', 'Ha Noi'),
	(11, 101, 4, 'Quan jean D', 'Thoi trang', 2, 700000, '2023-08-15', 'Ha Noi');
select * from giaodich;
    -- Tìm các khách hàng VIP của năm 2023: Một khách hàng được coi là VIP nếu họ có tổng chi tiêu trong năm 2023 lớn hơn 30,000,000. Hiển thị id_khach_hang và tong_chi_tieu_2023.
    select id_khach_hang,
		SUM(don_gia) as tong_chi_tieu_2023
        from giaodich
        where year(ngay_giao_dich) = 2023
        group by id_khach_hang
        having SUM(don_gia) > 30000000;

	-- Phân tích hiệu suất sản phẩm 'Laptop A': Tính tổng doanh thu và tổng số lượng đã bán của sản phẩm 'Laptop A' tại mỗi khu vực. Chỉ hiển thị kết quả cho những khu vực có tổng số lượng bán ra lớn hơn hoặc bằng 1.
    select khu_vuc,
		SUM(don_gia * so_luong) as tong_doanh_thu,
        SUM(so_luong) as tong_so_luong -- Không dùng COUNT - COUNT chỉ đếm dòng
        from giaodich
        where ten_san_pham = 'Laptop A'
        group by khu_vuc
        having SUM(so_luong) >= 1;

	-- Xác định các danh mục sản phẩm tiềm năng ở 'TP.HCM': Liệt kê các danh mục sản phẩm tại khu vực 'TP.HCM' có giá trị trung bình mỗi giao dịch lớn hơn 5,000,000. Giá trị giao dịch được tính bằng so_luong * don_gia. Hiển thị danh_muc và gia_tri_trung_binh.
	select danh_muc,
		AVG(so_luong * don_gia) as gia_tri_trung_binh
        from giaodich
        where khu_vuc = 'TP. HCM'
        group by danh_muc
        having AVG(so_luong * don_gia) > 5000000;

	-- Tìm những khách hàng mua đa dạng sản phẩm trong năm 2023: Liệt kê những khách hàng đã mua ít nhất 2 danh mục sản phẩm khác nhau trong năm 2023. Chỉ hiển thị id_khach_hang.
select id_khach_hang
	from giaodich
    where year(ngay_giao_dich) = 2023
    group by id_khach_hang
    having count(distinct danh_muc) >= 2;
    create database ss7;
use ss7;
create table nhat_ky_nguoi_dung(
id_nhat_ky INT PRIMARY KEY,
id_nguoi_dung INT,
id_bai_viet INT,
chuyen_muc VARCHAR(100),
thoi_gian_doc_giay INT,
ngay_ghi_nhat_ky DATE
);

insert into nhat_ky_nguoi_dung
values (1, 1, 101, 'Lap trinh', 300, '2023-10-01'),
(2, 2, 102, 'Thiet ke', 180, '2023-10-01'),
(3, 1, 103, 'Lap trinh', 450, '2023-10-02'),
(4, 3, 104, 'Bao mat', 600, '2023-10-03'),
(5, 2, 101, 'Lap trinh', 240, '2023-10-03'),
(6, 1, 104, 'Bao mat', 500, '2023-10-04'),
(7, 4, 102, 'Thiet ke', 120, '2023-10-04'),
(8, 3, 101, 'Lap trinh', 320, '2023-10-05'),
(9, 2, 105, 'Thiet ke', 200, '2023-10-05');

SELECT id_nguoi_dung, SUM(thoi_gian_doc_giay) AS tong_thoi_gian_doc
FROM nhat_ky_nguoi_dung
GROUP BY id_nguoi_dung
ORDER BY tong_thoi_gian_doc DESC;

SELECT chuyen_muc,COUNT(id_nhat_ky) AS so_luot_doc
FROM nhat_ky_nguoi_dung
GROUP BY chuyen_muc;

SELECT id_bai_viet
FROM nhat_ky_nguoi_dung
GROUP BY id_bai_viet
HAVING COUNT(DISTINCT id_nguoi_dung) > 1;

SELECT id_nguoi_dung,AVG(thoi_gian_doc_giay) AS thoi_gian_trung_binh
FROM nhat_ky_nguoi_dung
GROUP BY id_nguoi_dung
HAVING AVG(thoi_gian_doc_giay) > 350;
-- bai8--
CREATE TABLE ghi_danh (
    id_ghi_danh INT PRIMARY KEY,
    id_hoc_vien INT,
    id_khoa_hoc INT,
    ten_khoa_hoc VARCHAR(255),
    ten_giang_vien VARCHAR(255),
    gia_tien INT,
    ngay_ghi_danh DATE,
    trang_thai_hoan_thanh VARCHAR(50)
);

INSERT INTO ghi_danh (id_ghi_danh, id_hoc_vien, id_khoa_hoc, ten_khoa_hoc, ten_giang_vien, gia_tien, ngay_ghi_danh, trang_thai_hoan_thanh) VALUES
(1, 101, 1, 'SQL cho nguoi moi bat dau', 'Nguyen Van A', 500000, '2023-01-20', 'Da hoan thanh'),
(2, 102, 1, 'SQL cho nguoi moi bat dau', 'Nguyen Van A', 500000, '2023-02-15', 'Chua hoan thanh'),
(3, 103, 2, 'Python co ban', 'Tran Thi B', 700000, '2023-02-25', 'Da hoan thanh'),
(4, 101, 2, 'Python co ban', 'Tran Thi B', 700000, '2023-03-05', 'Da hoan thanh'),
(5, 104, 3, 'Thiet ke Web chuyen nghiep', 'Le Van C', 1200000, '2023-03-10', 'Chua hoan thanh'),
(6, 102, 3, 'Thiet ke Web chuyen nghiep', 'Le Van C', 1200000, '2023-04-12', 'Chua hoan thanh'),
(7, 105, 1, 'SQL cho nguoi moi bat dau', 'Nguyen Van A', 600000, '2023-05-15', 'Da hoan thanh'),
(8, 103, 3, 'Thiet ke Web chuyen nghiep', 'Le Van C', 1200000, '2023-05-20', 'Da hoan thanh'),
(9, 101, 4, 'Machine Learning ung dung', 'Nguyen Van A', 1500000, '2023-06-01', 'Chua hoan thanh'),
(10, 106, 2, 'Python co ban', 'Tran Thi B', 700000, '2022-11-30', 'Da hoan thanh'),
(11, 102, 2, 'Python co ban', 'Tran Thi B', 700000, '2023-07-01', 'Chua hoan thanh');
SELECT
    ten_giang_vien,
    SUM(gia_tien) AS tong_doanh_thu_q1
FROM
    ghi_danh
WHERE
    ngay_ghi_danh >= '2023-01-01' AND ngay_ghi_danh <= '2023-03-31'
GROUP BY
    ten_giang_vien
HAVING
    SUM(gia_tien) > 1000000;
SELECT
    ten_khoa_hoc,
    COUNT(*) AS so_luong_ghi_danh,
    SUM(CASE WHEN trang_thai_hoan_thanh = 'Da hoan thanh' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ty_le_hoan_thanh
FROM
    ghi_danh
GROUP BY
    ten_khoa_hoc
HAVING
    COUNT(*) >= 2 AND SUM(CASE WHEN trang_thai_hoan_thanh = 'Da hoan thanh' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) < 50;
SELECT
    id_hoc_vien,
    COUNT(DISTINCT id_khoa_hoc) AS so_khoa_hoc_da_dang_ky,
    SUM(gia_tien) AS tong_chi_tieu
FROM
    ghi_danh
GROUP BY
    id_hoc_vien
HAVING
    COUNT(DISTINCT id_khoa_hoc) >= 2 AND SUM(gia_tien) > 1000000;
SELECT
    MONTH(ngay_ghi_danh) AS thang_ghi_danh,
    SUM(gia_tien) AS tong_doanh_thu
FROM
    ghi_danh
WHERE
    YEAR(ngay_ghi_danh) = 2023
GROUP BY
    thang_ghi_danh
HAVING
    SUM(gia_tien) > 1000000
ORDER BY
    thang_ghi_danh ASC;