USE assignment;
-- @block 1 --
CREATE TABLE IF NOT EXISTS CHINHANH (
    MaChiNhanh INT NOT NULL AUTO_INCREMENT,
    Tinh VARCHAR(50) NOT NULL,
    DiaChi VARCHAR(255) NOT NULL,
    DienThoai INT NOT NULL,
    Email VARCHAR(50) NOT NULL,
    CONSTRAINT PK_CHINHANH PRIMARY KEY (MaChiNhanh)
);
-- @block 2 --
CREATE TABLE IF NOT EXISTS HINHANH_CHINHANH (
    HA_MCN VARCHAR(50),
    HinhAnh VARCHAR(255) NOT NULL,
    CONSTRAINT PK_HINHANH PRIMARY KEY (HinhAnh),
    CONSTRAINT FK_HA_MCN FOREIGN KEY (HA_MCN) REFERENCES CHINHANH(MaChiNhanh) ON DELETE CASCADE ON UPDATE CASCADE
);
-- @block 3 --
CREATE TABLE IF NOT EXISTS KHU (
    Khu_MCN VARCHAR(50),
    TenKhu VARCHAR(50) NOT NULL,
    CONSTRAINT PK_KHU PRIMARY KEY (TenKhu),
    CONSTRAINT FK_Khu_MCN FOREIGN KEY (Khu_MCN) REFERENCES CHINHANH (MaChiNhanh) ON DELETE CASCADE ON UPDATE CASCADE
);
-- @block 4 --
CREATE TABLE IF NOT EXISTS LOAIPHONG (
    MaLoaiPhong INT NOT NULL AUTO_INCREMENT,
    TenLoaiPhong VARCHAR(50) NOT NULL,
    DienTich DECIMAL(4, 1) NOT NULL,
    SoKhach INT NOT NULL CHECK(
        SoKhach BETWEEN 1 AND 10
    ),
    MoTaKhac VARCHAR(255) DEFAULT NULL,
    CONSTRAINT PK_LOAIPHONG PRIMARY KEY (MaLoaiPhong)
);
-- @block 5 --
CREATE TABLE IF NOT EXISTS THONGTINGIUONG (
    TTG_MLP INT,
    KichThuoc DECIMAL(2, 1) NOT NULL,
    SoLuong INT NOT NULL DEFAULT 1 CHECK(
        SoLuong BETWEEN 1 AND 10
    ),
    CONSTRAINT PK_TTG PRIMARY KEY (KichThuoc),
    CONSTRAINT FK_TTG_MLP FOREIGN KEY (TTG_MLP) REFERENCES LOAIPHONG(MaLoaiPhong) ON DELETE CASCADE ON UPDATE CASCADE
);
-- @block 6 --
CREATE TABLE IF NOT EXISTS CHINHANH_CO_LOAIPHONG (
    Co_MLP INT,
    Co_MCN VARCHAR(50),
    GiaThue INT NOT NULL CHECK(GiaThue > -1),
    CONSTRAINT FK_Co_MLP FOREIGN KEY (Co_MLP) REFERENCES LOAIPHONG (MaLoaiPhong) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Co_MCN FOREIGN KEY (Co_MCN) REFERENCES CHINHANH (MaChiNhanh) ON DELETE CASCADE ON UPDATE CASCADE
);
-- @block 7 --
CREATE TABLE IF NOT EXISTS PHONG (
    Phong_MCN VARCHAR(50),
    SoPhong VARCHAR(3) UNIQUE NOT NULL,
    Phong_TK VARCHAR(50) NOT NULL,
    Phong_MLP INT NOT NULL,
    CONSTRAINT FK_Phong_MCN FOREIGN KEY (Phong_MCN) REFERENCES KHU (Khu_MCN) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Phong_TK FOREIGN KEY (Phong_TK) REFERENCES KHU (TenKhu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Phong_MLP FOREIGN KEY (Phong_MLP) REFERENCES LOAIPHONG (MaLoaiPhong) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_PHONG PRIMARY KEY (SoPhong)
);
-- @block 8 -- MaLoaiVatTu is of type VT0001
CREATE TABLE IF NOT EXISTS LOAIVATTU(
    MaLoaiVatTu INT(4) ZEROFILL NOT NULL,
    TenLoaiVatTu VARCHAR(50) NOT NULL,
    CONSTRAINT PK_LOAIVATTU PRIMARY KEY (MaLoaiVatTu)
);
-- @block 9 --
CREATE TABLE IF NOT EXISTS LOAIVATTU_TRONG_LOAIPHONG (
    Trong_MLVT VARCHAR(6),
    Trong_MLP INT,
    SoLuong INT NOT NULL DEFAULT 1 CHECK(
        SoLuong BETWEEN 1 AND 20
    ),
    CONSTRAINT FK_Trong_MLVT FOREIGN KEY (Trong_MLVT) REFERENCES LOAIVATTU (MaLoaiVatTu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Trong_MLP FOREIGN KEY (Trong_MLP) REFERENCES LOAIPHONG (MaLoaiPhong) ON DELETE CASCADE ON UPDATE CASCADE
);
-- @block 10 -- references to chinhanh maybe redundant
CREATE TABLE IF NOT EXISTS VATTU (
    VT_MCN VARCHAR(50),
    VT_MLVT VARCHAR(6),
    SttVatTu INT NOT NULL CHECK(SttVatTu > -1),
    TinhTrang VARCHAR(50) NOT NULL,
    VT_SP VARCHAR(3),
    CONSTRAINT FK_VT_MLVT FOREIGN KEY (VT_MLVT) REFERENCES LOAIVATTU (MaLoaiVatTu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_VT_MCN_SP FOREIGN KEY (VT_MCN, VT_SP) REFERENCES PHONG (Phong_MCN, SoPhong) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_VATTU PRIMARY KEY (SttVatTu)
);
-- @block 11 -- MaNhaCungCap is of type NCC0001
CREATE TABLE IF NOT EXISTS NHACUNGCAP (
    MaNhaCungCap INT(4) ZEROFILL NOT NULL,
    TenNhaCungCap VARCHAR(50) NOT NULL,
    Email VARCHAR(50),
    DiaChi VARCHAR(255) NOT NULL,
    CONSTRAINT PK_NHACUNGCAP PRIMARY KEY (MaNhaCungCap)
);
-- @block 12 --
CREATE TABLE IF NOT EXISTS CUNGCAPVATTU (
    CCVT_MNCC VARCHAR(7),
    CCVT_MLVT VARCHAR(6),
    CCVT_MCN VARCHAR(50),
    CONSTRAINT FK_CCVT_MNCC FOREIGN KEY (CCVT_MNCC) REFERENCES NHACUNGCAP (MaNhaCungCap) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_CCVT_MLVT FOREIGN KEY (CCVT_MLVT) REFERENCES LOAIVATTU (MaLoaiVatTu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_CCVT_MCN FOREIGN KEY (CCVT_MCN) REFERENCES CHINHANH (MaChiNhanh) ON DELETE CASCADE ON UPDATE CASCADE
);
-- @block 13 -- MaKhachHang is of type KH000001
CREATE TABLE IF NOT EXISTS KHACHHANG(
    MaKhachHang INT(6) ZEROFILL NOT NULL,
    CCCD VARCHAR(12) NOT NULL UNIQUE,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Diem INT NOT NULL DEFAULT 0 CHECK(Diem > -1),
    Loai INT NOT NULL DEFAULT 1 CHECK(Loai > -1),
    CONSTRAINT PK_KHACHHANG PRIMARY KEY (MaKhachHang)
);
-- @block 14 --
CREATE TABLE IF NOT EXISTS GOIDICHVU (
    TenGoi VARCHAR(50),
    SoNgay INT NOT NULL CHECK (
        SoNgay BETWEEN 1 AND 100
    ),
    SoKhach INT NOT NULL CHECK (
        SoKhach BETWEEN 1 AND 10
    ),
    Gia DECIMAL(12, 1) NOT NULL,
    CONSTRAINT PK_GOIDICHVU PRIMARY KEY (TenGoi)
);
-- @block 15 --
CREATE TABLE IF NOT EXISTS HOADONGOIDICHVU (
    HDGDV_MKH VARCHAR(8),
    HDGDV_TG VARCHAR(50),
    NgayGioMua DATETIME NOT NULL,
    NgayBatDau DATETIME NOT NULL,
    /* CHECK (NgayBatDau > NgayGioMua) */
    TongTien INT NOT NULL,
    CONSTRAINT FK_HDGDV_MKH FOREIGN KEY (HDGDV_MKH) REFERENCES KHACHHANG (MaKhachHang) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_HDGDV_TG FOREIGN KEY (HDGDV_TG) REFERENCES GOIDICHVU (TenGoi) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_HOADONGOIDICHVU PRIMARY KEY (NgayGioMua)
);
-- @block 16 --
CREATE TABLE IF NOT EXISTS DONDATPHONG (
    MaDatPhong VARCHAR(16),
    NgayGioDat DATETIME NOT NULL,
    NgayNhanPhong DATETIME NOT NULL,
    /* CHECK (NgayNhanPhong > NgayGioDat) */
    NgayTraPhong DATETIME NOT NULL,
    /* CHECK (NgayTraPhong > NgayNhanPhong) */
    TinhTrang INT NOT NULL CHECK (
        TinhTrang BETWEEN 0 AND 3
    ),
    TongTien INT NOT NULL DEFAULT 0 CHECK(TongTien > -1),
    DDP_MKH VARCHAR(8),
    DDP_TG VARCHAR(50),
    CONSTRAINT FK_DDP_MKH FOREIGN KEY (DDP_MKH) REFERENCES KHACHHANG (MaKhachHang) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_DDP_TG FOREIGN KEY (DDP_TG) REFERENCES GOIDICHVU (TenGoi) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_DONDATPHONG PRIMARY KEY (MaDatPhong)
);
-- @block 17 --
CREATE TABLE IF NOT EXISTS PHONGTHUE (
    PT_MDP VARCHAR(16) NOT NULL,
    PT_MCN VARCHAR(50),
    PT_SP VARCHAR(3) NOT NULL,
    CONSTRAINT FK_PT_MDP FOREIGN KEY (PT_MDP) REFERENCES DONDATPHONG (MaDatPhong) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_PT_MCN FOREIGN KEY (PT_MCN) REFERENCES PHONG (Phong_MCN) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_PT_SP FOREIGN KEY (PT_SP) REFERENCES PHONG (SoPhong) ON DELETE CASCADE ON UPDATE CASCADE
);
-- @block 18 --
CREATE TABLE IF NOT EXISTS HOADON (
    MaHoaDon INT(6) ZEROFILL AUTO_INCREMENT,
    /* Only takes the current hour and minute, the date is already in DonDatPhong */
    ThoiGianNhanPhong DATETIME,
    ThoiGianTraPhong DATETIME,
    HD_MDP VARCHAR(16),
    CONSTRAINT FK_HD_MDP FOREIGN KEY (HD_MDP) REFERENCES DONDATPHONG (MaDatPhong) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PRIMARY KEY (MaHoaDon)
);
-- @block 19 --
CREATE TABLE IF NOT EXISTS DOANHNGHIEP (
    MaDoanhNghiep INT(4) ZEROFILL NOT NULL,
    TenDoanhNghiep VARCHAR(100),
    CONSTRAINT PK_DOANHNGHIEP PRIMARY KEY (MaDoanhNghiep)
);
-- @block 20 --
CREATE TABLE IF NOT EXISTS DICHVU (
    MaDichVu INT(3) ZEROFILL NOT NULL,
    LoaiDichVu VARCHAR(1) NOT NULL,
    SoKhach INT DEFAULT 0 CHECK(SoKhach > -1),
    PhongCach VARCHAR(255),
    DV_MDN VARCHAR(6),
    CONSTRAINT FK_DV_MDN FOREIGN KEY (DV_MDN) REFERENCES DOANHNGHIEP (MaDoanhNghiep) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_DICHVU PRIMARY KEY (LoaiDichVu)
);
-- @block 21 --
CREATE TABLE IF NOT EXISTS ICHVUSPA (
    DVS_MDV VARCHAR(6) NOT NULL,
    DichVuSpa VARCHAR(255),
    CONSTRAINT FK_DVS_MDV FOREIGN KEY (DVS_MDV) REFERENCES DICHVU (MaDichVu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_DICHVUSPA PRIMARY KEY (DichVuSpa)
);
-- @block 22 --
CREATE TABLE IF NOT EXISTS LOAIHANGDOLUUNIEM (
    LHDLN_MDV VARCHAR(6) NOT NULL,
    LoaiHang VARCHAR(255),
    CONSTRAINT FK_LHDLN_MDV FOREIGN KEY (LHDLN_MDV) REFERENCES DICHVU (MaDichVu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_LOAIHANGDOLUUNIEM PRIMARY KEY (LoaiHang)
);
-- @block 23 --
CREATE TABLE IF NOT EXISTS THUONGHIEUDOLUUNIEM (
    THDLN_MDV VARCHAR(6) NOT NULL,
    ThuongHieu VARCHAR(100),
    CONSTRAINT FK_THDLN_MDV FOREIGN KEY (THDLN_MDV) REFERENCES DICHVU (MaDichVu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_THUONGHIEUDOLUUNIEM PRIMARY KEY (ThuongHieu)
);
-- @block 24 --
CREATE TABLE IF NOT EXISTS MATBANG(
    MB_MCN VARCHAR(50) NOT NULL,
    STTMatBang INT NOT NULL UNIQUE DEFAULT 1 CHECK (
        STTMatBang BETWEEN 1 AND 50
    ),
    ChieuDai INT NOT NULL,
    ChieuRong INT NOT NULL,
    GiaThue INT NOT NULL CHECK(GiaThue > -1),
    MoTa VARCHAR(255),
    MB_MDV VARCHAR(6) NOT NULL,
    TenCuaHang VARCHAR(255),
    Logo VARCHAR(255),
    CONSTRAINT FK_MB_MDV FOREIGN KEY (MB_MDV) REFERENCES DICHVU(MaDichVu) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_MB_MCN FOREIGN KEY (MB_MCN) REFERENCES CHINHANH(MaChiNhanh) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_MATBANG PRIMARY KEY (MB_MCN)
);
-- @block 25 --
CREATE TABLE IF NOT EXISTS HINHANHCUAHANG(
    HACH_MCN VARCHAR(50) NOT NULL,
    HACH_STTMatBang INT NOT NULL DEFAULT 1,
    HinhAnh VARCHAR(255),
    CONSTRAINT FK_HACH_MCN_STTMatBang FOREIGN KEY (HACH_MCN, HACH_STTMatBang) REFERENCES MATBANG(MB_MCN, STTMatBang) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_HINHANHCUAHANG PRIMARY KEY (HinhAnh)
);
-- @block 26 --
CREATE TABLE IF NOT EXISTS KHUNGGIOHOATDONG (
    KGHD_MCN VARCHAR(50) NOT NULL,
    KGHD_STTMatBang INT NOT NULL DEFAULT 1,
    GioBatDau TIME,
    GioKetThuc TIME,
    CONSTRAINT FK_KGHD_MCN_STTMatBang FOREIGN KEY (KGHD_MCN, KGHD_STTMatBang) REFERENCES MATBANG(MB_MCN, STTMatBang) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT PK_KHUNGGIOHOATDONG PRIMARY KEY (GioBatDau)
);