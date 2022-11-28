-- @block 1 CHINHANH --
INSERT INTO CHINHANH (Tinh, DiaChi, DienThoai, Email)
VALUES (
        'Alime',
        'OnePiece',
        0901392331,
        'ChienHugo111@gmail.com'
    ),
    (
        'Alimu',
        'Bleach',
        0800281220,
        'DuySocket222@gmail.com'
    ),
    (
        'Alumu',
        'Akame',
        0833281520,
        'LokLok322@gmail.com'
    ),
    (
        'Olumu',
        'Gintama',
        091221120,
        'ZuZu352@gmail.com'
    );
ALTER TABLE CHINHANH
MODIFY COLUMN MaChiNhanh varchar(50);
UPDATE CHINHANH
SET MaChiNhanh = CONCAT('CN', MaChiNhanh);
-- @block 2 HINHANH_CHINHANH --
INSERT INTO HINHANH_CHINHANH (HA_MCN, HinhAnh)
VALUES ('CN1', 'youtube.com'),
    ('CN2', 'amazon.com'),
    ('CN3', 'facebook.com'),
    ('CN4', 'shoppe.vn');
-- @block 3 KHU --
INSERT INTO KHU (Khu_MCN, TenKhu)
VALUES ('CN1', 'THANH HOA'),
    ('CN2', 'BRAZIL'),
    ('CN3', 'HAI PHONG'),
    ('CN4', 'HELL');
-- @block 4 LOAIPHONG --
INSERT INTO LOAIPHONG (TenLoaiPhong, DienTich, SoKhach, MoTaKhac)
VALUES ('PHONG 1', 10.0, 1, 'PHONG CHO NGUOI CO DON'),
    (
        'PHONG 2',
        30.5,
        5,
        'PHONG CHO 5 AE TRONG 1 CHIEC XE TANK'
    ),
    ('PHONG 3', 60.0, 5, '5 AE NHUNG MA GIAU HON'),
    ('PHONG 4', 100.0, 1, 'PHONG CHO TI PHU');
-- @block 5 THONTINGIUONG --
INSERT INTO THONGTINGIUONG (TTG_MLP, KichThuoc, SoLuong)
VALUES (1, 1.0, 1),
    (2, 2.0, 1),
    (3, 3.0, 1),
    (4, 4.0, 1);
-- @block 6 CHINHANH_CO_LOAIPHONG --
INSERT INTO CHINHANH_CO_LOAIPHONG (Co_MLP, Co_MCN, GiaThue)
VALUES (1, 'CN1', 1000),
    (2, 'CN2', 2000),
    (3, 'CN3', 3000),
    (4, 'CN4', 4000);
-- @block 7 PHONG --
INSERT INTO PHONG (Phong_MCN, SoPhong, Phong_TK, Phong_MLP)
VALUES ('CN1', '101', 'THANH HOA', 1),
    ('CN2', '202', 'BRAZIL', 2),
    ('CN3', '303', 'HAI PHONG', 3),
    ('CN4', '404', 'HELL', 4);
--  @block 8 LOAIVATTU --
INSERT INTO LOAIVATTU (MaLoaiVatTu, TenLoaiVatTu)
VALUES (1, 'Vat tu 1'),
    (2, 'Vat tu 2'),
    (3, 'Vat tu 3'),
    (4, 'Vat tu 4');
ALTER TABLE LOAIVATTU
MODIFY COLUMN MaLoaiVatTu VARCHAR(6);
UPDATE LOAIVATTU
SET MaLoaiVatTu = CONCAT('VT', MaLoaiVatTu);
-- @block 9 LOAIVATTU_TRONG_LOAIPHONG --
INSERT INTO LOAIVATTU_TRONG_LOAIPHONG(Trong_MLVT, Trong_MLP, SoLuong)
VALUES ('VT0001', 1, DEFAULT),
    ('VT0002', 2, 2),
    ('VT0003', 3, 3),
    ('VT0004', 4, 4);
-- @block 10 VATTU --
INSERT INTO VATTU (VT_MCN, VT_MLVT, STTVatTu, TinhTrang, VT_SP)
VALUES ('CN1', 'VT0001', 1, 'TOT', 101),
    ('CN2', 'VT0002', 2, 'TOT', 202),
    ('CN3', 'VT0003', 3, 'TOT', 303),
    ('CN4', 'VT0004', 4, 'TOT', 404);
