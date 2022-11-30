USE MYHOTEL;

-- @block TRIGGER 1a --
DELIMITER \\
DROP TRIGGER IF EXISTS update_TongTienGoiDichVu\\
CREATE TRIGGER update_TongTienGoiDichVu
BEFORE INSERT ON HOADONGOIDICHVU FOR EACH ROW
BEGIN
    DECLARE LoaiKH INT;
    DECLARE SoNgayConLai INT;
    DECLARE SoTien INT;
    SET LoaiKH = (SELECT Loai FROM KHACHHANG WHERE KHACHHANG.MaKhachHang = NEW.HDGDV_MKH);
    SET SoNgayConLai = (SELECT SoNgay FROM GOIDICHVU WHERE GOIDICHVU.TenGoi = NEW.HDGDV_TG);
    IF LoaiKH = 2 THEN SET SoTien = ((SELECT Gia FROM GOIDICHVU WHERE GOIDICHVU.TenGoi = NEW.HDGDV_TG) * 9 / 10);
    ELSEIF LoaiKH = 3 THEN SET SoTien = ((SELECT Gia FROM GOIDICHVU WHERE GOIDICHVU.TenGoi = NEW.HDGDV_TG) * 17 / 20),
							SoNgayConLai = SoNgayConLai + 1;
    ELSEIF LoaiKH = 4 THEN SET SoTien = ((SELECT Gia FROM GOIDICHVU WHERE GOIDICHVU.TenGoi = NEW.HDGDV_TG) * 4 / 5),
							SoNgayConLai = SoNgayConLai + 2;
	ELSE SET SoTien = NEW.TongTien;
    END IF;
    SET NEW.TongTien = SoTien;
    SET NEW.SoNgaySuDungConLai = SoNgayConLai;
END\\
DELIMITER ;

-- @block TRIGGER 1b --
DELIMITER \\
DROP TRIGGER IF EXISTS update_TongTienDonDatPhong\\
CREATE TRIGGER update_TongTienDonDatPhong
BEFORE INSERT ON DONDATPHONG FOR EACH ROW
BEGIN
	DECLARE LoaiKH INT;
    DECLARE SoNgayConLai INT;
    DECLARE SoTien INT;
    SET LoaiKH = (SELECT Loai FROM KHACHHANG WHERE KHACHHANG.MaKhachHang = NEW.DDP_MKH);
    IF NEW.DDP_TG IS NULL THEN
		IF LoaiKH = 2 THEN SET SoTien = NEW.TongTien * 9 / 10;
		ELSEIF LoaiKH = 3 THEN SET SoTien = NEW.TongTien * 17 / 20;
		ELSEIF LoaiKH = 4 THEN SET SoTien = NEW.TongTien * 4 / 5;
		ELSE SET SoTien = NEW.TongTien;
        END IF;
	ELSE 
		SET SoTien = 0;
        UPDATE HOADONGOIDICHVU
        SET SoNgaySuDungConLai = SoNgaySuDungConLai - TIMESTAMPDIFF(DAY, NEW.NgayNhanPhong, NEW.NgayTraPhong)
        WHERE HOADONGOIDICHVU.HDGDV_TG = NEW.DDP_TG AND HOADONGOIDICHVU.HDGDV_MKH = NEW.DDP_MKH;
    END IF;
	SET NEW.TongTien = SoTien;
END\\
DELIMITER ;

-- @block TRIGGER 1c1 --
DELIMITER \\
DROP TRIGGER IF EXISTS update_Diem_GDV\\
CREATE TRIGGER update_Diem_GDV
AFTER INSERT ON HOADONGOIDICHVU FOR EACH ROW
BEGIN
    DECLARE DiemThem INT;
	SET DiemThem = floor(NEW.TongTien/1000);
	UPDATE KHACHHANG
	SET Diem = Diem + DiemThem
	WHERE MaKhachHang = NEW.HDGDV_MKH;
END\\
DELIMITER ;

-- @block TRIGGER 1c2 --
DELIMITER \\
DROP TRIGGER IF EXISTS update_Diem_DDP\\
CREATE TRIGGER update_Diem_DDP
AFTER INSERT ON DONDATPHONG FOR EACH ROW
BEGIN
    DECLARE DiemThem INT;
    IF NEW.TinhTrang = 1 THEN
		SET DiemThem = floor(NEW.TongTien/1000);
		UPDATE KHACHHANG
		SET Diem = Diem + DiemThem
		WHERE MaKhachHang = NEW.DDP_MKH;
	END IF;
END\\
DELIMITER ;

-- @block TRIGGER 1c3 --
DELIMITER \\
DROP TRIGGER IF EXISTS update_Diem_DDP_thanhtoan\\
CREATE TRIGGER update_Diem_DDP_thanhtoan
AFTER UPDATE ON DONDATPHONG FOR EACH ROW
BEGIN
    DECLARE DiemThem INT;
    IF NEW.TinhTrang <> OLD. TinhTrang AND NEW.TinhTrang = 1 THEN
		SET DiemThem = floor(NEW.TongTien/1000);
		UPDATE KHACHHANG
		SET Diem = Diem + DiemThem
		WHERE MaKhachHang = NEW.DDP_MKH;
	END IF;
END\\
DELIMITER ;

-- @block TRIGGER 1d --
DELIMITER \\
DROP TRIGGER IF EXISTS update_LoaiKhachHang\\
CREATE TRIGGER update_LoaiKhachHang
BEFORE UPDATE ON KHACHHANG FOR EACH ROW
BEGIN
    IF NEW.Diem < 50 THEN SET NEW.Loai = 1;
    ELSEIF NEW.Diem < 100 THEN SET NEW.Loai = 2;
    ELSEIF NEW.Diem < 1000 THEN SET NEW.Loai = 3;
    ELSE SET NEW.Loai = 4;
    END IF;
END\\
DELIMITER ;

/*
-- @block TRIGGER 2 --
DELIMITER \\
DROP TRIGGER IF EXISTS constraint_OverlappingPackage\\
CREATE TRIGGER constraint_OverlappingPackage
BEFORE INSERT ON HOADONGOIDICHVU FOR EACH ROW PRECEDES update_TongTienGoiDichVu
BEGIN
    DECLARE msg VARCHAR(255);
    SET msg = "OVERLAPPING RENTAL PACKAGE PURCHASE!";
    IF (EXISTS(SELECT * FROM HOADONGOIDICHVU WHERE HDGDV_TG = NEW.HDGDV_TG)) THEN
        IF (NEW.NgayBatDau BETWEEN (SELECT NgayBatDau FROM HOADONGOIDICHVU WHERE HDGDV_TG = NEW.HDGDV_TG AND HDGDV_MKH = NEW.HDGDV_MKH)
			AND (SELECT ADDDATE(NgayBatDau, INTERVAL 1 YEAR) FROM HOADONGOIDICHVU WHERE HDGDV_TG = NEW.HDGDV_TG AND HDGDV_MKH = NEW.HDGDV_MKH)) 
        THEN SIGNAL sqlstate '03000' SET message_text = msg;
        END IF;
    END IF;
END\\
DELIMITER ;
*/