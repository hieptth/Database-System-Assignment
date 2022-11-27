-- 1 --
CREATE TABLE CHINHANH (
    MaChiNhanh VARCHAR(50) NOT NULL AUTO_INCREMENT,
    Tinh VARCHAR(50) NOT NULL,
    DiaChi VARCHAR(255) NOT NULL,
    DienThoai INT NOT NULL,
    Email VARCHAR(50) NOT NULL,
    PRIMARY KEY (MaChiNhanh)
);

-- 2 --
CREATE TABLE HINHANH_CHINHANH (
    HA_MCN INT NOT NULL,
    HinhAnh BLOB NOT NULL,
    PRIMARY KEY (HA_MCN,HinhAnh),
    FOREIGN KEY (HA_MCN)
		REFERENCES CHINHANH(MaChiNhanh)
);

-- 3 --
CREATE TABLE KHU (
    Khu_MCN VARCHAR(50) NOT NULL,
    TenKhu VARCHAR(50) NOT NULL,
    PRIMARY KEY (Khu_MCN , TenKhu),
    FOREIGN KEY (Khu_MCN)
        REFERENCES CHINHANH (MaChiNhanh)
);

-- 4 --
CREATE TABLE LOAIPHONG (
    MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
    TenLoaiPhong VARCHAR(50) NOT NULL,
    DienTich DECIMAL(3 , 2 ) NOT NULL,
    SoKhach INT UNIQUE CHECK (SoKhach > 0 AND SoKhach < 11),
    MoTaKhac VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (MaLoaiPhong)
);

-- 5 --
CREATE TABLE THONGTINGIUONG (
    TTG_MLP INT NOT NULL,
    KichThuoc DECIMAL(1 , 1 ) NOT NULL,
    SoLuong INT NOT NULL DEFAULT 1 CHECK(SoLuong > 0 and SoLuong < 11) ,
    PRIMARY KEY (TTG_MLP, KichThuoc),
    FOREIGN KEY (TTG_MLP) REFERENCES LOAIPHONG(MaLoaiPhong)
);

-- 6 --
CREATE TABLE CHINHANH_CO_LOAIPHONG (
    Co_MLP INT NOT NULL,
    Co_MCN VARCHAR(50) NOT NULL,
    GiaThue INT NOT NULL,
    PRIMARY KEY (Co_MLP , Co_MCN),
    FOREIGN KEY (Co_MLP)
        REFERENCES LOAIPHONG (MaLoaiPhong),
    FOREIGN KEY (Co_MCN)
        REFERENCES CHINHANH (MaChiNhanh)
);

-- 7 --
CREATE TABLE PHONG (
    Phong_MCN VARCHAR(50) NOT NULL,
    SoPhong VARCHAR(3) NOT NULL,
    Phong_TK VARCHAR(50) NOT NULL,
    Phong_MLP INT NOT NULL,
    FOREIGN KEY (Phong_MCN)
        REFERENCES CHINHANH (MaChiNhanh),
    FOREIGN KEY (Phong_TK)
        REFERENCES KHU (TenKhu),
    FOREIGN KEY (Phong_MLP)
        REFERENCES LOAIPHONG (MaLoaiPhong),
    PRIMARY KEY (Phong_MCN , SoPhong)
);

-- 13 --
CREATE TABLE KHACHHANG(
	MaKhachHang CHAR(8) NOT NULL CHECK(CAST(MaKhachhang AS UNSIGNED INT) < 1000000),
	CCCD VARCHAR(12) NOT NULL UNIQUE,
	Email VARCHAR(50) NOT NULL,
	Username VARCHAR(50) NOT NULL,
	Diem INT NOT NULL DEFAULT 0 CHECK(Diem > -1),
	Loai INT NOT NULL DEFAULT 1 CHECK(Loai > 0), /*NEEDS A VIEW*/
	PRIMARY KEY (MaKhachHang)
);

-- 14 --
CREATE TABLE GOIDICHVU (
    TenGoi VARCHAR(50),
    SoNgay INT NOT NULL CHECK (SoNgay > 0 AND SoNgay < 101),
    SoKhach INT NOT NULL CHECK (SoKhach > 0 AND SoKhach < 11),
    PRIMARY KEY (TenGoi)
);

-- 15 --
CREATE TABLE HOADONGOIDICHVU (
    HDGDV_MKH CHAR(8) NOT NULL CHECK (CAST(MaKhachhang AS UNSIGNED INT) < 1000000),
    HDGDV_TG VARCHAR(50),
    NgayGioMua DATETIME NOT NULL,
    NgayBatDau DATETIME NOT NULL CHECK (NgayBatDau > NgayGioMua),
    TongTien INT NOT NULL,
    FOREIGN KEY (HDGDV_MKH)
        REFERENCES KHACHHANG (MaKhachHang),
    FOREIGN KEY (HDGDV_TG)
        REFERENCES GOIDICHVU (TenGoi),
    PRIMARY KEY (HDGDV_MKH , HDGDV_TG , NgayGioMua)
);