-- @block 11 NHACUNGCAP --
INSERT INTO NHACUNGCAP (MaNhaCungCap, TenNhaCungCap, Email, DiaChi)
VALUES (1, 'Hiep', 'tthh@gmail.com', '1 ltk'),
    (2, 'Khoa', 'nmmk@gmail.com', '2 ltk'),
    (3, 'Duy', 'lkd@gmail.com', '3 ltk'),
    (1000, 'Hung', 'tpmh@gmail.com', '4 ltk');
ALTER TABLE NHACUNGCAP
MODIFY COLUMN MaNhaCungCap VARCHAR(7);
UPDATE NHACUNGCAP
SET MaNhaCungCap = CONCAT('NCC', MaNhaCungCap);
-- @block 12 CUNGCAPVATTU --
INSERT INTO CUNGCAPVATTU (CCVT_MNCC, CCVT_MLVT, CCVT_MCN)
VALUES ('NCC0001', 'VT0001', 'CN1'),
    ('NCC0002', 'VT0002', 'CN2'),
    ('NCC0003', 'VT0003', 'CN3'),
    ('NCC1000', 'VT0004', 'CN4');
-- @block 13 KHACHHANG --
INSERT INTO KHACHHANG (MaKhachHang, CCCD, Email, Username, Diem, Loai)
VALUES (1, '000000', 'a@gmail.com', 'Phuc', 0, 1),
    (2, '111111', 'b@gmail.com', 'NK', 0, 1),
    (3, '222222', 'c@gmail.com', 'HH', 0, 1),
    (4, '333333', 'd@gmail.com', 'TV', 0, 1);
ALTER TABLE KHACHHANG
MODIFY COLUMN MaKhachHang VARCHAR(8);
UPDATE KHACHHANG
SET MaKhachHang = CONCAT ('KH', MaKhachHang);
-- @block 14 GOIDICHVU --
INSERT INTO GOIDICHVU (TenGoi, SoNgay, SoKhach, Gia)
VALUES ('Goi1', 1, 1, 1000),
    ('Goi2', 2, 2, 2000),
    ('Goi3', 3, 3, 3000),
    ('Goi4', 4, 4, 4000);
-- @block 15 HOADONGOIDICHVU --
INSERT INTO HOADONGOIDICHVU (
        HDGDV_MKH,
        HDGDV_TG,
        NgayGioMua,
        NgayBatDau,
        TongTien
    )
VALUES (
        'KH000001',
        'Goi1',
        '2022-1-1 23:59:59',
        '2022-1-2 23:59:59',
        1000
    ),
    (
        'KH000002',
        'Goi2',
        '2022-1-14 23:59:59',
        '2022-1-15 23:59:59',
        2000
    ),
    (
        'KH000003',
        'Goi3',
        '2022-2-26 23:59:59',
        '2022-2-27 23:59:59',
        3000
    ),
    (
        'KH000004',
        'Goi4',
        '2022-9-7 23:59:59',
        '2022-9-7 23:59:59',
        4000
    );
-- @block 16 DONDATPHONG --
INSERT INTO DONDATPHONG (
        NgayGioDat,
        NgayNhanPhong,
        NgayTraPhong,
        TinhTrang,
        TongTien,
        DDP_MKH,
        DDP_TG
    )
VALUES (
        '2022-02-13 01:51:10',
        '2022-06-12 12:09:20',
        '2022-09-19 11:01:05',
        0,
        1000,
        'KH000001',
        'Goi1'
    ),
    (
        '2022-03-03 19:03:34',
        '2022-06-24 04:36:37',
        '2022-09-30 00:38:31',
        1,
        2000,
        'KH000002',
        'Goi2'
    ),
    (
        '2022-04-10 09:00:02',
        '2022-08-18 01:41:43',
        '2022-10-20 07:24:45',
        2,
        3000,
        'KH000003',
        'Goi3'
    ),
    (
        '2022-05-02 02:27:49',
        '2022-09-08 18:37:16',
        '2022-10-30 18:35:19',
        3,
        4000,
        'KH000004',
        'Goi4'
    );
ALTER TABLE DONDATPHONG
MODIFY COLUMN MaDatPhong VARCHAR(16);
UPDATE DONDATPHONG
SET MaDatPhong = CONCAT (
        'DP',
        '28112022',
        MaDatPhong
    );
-- @block 17 PHONGTHUE --
INSERT INTO PHONGTHUE (PT_MDP, PT_MCN, PT_SP)
VALUES ('DP28112022000001', 'CN1', 101),
    ('DP28112022000002', 'CN2', 202),
    ('DP28112022000003', 'CN3', 303),
    ('DP28112022000004', 'CN4', 404);
