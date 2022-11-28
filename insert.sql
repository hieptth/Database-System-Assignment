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
VALUES (1, 1,),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4);
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