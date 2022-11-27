-- @block CHINHANH --
INSERT INTO chinhanh (Tinh, DiaChi, DienThoai, Email)
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
        2633286520,
        'ZuZu352@gmail.com'
    );
ALTER TABLE CHINHANH
MODIFY COLUMN MaChiNhanh varchar(50);
UPDATE CHINHANH
SET MaChiNhanh = CONCAT('CN', MaChiNhanh);
-- @block HINHANH_CHINHANH --
INSERT INTO hinhanh_chinhanh (HA_MCN, HinhAnh)
VALUES ('CN1', 'youtube.com'),
    ('CN2', 'amazon.com');