-- @block 18 HOADON --
INSERT INTO HOADON (ThoiGianNhanPhong, ThoiGianTraPhong, HD_MDP)
VALUES ('12:09:20', '11:01:05', 'DP28112022000001'),
    ('04:36:37', '00:38:31', 'DP28112022000002'),
    ('01:41:43', '07:24:45', 'DP28112022000003'),
    ('18:37:16', '18:35:19', 'DP28112022000004');
ALTER TABLE HOADON
MODIFY COLUMN MaHoaDon VARCHAR(16);
UPDATE HOADON
SET MaHoaDon = CONCAT('HD', '28112022', MaHoaDon);
-- @block 19 DOANHNGHIEP --
INSERT INTO DOANHNGHIEP (MaDoanhNghiep, TenDoanhNghiep)
VALUES (1, 'Google'),
    (2, 'Meta'),
    (3, 'Apple'),
    (4, 'Microsoft');
ALTER TABLE DOANHNGHIEP
MODIFY COLUMN MaDoanhNghiep VARCHAR(6);
UPDATE DOANHNGHIEP
SET MaDoanhNghiep = CONCAT ('DN', MaDoanhNghiep);
-- @block 20 DICHVU --
INSERT INTO DICHVU (MaDichVu, LoaiDichVu, SoKhach, PhongCach, DV_MDN)
VALUES ('DVS001', 'S', 1, 'MX', 'DN0003'),
    ('DVS002', 'S', 1, 'NN', 'DN0003'),
    ('DVS003', 'S', 1, 'CD', 'DN0003'),
    ('DVS004', 'S', 1, 'XH', 'DN0003'),
    ('DVM001', 'M', 1, 'MK', 'DN0004'),
    ('DVM002', 'M', 1, 'NV', 'DN0004'),
    ('DVM003', 'M', 1, 'AT', 'DN0004'),
    ('DVM004', 'M', 1, 'CA', 'DN0004');
-- @block 21 DICHVUSPA --
INSERT INTO DICHVUSPA (DVS_MDV, DichVuSpa)
VALUES ('DVS001', 'MAT XA'),
    ('DVS001', 'NGAM NUOC'),
    ('DVS001', 'CHUOM DA'),
    ('DVS001', 'XONG HOI');
-- @block 22 LOAIHANGDOLUUNIEM --
INSERT INTO LOAIHANGDOLUUNIEM (LHDLN_MDV, LoaiHang)
VALUES ('DVM001', 'MOC KHOA'),
    ('DVM002', 'NON VAI'),
    ('DVM003', 'AO THUN'),
    ('DVM004', 'CHUP ANH');
-- @block 23 THUONGHIEUDOLUUNIEM --
INSERT INTO THUONGHIEUDOLUUNIEM (THDLN_MDV, ThuongHieu)
VALUES ('DVM001', 'GUCCI'),
    ('DVM002', 'DOLCE'),
    ('DVM003', 'COOLMATE'),
    ('DVM004', 'FUMA');
-- @block 24 MATBANG --
INSERT INTO MATBANG (
        MB_MCN,
        STTMatBang,
        ChieuDai,
        ChieuRong,
        GiaThue,
        MoTa,
        MB_MDV,
        TenCuaHang,
        Logo
    )
VALUES (
        'CN1',
        1,
        5,
        10,
        1000,
        'NULL',
        'DVM001',
        'NON SON',
        'A.COM'
    ),
    (
        'CN2',
        2,
        10,
        15,
        2000,
        'NULL',
        'DVM002',
        'PHUC LONG',
        'B.COM'
    ),
    (
        'CN3',
        3,
        15,
        20,
        3000,
        'NULL',
        'DVM003',
        'GOGI',
        'C.COM'
    ),
    (
        'CN4',
        4,
        20,
        25,
        4000,
        'NULL',
        'DVM004',
        'OZ',
        'D.COM'
    );
-- @block 25 HINHANHCUAHANG --
INSERT INTO HINHANHCUAHANG (HACH_MCN, HACH_STTMatBang, HinhAnh)
VALUES ('CN1', 1, 'a.com'),
    ('CN2', 2, 'b.com'),
    ('CN3', 3, 'c.com'),
    ('CN4', 4, 'd.com');
-- @block 26 KHUNGGIOHOATDONG --
INSERT INTO KHUNGGIOHOATDONG (KGHD_MCN, KGHD_STTMatBang, GioBatDau, GioKetThuc)
VALUES ('CN1', 1, '7:00:00', '17:00:00'),
    ('CN2', 2, '7:15:00', '17:00:00'),
    ('CN3', 3, '7:30:00', '17:00:00'),
    ('CN4', 4, '7:45:00', '17:00:00');