CREATE TABLE CHINHANH (
    MaChiNhanh INT NOT NULL AUTO_INCREMENT,
    Tinh VARCHAR(50),
    DiaChi VARCHAR(255),
    DienThoai DECIMAL(11 , 0 ),
    Email VARCHAR(50),
    PRIMARY KEY (MaChiNhanh)
);

CREATE TABLE MAKHACHHANG(
MaKhachHang CHAR(8) NOT NULL CHECK(CAST(MaKhachhang AS UNSIGNED INT) < 1000000),
CCCD CHAR(12) NOT NULL UNIQUE,
Email CHAR(50) NOT NULL,
Username CHAR(50) NOT NULL,
Diem INT NOT NULL CHECK(Diem > -1) DEFAULT 0,
Loai INT NOT NULL CHECK(Loai > 0) DEFAULT 1 /*NEEDS A VIEW*/
);



/* TRIGGER */
CREATE 
    TRIGGER  AddPrefix
 BEFORE INSERT ON CHINHANH FOR EACH ROW 
    SET NEW . MaChiNhanh = CONCAT('CN', MaChiNhanh);