USE myhotel;

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
        SET TG = SELECT HDGDV_TG FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang;
        SET SK = SELECT SoKhach FROM GOIDICHVU WHERE TenGoi = TG;
        SET NBD = SELECT NgayBatDau FROM HOADONGOIDICHVU WHERE HDGDV_MKH = MaKhachHang;
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