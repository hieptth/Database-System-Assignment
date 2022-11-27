-- @block CHINHANH --
INSERT INTO chinhanh (MaChiNhanh, Tinh, DiaChi, DienThoai, Email)
VALUES (
        '',
        'Alime',
        'OnePiece',
        0901392331,
        'ChienHugo111@gmail.com'
    ),
    (
        'CCC',
        'Alimu',
        'Bleach',
        0800281220,
        'DuySocket222@gmail.com'
    );
UPDATE CHINHANH
SET MaChiNhanh = CONCAT('CN', id);