-- @block STORED PROCEDURE --
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
    HOADONGOIDICHVU.SoNgaySuDungConLai,
    ADDDATE(
        HOADONGOIDICHVU.NgayBatDau,
        INTERVAL GOIDICHVU.SoNgay DAY
    ) AS NgayKetThuc
FROM (
        HOADONGOIDICHVU
        INNER JOIN GOIDICHVU ON HOADONGOIDICHVU.HDGDV_TG = GOIDICHVU.TenGoi
    )
WHERE HOADONGOIDICHVU.HDGDV_MKH = MaKhachHang;
/* missing Ngay Het Han */
ELSE
SELECT CONCAT(
        'YOUR PARAMETER ',
        MaKhachHang,
        'DOES NOT EXIST!'
    ) AS 'ERROR';
END IF;
END \ \ DELIMITER;
-- @block TRIGGER --
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
CASE
    temp
    WHEN 2 THEN
    SET TongTien = (
            SELECT Gia
            FROM GOIDICHVU
            WHERE TenGoi = HDGDV_TG
        ) * 9 / 10;
WHEN 3 THEN
SET SoNgaySuDungConLai = SoNgaySuDungConLai + 1;
SET HOADONGOIDICHVU.TongTien = (
        SELECT Gia
        FROM GOIDICHVU
        WHERE TenGoi = HDGDV_TG
    ) * 17 / 20;
WHEN 4 THEN
SET SoNgaySuDungConLai = SoNgaySuDungConLai + 2;
SET HOADONGOIDICHVU.TongTien = (
        SELECT Gia
        FROM GOIDICHVU
        WHERE TenGoi = HDGDV_TG
    ) * 4 / 5;
ELSE BEGIN
END;
END CASE
;
END \ \ DELIMITER;
DROP TRIGGER update_TongTienDonDatPhong DELIMITER \ \ CREATE TRIGGER update_TongTienDonDatPhong
AFTER
INSERT ON DONDATPHONG FOR EACH ROW BEGIN
DECLARE temp INT DEFAULT 1;
SET temp = (
        SELECT Loai
        FROM KHACHHANG
        WHERE MaKhachHang = DDP_MKH
    );
IF DDP_TG IS NULL THEN CASE
    temp
    WHEN 2 THEN
    SET TongTien = TongTien * 9 / 10;
WHEN 3 THEN
SET TongTien = TongTien * 17 / 20;
WHEN 4 THEN
SET TongTien = TongTien * 4 / 5;
END CASE
;
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
DROP TRIGGER update_Diem;
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
DROP TRIGGER update_LoaiKhachHang;
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