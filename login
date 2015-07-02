<?php
if (!isset($_SERVER['HTTPS']) || $_SERVER['HTTPS'] !== 'on') {
   if(!headers_sent()) {
        header("Status: 301 Moved Permanently");
        header(sprintf( 'Location: https:%s%s', $_SERVER['HTTP_HOST'], $_SERVER['REQUEST_URI']));
        exit();
    }
}
session_start();
require("login.php");

if (isset($_POST['username'])) {
	$username = $_POST['username'];
	$passwor = $_POST['password'];
	$password = sha1($passwor);
	$sql = "SELECT * FROM `users` WHERE username='".$username."' And password='".$password."' LIMIT 1";
	$res = mysqli_query($connect, $sql) or die(mysqli_error());
if (mysqli_num_rows($res) == 1) {
	$row = mysqli_fetch_assoc($res);
	$_SESSION['uid'] = $row['id'];
	$_SESSION['username'] = $row['username'];
	header("Location: index.php");
	exit();
	} else {
	echo "<html><body><h1>oh nos something wrong</h1></body></html>";

	exit();
}
}
?>
