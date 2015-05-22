<?php
session_start();
include ('isUserActive.php');
?>

<?php 
$new_user =$_POST['new_username'];
$new_pw = $_POST['new_pw'];
$isAdmin = $_POST['isAdmin'];
echo $new_user;
$benutzerliste = file_get_contents("/var/www/team15/benutzerliste");

$pw_hashed = hash('sha256', $new_pw.strlen($new_user));
file_put_contents("/var/www/team15/benutzerliste", $benutzerliste."\n{".$new_user.";".$pw_hashed.";".$isAdmin."}");
//header ("Location:/team15/administration.php"); 
?>