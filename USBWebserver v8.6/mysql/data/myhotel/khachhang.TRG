TYPE=TRIGGERS
triggers='CREATE DEFINER=`sManager`@`localhost` TRIGGER update_LoaiKhachHang\nBEFORE UPDATE ON KHACHHANG FOR EACH ROW\nBEGIN\n    IF NEW.Diem < 50 THEN SET NEW.Loai = 1;\n    ELSEIF NEW.Diem < 100 THEN SET NEW.Loai = 2;\n    ELSEIF NEW.Diem < 1000 THEN SET NEW.Loai = 3;\n    ELSE SET NEW.Loai = 4;\n    END IF;\nEND'
sql_modes=1073741824
definers='sManager@localhost'
client_cs_names='utf8'
connection_cl_names='utf8_general_ci'
db_cl_names='latin1_swedish_ci'
