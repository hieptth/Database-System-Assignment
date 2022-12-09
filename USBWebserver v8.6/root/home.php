<!DOCTYPE html>
<html>
	<head>
		<meta charset='utf-8'>
		<title>Page Title</title>
		<meta name='viewport' content='width=device-width, initial-scale=1'>
		<link rel='stylesheet' type='text/css' media='screen' href='home.css'>
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
		<h1>HOTEL MANAGEMENT WEBSITE</h1>
		<div id="footer">
			<?php
            // user variables
            $host = "localhost";
            $username = "sManager";
            $password = "mypassword";
            $db = "myhotel";
            $InputErr = $ten = $chinhanh = $nam = "";

            //create database connection
            $conn = new mysqli($host, $username, $password, $db);
            echo "Connected " . $conn->host_info . "\n";
            ?>
		</div>
		<form method="post">
			<p>
				<input type="submit" name="KhachHang" class="button" value="Tra cứu Khách hàng" />
				<?php if (array_key_exists('KhachHang', $_POST))
	                KhachHang();
                ?>
			</p>
			<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
				<div>
					<input type="submit" name="TimKiem" class="button" value="Tìm khách hàng theo tên" />
				</div>
				<div>
					<br>
					Họ tên: <input type="text" name="ten" value="<?php echo $ten; ?>">
					<span class="error">*
						<?php echo $InputErr; ?>
					</span>
					<br><br>
				</div>
				<?php
                if ($_SERVER["REQUEST_METHOD"] == "POST") {
	                if (empty($_POST["ten"]))
		                $InputErr = "Invalid Input";
	                else
		                $ten = $_POST["ten"];
                }
                if (array_key_exists('TimKiem', $_POST))
	                TimKiem($ten);
                ?>
			</form>
			<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
				<div>
					<input type="submit" name="ThongKe" class="button" value="Thống kê số khách của chi nhánh" />
				</div>
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
		                $InputErr = "Invalid Input";
	                else
		                $chinhanh = $_POST["chinhanh"];
	                if (empty($_POST["nam"]))
		                $InputErr = "Invalid Input";
	                else
		                $nam = $_POST["nam"];
                }
                if (array_key_exists('ThongKe', $_POST))
	                ThongKe($chinhanh, $nam);
                ?>
			</form>
		</form>
		<?php
        function KhachHang()
        {
	        global $host, $username, $password, $db;
	        $conn = new mysqli($host, $username, $password, $db);
	        $sql = "SELECT MaKhachhang, CCCD, Email, Username, Diem, Loai FROM KHACHHANG";
	        $result = $conn->query($sql);
	        echo "</br>";

	        if ($result->num_rows > 0) {
		        // output data of each row
        		while ($row = $result->fetch_assoc()) {
			        echo "MaKhachhang: " . $row["MaKhachhang"] . " - CCCD: " . $row["CCCD"] . " - Email: " . $row["Email"] . " - Username: " . $row["Username"] . " - Diem: " . $row["Diem"] . " - Loai: " . $row["Loai"] . "<br>";
		        }
	        } else {
		        echo "0 results.";
	        }
        }
        function TimKiem($ten)
        {
	        echo "Giá trị nhận vào: </br>";
	        echo $ten . "</br></br>";
	        global $host, $username, $password, $db;
	        $conn = new mysqli($host, $username, $password, $db);
	        $sql = "SELECT MaKhachhang, CCCD, Email, Username, Diem, Loai FROM KHACHHANG WHERE ";
	        $result = $conn->query($sql);
	        echo "</br>";

        }
        function ThongKe($chinhanh, $nam)
        {
	        echo "Giá trị nhận vào: </br>";
	        echo $chinhanh . "</br>";
	        echo $nam . "<br>";
	        global $host, $username, $password, $db;
	        $conn = new mysqli($host, $username, $password, $db);
	        $stmt = $db->prepare('CALL ThongKeLuotKhach(?, ?)');
	        $stmt->bind_param('si', $chinhanh, $nam);
	        $stmt->execute();
	        /**
			 * $sql = "CALL ThongKeLuotKhach($chinhanh, $nam)";
			 * $result = mysqli_query($mysqli, $sql);
			 * while ($row = mysqli_fetch_array($result)) {
			 *    echo "$row[Tháng]";
			 *}
			 */

        }
        ?>
	</body>
	<?php
    $conn->close();
    ?>
</html>