USE myhotel;
/* Procedure 1 -- not completed */
-- @block STORED PROCEDURE --
DROP PROCEDURE IF EXISTS GoiDichVu;
DELIMITER \\
CREATE PROCEDURE GoiDichVu (
    IN MaKhachHang VARCHAR(8),
    OUT TG VARCHAR(50),
    OUT SK INT,
    OUT NBD DATETIME,
    OUT NHH DATETIME,
    OUT SoNgaySuDungConLai INT,
)
BEGIN
    DECLARE count int DEFAULT 0;
    SET count = SELECT COUNT(HDGDV_MKH) FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang;
    IF count > 0 THEN
        SELECT HDGDV_TG INTO TG FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang;
        SELECT SoKhach INTO SK FROM GOIDICHVU WHERE TenGoi = TG;
        SELECT NgayBatDau INTO NBD FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang;
        SET NHH = NBD + (SELECT SoNgay);
    ELSE
        SET TG = '';
        SET SK = 0;
        SET NBD = CURDATE();
        SET NHH = CURDATE();
        SET SoNgaySuDungConLai = 0;
        SELECT CONCAT('YOUR PARAMETER ', MaKhachHang, 'DOES NOT EXIST!') AS 'ERROR';
    END IF;
END \\
DELIMITER ;

-- @block STORED PROCEDURE --
DROP PROCEDURE IF EXISTS GoiDichVu;
DELIMITER \\
CREATE PROCEDURE GoiDichVu ( IN MaKhachHang VARCHAR(8) )
BEGIN
    DECLARE count int DEFAULT 0;
    SET count = SELECT COUNT(HDGDV_MKH) FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang;
    IF count > 0 THEN
        SELECT HDGDV_TG FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang;
        SELECT SoKhach FROM GOIDICHVU WHERE TenGoi = TG;
        SET SK = SELECT SoKhach FROM GOIDICHVU WHERE TenGoi = TG;
        SET NBD = SELECT NgayBatDau FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang;
        SET NHH = NBD + (SELECT SoNgay);
    ELSE SELECT CONCAT('YOUR PARAMETER ', MaKhachHang, 'DOES NOT EXIST!') AS 'ERROR';
    END IF;
END \\
DELIMITER ;

/*
Tong tien goi dich vu ko co giảm giá, chỉ thay đổi số ngày theo loại đã được insert sẵn
tổng tiền hóa đơn giảm giá theo loại được insert sẵn, nếu có apply gói thì tổng tiền 0d
điểm được tính trên tổng đã giảm giá
loại được tính lại sau khi update điểm
*/
-- @block TRIGGER --
DROP TRIGGER update_TongTienGoiDichVu;
DELIMITER \\
CREATE TRIGGER update_TongTienGoiDichVu
AFTER INSERT ON HOADONGOIDICHVU FOR EACH ROW
BEGIN
    SELECT Loai FROM KHACHHANG WHERE MaKhachHang = HDGDV_MKH,
    CASE
        WHEN Loai = 2 THEN SET NEW.TongTien = (SELECT Gia FROM GOIDICHVU WHERE TenGoi = HDGDV_TG)*9/10;
        WHEN Loai = 3 THEN SET NEW.TongTien = (SELECT Gia FROM GOIDICHVU WHERE TenGoi = HDGDV_TG)*17/20;
        WHEN Loai = 4 THEN SET NEW.TongTien = (SELECT Gia FROM GOIDICHVU WHERE TenGoi = HDGDV_TG)*4/5;
    END;
END \\
DELIMITER ;

DROP TRIGGER update_TongTienDonDatPhong
DELIMITER \\
CREATE TRIGGER update_TongTienDonDatPhong
AFTER INSERT ON DONDATPHONG FOR EACH ROW
BEGIN
    SELECT Loai FROM KHACHHANG WHERE MaKhachHang = HDGDV_MKH,
    CASE
        WHEN Loai = 2 THEN SET NEW.TongTien = (SELECT Gia FROM GOIDICHVU WHERE TenGoi = DDP_TG)*9/10;
        WHEN Loai = 3 THEN
        BEGIN
            SET NEW.TongTien = (SELECT Gia FROM GOIDICHVU WHERE TenGoi = DDP_TG)*17/20;
            SET NEW.NgayTraPhong = ADDDATE(NgayTraPhong, INTERVAL 1 DAY);
        END;
        WHEN Loai = 4 THEN
        BEGIN
            SET NEW.TongTien = (SELECT Gia FROM GOIDICHVU WHERE TenGoi = DDP_TG)*4/5;
            SET NEW.NgayTraPhong = ADDDATE(NgayTraPhong, INTERVAL 2 DAY);
        END;
    END;
END \\
DELIMITER ;

DROP TRIGGER update_Diem;
DELIMITER \\
CREATE TRIGGER update_Diem
AFTER INSERT ON KHACHHANG FOR EACH ROW
BEGIN
    SET NEW.Diem = FLOOR(((SELECT TongTien FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang) + (SELECT TongTien FROM DONDATPHONG WHERE DDP_MKH = MaKhachHang))/1000);
END \\
DELIMITER ;

DROP TRIGGER update_LoaiKhachHang;
DELIMITER \\
CREATE TRIGGER update_LoaiKhachHang
AFTER INSERT ON KHACHHANG FOR EACH ROW
BEGIN
    SELECT Diem,
    CASE
        WHEN Diem < 50 THEN SET NEW.Loai = 1;
        WHEN Diem < 100 THEN SET NEW.Loai = 2;
        WHEN Diem < 1000 THEN SET NEW.Loai = 3;
        ELSE SET NEW.Loai = 4;
    END;
END \\
DELIMITER ;

DROP TRIGGER package_collision;
DELIMITER \\
CREATE TRIGGER package_collision
BEFORE INSERT ON 