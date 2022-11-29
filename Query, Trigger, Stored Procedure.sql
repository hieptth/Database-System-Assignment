USE MYHOTEL;
DELIMITER \ \ -- @block STORED PROCEDURE --
DROP PROCEDURE IF EXISTS GoiDichVu;
DELIMITER \ \ CREATE PROCEDURE GoiDichVu (IN MaKhachHang VARCHAR(8)) BEGIN
DECLARE count int DEFAULT 0;
SET count = (
        SELECT COUNT(HDGDV_MKH)
        FROM HOADONGOIDICHVU
        WHERE HDGDV_MKH = MaKhachHang
    );
IF count > 0 THEN
SELECT HOADONGOIDICHVU.HDGDV_TG,
    GOIDICHVU.SoKhach,
    HOADONGOIDICHVU.NgayBatDau,
    ADDDATE(
        HOADONGOIDICHVU.NgayBatDau,
        INTERVAL GOIDICHVU.SoNgay DAY
    ) AS NgayKetThuc,
    HOADONGOIDICHVU.SoNgaySuDungConLai
FROM (
        HOADONGOIDICHVU
        INNER JOIN GOIDICHVU ON HOADONGOIDICHVU.HDGDV_TG = GOIDICHVU.TenGoi
    )
WHERE HOADONGOIDICHVU.HDGDV_MKH = MaKhachHang;
ELSE
SELECT CONCAT('YOUR PARAMETER ', MaKhachHang, ' DOES NOT EXIST!') AS 'ERROR';
END IF;
END \ \ DELIMITER;
-- @block TRIGGER 1a --
DROP TRIGGER IF EXISTS update_TongTienGoiDichVu;
DELIMITER \ \ CREATE TRIGGER update_TongTienGoiDichVu
AFTER
INSERT ON HOADONGOIDICHVU FOR EACH ROW BEGIN
DECLARE temp INT DEFAULT 1;
SET temp = (
        SELECT Loai
        FROM KHACHHANG
        WHERE MaKhachHang = HDGDV_MKH
    );
IF temp = 2 THEN
SET TongTien = (
        (
            SELECT GiaFROM GOIDICHVUWHERE TenGoi = HDGDV_TG
        ) * 9 / 10
    );
ELSEIF temp = 3 THEN BEGIN
SET NEW.SoNgaySuDungConLai = SoNgaySuDungConLai + 1;
SET NEW.TongTien = (
        (
            SELECT Gia
            FROM GOIDICHVU
            WHERE TenGoi = HDGDV_TG
        ) * 17 / 20
    );
END;
ELSEIF temp = 4 THEN BEGIN
SET NEW.SoNgaySuDungConLai = SoNgaySuDungConLai + 2;
SET NEW.TongTien = (
        (
            SELECT Gia
            FROM GOIDICHVU
            WHERE TenGoi = HDGDV_TG
        ) * 4 / 5
    );
END;
END IF;
END \ \ DELIMITER;
-- @block TRIGGER 1b --
DROP TRIGGER IF EXISTS update_TongTienDonDatPhong;
DELIMITER \ \ CREATE TRIGGER update_TongTienDonDatPhong
AFTER
INSERT ON DONDATPHONG FOR EACH ROW BEGIN
DECLARE temp INT DEFAULT 1;
SET temp = (
        SELECT Loai
        FROM KHACHHANG
        WHERE MaKhachHang = DDP_MKH
    );
IF DDP_TG IS NULL THEN BEGIN IF temp = 2 THEN
SET TongTien = TongTien * 9 / 10;
IF temp = 3 THEN
SET TongTien = TongTien * 17 / 20;
IF temp = 4 THEN
SET TongTien = TongTien * 4 / 5;
END;
ELSE BEGIN
SET TongTien = 0;
UPDATE HOADONGOIDICHVU
SET SoNgaySuDungConLai = SoNgaySuDungConLai - TIMESTAMPDIFF(
        DAY,
        DONDATPHONG.NgayNhanPhong,
        DONDATPHONG.NgayTraPhong
    );
END;
END IF;
END \ \ DELIMITER;
-- @block TRIGGER 1c --
DROP TRIGGER IF EXISTS update_Diem;
DELIMITER \ \ CREATE TRIGGER update_Diem
AFTER
INSERT ON KHACHHANG FOR EACH ROW BEGIN
SET Diem = FLOOR(
        (
            (
                SELECT TongTien
                FROM HOADONGOIDICHVU
                WHERE HDGDV_MKH = MaKhachHang
            ) + (
                SELECT TongTien
                FROM DONDATPHONG
                WHERE DDP_MKH = MaKhachHang
            )
        ) / 1000
    );
END \ \ DELIMITER;
-- @block TRIGGER 1d --
DROP TRIGGER IF EXISTS update_LoaiKhachHang;
DELIMITER \ \ CREATE TRIGGER update_LoaiKhachHang
AFTER
INSERT ON KHACHHANG FOR EACH ROW BEGIN IF Diem < 50 THEN
SET Loai = 1;
ELSEIF Diem < 100 THEN
SET Loai = 2;
ELSEIF Diem < 1000 THEN
SET Loai = 3;
ELSE
SET Loai = 4;
END IF;
END \ \ DELIMITER;