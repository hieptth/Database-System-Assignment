<!DOCTYPE html>
<html>
    <head>
        <title>PHP MySQL Stored Procedure Demo 1</title>
        <link rel="stylesheet" href="home.css" type="text/css" />
    </head>
    <body>
        <?php

        // user variables
        $host = "localhost";
        $username = "sManager";
        $password = "mypassword";
        $dbname = "myhotel";


        try {
            $pdo = new PDO("mysql:host=$host; dbname=$dbname", $username, $password);
            // execute the stored procedure
            $sql = "CALL ThongKeLuotKhach($chinhanh, $nam)";
            // call the stored procedure
            $q = $pdo->query($sql);
            $q->setFetchMode(PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
            die("Error occurred:" . $e->getMessage());
        }
        ?>
        <table>
            <tr>
                <th>Tháng</th>
                <th>Tổng số lượt khách</th>
            </tr>
            <?php while ($r = $q->fetch()): ?>
            <tr>
                <td>
                    <?php echo $r['Tháng'] ?>
                </td>
                <td>
                    <?php echo $r['Tổng số lượt khách'] ?>
                </td>
            </tr>
            <?php endwhile; ?>
        </table>
    </body>
</html>