-- 16 --
CREATE TABLE DONDATPHONG (
    MaDatPhong VARCHAR(16) AUTO_INCREMENT,
    NgayGioDat DATETIME NOT NULL,
    NgayNhanPhong DATETIME NOT NULL CHECK (NgayNhanPhong > NgayGioDat),
    NgayTraPhong DATETIME NOT NULL CHECK (NgayTraPhong > NgayNhanPhong),
    TinhTrang INT CHECK (TinhTrang > - 1 AND TinhTrang < 4),
    PRIMARY KEY (MaDatPhong)
);

-- 17 --
CREATE TABLE PHONGTHUE (
    PT_MDP VARCHAR(16) AUTO_INCREMENT,
    PT_MCN INT NOT NULL AUTO_INCREMENT,
    PT_SP VARCHAR(3) NOT NULL,
    FOREIGN KEY (PT_MDP)
        REFERENCES DONDATPHONG (MaDatPhong),
    FOREIGN KEY (PT_MCN)
        REFERENCES CHINHANH (MaChiNhanh),
    FOREIGN KEY (PT_SP)
        REFERENCES PHONG (SoPhong),
    PRIMARY KEY (PT_MDP , PT_MCN , PT_SP)
);

-- 18 --
CREATE TABLE HOADON (
    MaHoaDon VARCHAR(16) AUTO_INCREMENT,
    HD_MDP VARCHAR(16) AUTO_INCREMENT,
    FOREIGN KEY (HD_MDP)
        REFERENCES DONDATPHONG (MaDatPhong),
    PRIMARY KEY (MaHoaDon , HD_MDP)
);

-- 19 --
CREATE TABLE DOANHNGHIEP (
    MaDoanhNghiep VARCHAR(6) NOT NULL,
    TenDoanhNghiep VARCHAR(100),
    PRIMARY KEY (MaDoanhNghiep)
);

-- 20 --
CREATE TABLE DICHVU (
    LoaiDichVu VARCHAR(1) NOT NULL,
    MaDichVu VARCHAR(6) NOT NULL,
    SoKhach INT,
    PhongCach VARCHAR(255),
    DV_MDN VARCHAR(6) NOT NULL,
    FOREIGN KEY (DV_MDN)
        REFERENCES DOANHNGHIEP (MaDoanhNghiep),
    PRIMARY KEY (LoaiDichVu)
);

-- 21 --
CREATE TABLE DICHVUSPA (
    DVS_MDV VARCHAR(6) NOT NULL,
    DichVuSpa VARCHAR(255),
    FOREIGN KEY (DVS_MDV)
        REFERENCES DICHVU (MaDichVu),
    PRIMARY KEY (DVS_MDV , DichVuSpa)
);

-- 22 --
CREATE TABLE LOAIHANGDOLUUNIEM (
    LHDLN_MDV VARCHAR(6) NOT NULL,
    LoaiHang VARCHAR(255),
    FOREIGN KEY (LHDLN_MDV)
        REFERENCES DICHVU (MaDichVu),
    PRIMARY KEY (LHDLN_MDV , LoaiHang)
);

-- 23 --
CREATE TABLE THUONGHIEUDOLUUNIEM (
    THDLN_MDV VARCHAR(6) NOT NULL,
    ThuongHieu VARCHAR(100),
    FOREIGN KEY (THDLN_MDV)
        REFERENCES DICHVU (MaDichVu),
    PRIMARY KEY (THDLN_MDV , ThuongHieu)
);

-- 24 --
CREATE TABLE  MATBANG(
	MB_MCN VARCHAR(50) NOT NULL AUTO_INCREMENT,
    STTMatBang INT NOT NULL DEFAULT 1 CHECK (STTMatBang > 0 AND STTMatBang < 51),
    GiaThue INT NOT NULL,
    ChieuDai INT NOT NULL,
    ChieuRong INT NOT NULL,
    MoTa VARCHAR(255),
    MB_MDV VARCHAR(6) NOT NULL,
    TenCuaHang VARCHAR(255),
    FOREIGN KEY (MB_MDV) REFERENCES DICHVU(MaDichVu),
    FOREIGN KEY (MB_MCN) REFERENCES CHINHANH(MaChiNhanh),
    PRIMARY KEY (MB_MCN, MB_MDB, STTMatBang)
);
    
/* VIEW */
CREATE VIEW NgayNhanPhong AS
    SELECT 
        DATE(NgayNhanPhong) AS NgayNhanPhong
    FROM
        DONDATPHONG;

/* TRIGGER */
CREATE 
    TRIGGER  AddPrefix_MCN
 AFTER INSERT ON CHINHANH FOR EACH ROW 
    SET NEW . MaChiNhanh = CONCAT('CN', MaChiNhanh);
    
CREATE 
    TRIGGER  AddPrefix_MHD
 AFTER INSERT ON HOADON FOR EACH ROW 
    SET NEW . MaHoaDon = CONCAT('HD', CURDATE(), MaHoaDon);
    
CREATE 
    TRIGGER  AddPrefix_MDP
 AFTER INSERT ON DONDATPHONG FOR EACH ROW 
    SET NEW . MaDatPhong = CONCAT('DP', CURDATE(), MaDatPhong);
    
CREATE 
    TRIGGER  AddPrefix_MDN
 AFTER INSERT ON DOANHGNHIEP FOR EACH ROW 
    SET NEW . MaDoanhNghiep = CONCAT('DN', MaDoanhNghiep);