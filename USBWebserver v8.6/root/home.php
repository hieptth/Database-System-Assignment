<!DOCTYPE html>
<html>
	<head>
		<meta charset='utf-8'>
		<title>Page Title</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<link rel='stylesheet' type='text/css' media='screen' href='home.css'>
		<style type="text/css">
			table,
			th,
			td {
				border: 1px solid black;
			}

			.wrapper {
				margin-left: 10px;
				padding-left: 10px;
				padding-right: 10px;
				width: 1460px;
				height: fit-content;
				border: 1px solid black;
				background-color: aliceblue;
			}
		</style>
		<script src='main.js'></script>
		<style>
			#footer {
				position: fixed;
				padding: 10px 10px 0px 10px;
				bottom: 0;
				width: 100%;
				/* Height of the footer*/
				height: 60px;
				background: white;
			}
		</style>
	</head>
	<body>
		<h1 style="padding-left: 10px;">HOTEL MANAGEMENT WEBSITE</h1>
		<?php
        // user variables
        $host = "localhost";
        $username = "sManager";
        $password = "mypassword";
        $db = "myhotel";
        $InputErr = $mkh = $ten = $chinhanh = $nam = "";
        $mlp = $tlp = $dt = $sk = $gkt = $gsl = $mtk = $vt = "";

        //create database connection
        $conn = new mysqli($host, $username, $password, $db);
        ?>
		<form method="post">
			<!-- Tra cứu khách hàng -->
			<div class="wrapper">
				<p>
					<input type="submit" name="KhachHang" class="button" value="Tra cứu Khách hàng" />
					<?php if (array_key_exists('KhachHang', $_POST))
	                    KhachHang();
                    ?>
				</p>
			</div>
			<br>
			<!-- Tìm Khách Hàng theo tên -->
			<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
				<div class="wrapper">
					<p>
						<input type="submit" name="TimKiem" class="button" value="Tìm khách hàng theo tên" />
					</p>
					<div>
						Họ tên: <input type="text" name="ten" value="<?php echo $ten; ?>">
						<br><br>
					</div>
					<?php
                    if ($_SERVER["REQUEST_METHOD"] == "POST") {
	                    if (empty($_POST["ten"]))
		                    $InputErr = " ";
	                    else
		                    $ten = $_POST["ten"];
                    }
                    if (array_key_exists('TimKiem', $_POST))
	                    TimKiem($ten);
                    ?>
				</div>
				<br>
			</form>
			<!-- Tìm đơn đặt phòng theo mã khách hàng -->
			<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
				<div class="wrapper">
					<p>
						<input type="submit" name="TimDP" class="button" value="Tìm đơn đặt phòng theo Mã Khách Hàng" />
					</p>
					<div>
						Mã Khách hàng: <input type="text" name="mkh" value="<?php echo $mkh; ?>">
						<br><br>
					</div>
					<?php
                    if ($_SERVER["REQUEST_METHOD"] == "POST") {
	                    if (empty($_POST["mkh"]))
		                    $InputErr = " ";
	                    else
		                    $mkh = $_POST["mkh"];
                    }
                    if (array_key_exists('TimDP', $_POST))
	                    TimDP($mkh);
                    ?>
				</div>
				<br>
			</form>
			<!-- Thêm thông tin cho loại phòng -->
			<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
				<div class="wrapper">
					<p>
						<input type="submit" name="Insert" class="button" value="Thêm loại phòng" />
					</p>
					<div>
						<br>
						Mã loại phòng: <input type="text" name="mlp" value="<?php echo $mlp; ?>">
						<br><br>
						Tên loại phòng: <input type="text" name="tlp" value="<?php echo $tlp; ?>">
						<br><br>
						Diện tích: <input type="text" name="dt" value="<?php echo $dt; ?>">
						<br><br>
						Số khách tối đa: <input type="text" name="sk" value="<?php echo $sk; ?>">
						<br><br>
						Thông tin giường - kích thước: <input type="text" name="gkt" value="<?php echo $gkt; ?>">
						<br><br>
						Thông tin giường - số lượng: <input type="text" name="gsl" value="<?php echo $gsl; ?>">
						<br><br>
						Mô tả khác: <input type="text" name="mtk" value="<?php echo $mtk; ?>">
						<br><br>
						Vật tư: <input type="text" name="vt" value="<?php echo $vt; ?>">
						<br><br>
					</div>
					<?php

                    if ($_SERVER["REQUEST_METHOD"] == "POST") {
	                    if (empty($_POST["mlp"]))
		                    $InputErr = " ";
	                    else
		                    $mlp = $_POST["mlp"];
	                    if (empty($_POST["tlp"]))
		                    $InputErr = " ";
	                    else
		                    $tlp = $_POST["tlp"];
	                    if (empty($_POST["dt"]))
		                    $InputErr = " ";
	                    else
		                    $dt = $_POST["dt"];
	                    if (empty($_POST["sk"]))
		                    $InputErr = " ";
	                    else
		                    $sk = $_POST["sk"];
	                    if (empty($_POST["gkt"]))
		                    $InputErr = " ";
	                    else
		                    $gkt = $_POST["gkt"];
	                    if (empty($_POST["gsl"]))
		                    $InputErr = " ";
	                    else
		                    $gsl = $_POST["gsl"];
	                    if (empty($_POST["mtk"]))
		                    $InputErr = " ";
	                    else
		                    $mtk = $_POST["mtk"];
                    }
                    if (array_key_exists('Insert', $_POST))
	                    Insert($tlp, $dt, $sk, $mtk);
                    ?>
				</div>
				<br>
			</form>
			<!-- Thống kê số lượt khách -->
			<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
				<div class="wrapper">
					<p>
						<input type="submit" name="ThongKe" class="button" value="Thống kê số khách của chi nhánh" />
					</p>
					<div>
						<br>
						Chi nhánh: <input type="text" name="chinhanh" value="<?php echo $chinhanh; ?>">
						<span class="error">*
							<?php echo $InputErr; ?>
						</span>
						<br><br>
					</div>
					<div>
						Năm: <input type="text" name="nam" value="<?php echo $nam; ?>">
						<span class="error">*
							<?php echo $InputErr; ?>
						</span>
						<br><br>
					</div>
					<?php
                    if ($_SERVER["REQUEST_METHOD"] == "POST") {
	                    if (empty($_POST["chinhanh"]))
		                    $InputErr = "";
	                    else
		                    $chinhanh = $_POST["chinhanh"];
	                    if (empty($_POST["nam"]))
		                    $InputErr = " ";
	                    else
		                    $nam = $_POST["nam"];
                    }
                    if (array_key_exists('ThongKe', $_POST))
	                    ThongKe($chinhanh, $nam);
                    ?>
				</div>
				<br>
			</form>
		</form>
		<?php
        function KhachHang()
        {
	        global $host, $username, $password, $db;
	        $conn = new mysqli($host, $username, $password, $db);
	        $sql = "SELECT MaKhachhang, CCCD, HoTen, Email, Username, Diem, Loai FROM KHACHHANG";
	        $result = $conn->query($sql);
	        echo "</br>";

	        if ($result->num_rows > 0) {
		        echo "<table>";
		        echo "<tr>";
		        echo "<th> Mã Khách Hàng </th>";
		        echo "<th> CCCD </th>";
		        echo "<th> Họ tên </th>";
		        echo "<th> Email </th>";
		        echo "<th> Username </th>";
		        echo "<th> Điểm </th>";
		        echo "<th> Loại </th>";
		        echo "</tr>";

		        while ($row = $result->fetch_assoc()) {
			        echo "<tr>";
			        echo "<td>" . $row['MaKhachhang'] . "</td>";
			        echo "<td>" . $row['CCCD'] . "</td>";
			        echo "<td>" . $row['HoTen'] . "</td>";
			        echo "<td>" . $row['Email'] . "</td>";
			        echo "<td>" . $row['Username'] . "</td>";
			        echo "<td>" . $row['Diem'] . "</td>";
			        echo "<td>" . $row['Loai'] . "</td>";
			        echo "</tr>";
		        }
		        echo "</table>";
	        } else {
		        echo "0 results.";
	        }
        }
        function TimKiem($ten)
        {
	        global $host, $username, $password, $db;
	        $conn = new mysqli($host, $username, $password, $db);
	        $sql = "SELECT MaKhachhang, CCCD, HoTen, Email, Username, Diem, Loai FROM KHACHHANG WHERE HoTen = '$ten'";
	        $result = $conn->query($sql);

	        if ($result->num_rows > 0) {
		        echo "<table>";
		        echo "<tr>";
		        echo "<th> Mã Khách Hàng </th>";
		        echo "<th> CCCD </th>";
		        echo "<th> Họ tên </th>";
		        echo "<th> Email </th>";
		        echo "<th> Username </th>";
		        echo "<th> Điểm </th>";
		        echo "<th> Loại </th>";
		        echo "</tr>";

		        while ($row = $result->fetch_assoc()) {
			        echo "<tr>";
			        echo "<td>" . $row['MaKhachhang'] . "</td>";
			        echo "<td>" . $row['CCCD'] . "</td>";
			        echo "<td>" . $row['HoTen'] . "</td>";
			        echo "<td>" . $row['Email'] . "</td>";
			        echo "<td>" . $row['Username'] . "</td>";
			        echo "<td>" . $row['Diem'] . "</td>";
			        echo "<td>" . $row['Loai'] . "</td>";
			        echo "</tr>";
		        }
		        echo "</table>";
	        } else {
		        echo "0 results.";
	        }
	        echo "<br>";
        }
        function TimDP($mkh)
        {
	        global $host, $username, $password, $db;
	        $conn = new mysqli($host, $username, $password, $db);
	        $sql = "SELECT MaDatPhong, NgayGioDat, SoKhach, NgayNhanPhong, NgayTraPhong, TongTien, TinhTrang FROM DONDATPHONG WHERE DDP_MKH = '$mkh'";
	        $result = $conn->query($sql);

	        if ($result->num_rows > 0) {
		        echo "<table>";
		        echo "<tr>";
		        echo "<th> Mã Đặt Phòng </th>";
		        echo "<th> Ngày Giờ Đặt </th>";
		        echo "<th> Số Khách </th>";
		        echo "<th> Ngày Nhận Phòng </th>";
		        echo "<th> Ngày Trả Phòng </th>";
		        echo "<th> Tổng tiền </th>";
		        echo "<th> Tình trạng </th>";
		        echo "</tr>";

		        while ($row = $result->fetch_assoc()) {
			        echo "<tr>";
			        echo "<td>" . $row['MaDatPhong'] . "</td>";
			        echo "<td>" . $row['NgayGioDat'] . "</td>";
			        echo "<td>" . $row['SoKhach'] . "</td>";
			        echo "<td>" . $row['NgayNhanPhong'] . "</td>";
			        echo "<td>" . $row['NgayTraPhong'] . "</td>";
			        echo "<td>" . $row['TongTien'] . "</td>";
			        echo "<td>" . $row['TinhTrang'] . "</td>";
			        echo "</tr>";
		        }
		        echo "</table>";
	        } else {
		        echo "0 results.";
	        }
	        echo "<br>";
        }
        function Insert($tlp, $dt, $sk, $mtk)
        {
	        global $host, $username, $password, $db;
	        $conn = new mysqli($host, $username, $password, $db);
	        $sql = "INSERT INTO LOAIPHONG (TenLoaiPhong, DienTich, SoKhach, MoTaKhac) VALUES ('$tlp', '$dt', '$sk', '$mtk')";
	        $conn->query($sql);
	        echo "</br>";
        }
        function ThongKe($chinhanh, $nam)
        {
	        global $host, $username, $password, $db;
	        $conn = new mysqli($host, $username, $password, $db);
	        $conn->multi_query("CALL ThongKeLuotKhach('$chinhanh','$nam')");
	        $result = $conn->store_result();

	        if ($result->num_rows > 0) {
		        echo "<table>";
		        echo "<tr>";
		        echo "<th> Tháng </th>";
		        echo "<th> Tổng số lượt Khách </th>";
		        echo "</tr>";
		        while ($row = $result->fetch_assoc()) {
			        echo "<tr>";
			        echo "<td>" . $row['Thang'] . "</td>";
			        echo "<td>" . $row['Tong so luot khach'] . "</td>";
			        echo "</tr>";
		        }
		        echo "</table>";
	        } else {
		        echo "0 results.";
	        }
	        echo "</br>";
        }
        ?>
	</body>
	<?php
    $conn->close();
    ?>
</html>