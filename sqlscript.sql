CREATE TABLE CHINHANH (
    MaChiNhanh VARCHAR(50) NOT NULL AUTO_INCREMENT,
    Tinh VARCHAR(50) NOT NULL,
    DiaChi VARCHAR(255) NOT NULL,
    DienThoai INT NOT NULL,
    Email VARCHAR(50) NOT NULL,
    PRIMARY KEY (MaChiNhanh)
);
CREATE TABLE HINHANH_CHINHANH (
    HA_MCN INT NOT NULL,
    HinhAnh JSON NOT NULL,
    PRIMARY KEY (HA_MCN,HinhAnh),
    FOREIGN KEY (HA_MCN)
		REFERENCES CHINHANH(MaChiNhanh)
);
CREATE TABLE KHU (
    Khu_MCN VARCHAR(50) NOT NULL,
    TenKhu VARCHAR(50) NOT NULL,
    PRIMARY KEY (Khu_MCN , TenKhu),
    FOREIGN KEY (Khu_MCN)
        REFERENCES CHINHANH (MaChiNhanh)
);
CREATE TABLE LOAIPHONG (
    MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
    TenLoaiPhong VARCHAR(50) NOT NULL,
    DienTich DECIMAL(3 , 2 ) NOT NULL,
    SoKhach INT UNIQUE CHECK (SoKhach > 0 AND SoKhach < 11),
    MoTaKhac VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (MaLoaiPhong)
);
CREATE TABLE THONGTINGIUONG (
    TTG_MLP INT NOT NULL,
    KichThuoc DECIMAL(1 , 1 ) NOT NULL,
    SoLuong INT NOT NULL CHECK(SoLuong > 0 and SoLuong < 11) DEFAULT 1,
    PRIMARY KEY (TTG_MLP, KichThuoc),
    FOREIGN KEY (TTG_MLP) REFERENCES LOAIPHONG(MaLoaiPhong)
);
CREATE TABLE CHINHANH_CO_LOAIPHONG (
    Co_MLP INT NOT NULL,
    Co_MCN VARCHAR(50) NOT NULL,
    GiaThue INT NOT NULL,						/* Add Unit (1000 vnd) */
    PRIMARY KEY (Co_MLP , Co_MCN),
    FOREIGN KEY (Co_MLP)
        REFERENCES LOAIPHONG (MaLoaiPhong),
    FOREIGN KEY (Co_MCN)
        REFERENCES CHINHANH (MaChiNhanh)
);
CREATE TABLE PHONG (
    Phong_MCN VARCHAR(50) NOT NULL,
    Phong_SP VARCHAR(50) NOT NULL
);


CREATE TABLE MAKHACHHANG(
	MaKhachHang CHAR(8) NOT NULL CHECK(CAST(MaKhachhang AS UNSIGNED INT) < 1000000),
	CCCD VARCHAR(12) NOT NULL UNIQUE,
	Email VARCHAR(50) NOT NULL,
	Username VARCHAR(50) NOT NULL,
	Diem INT NOT NULL CHECK(Diem > -1) DEFAULT 0,
	Loai INT NOT NULL CHECK(Loai > 0) DEFAULT 1, /*NEEDS A VIEW*/
	PRIMARY KEY (MaKhachHang)
);
CREATE TABLE GoiDichVu (
	TenGoi VARCHAR(50),
	SoNgay INT NOT NULL CHECK(SoNgay > 0 AND SoNgay < 101),
	SoKhach INT NOT NULL Check(SoKhach > 0 AND SoKhach < 11),
	PRIMARY KEY (TenGoi)
);
CREATE TABLE HOADONGOIDICHVU (
	HDGDV_MKH CHAR(8) NOT NULL CHECK(CAST(MaKhachhang AS UNSIGNED INT) < 1000000),
    HDGDV_TG VARCHAR(50),
    NgayGioMua DateTime NOT NULL,
    NgayBatDau DateTime NOT NULL CHECK (NgayBatDau > NgayGioMua),
    TongTien INT NOT NULL,
    FOREIGN KEY (HDGDV_MKH) REFERENCES KHACHHANG(MaKhachHang),
    FOREIGN KEY (HDGDV_TG) REFERENCES GOIDICHVU(TenGoi),
    PRIMARY KEY (HDGDV_MKH, HDGDV_TG, NgayGioMua)
);
CREATE TABLE DonDatPhong (
    MaDatPhong VARCHAR(16) AUTO_INCREMENT,
    NgayGioDat DATETIME NOT NULL,
    NgayNhanPhong DATETIME NOT NULL CHECK (NgayNhanPhong > NgayGioDat),
    NgayTraPhong DATETIME NOT NULL CHECK (NgayTraPhong > NgayNhanPhong),
    TinhTrang INT CHECK (TinhTrang > - 1 AND TinhTrang < 4),
    PRIMARY KEY (MaDatPhong)
);
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
    
/* VIEW */
CREATE VIEW NgayNhanPhong AS
SELECT DATE(NgayNhanPhong) AS NgayNhanPhong FROM DONDATPHONG;

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