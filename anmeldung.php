<?php
session_start();
include ('isUserActive.php');
?>

<?php

$username = $_POST["username"];
$password = $_POST["password"];

$benutzerliste = file_get_contents("/var/www/team15/benutzerliste");
$salt  = strlen($username);
$hashed_pw = hash('sha256', $password . $salt);


$found = strpos( $benutzerliste, "{" . $username . ";" . $hashed_pw . ";" );


if($found == false) {
    echo "Benutzername und/oder Passwort waren falsch. <a href=\"index.html\">Login</a>";
 
 }else {

    $isAdmin = $found+strlen("{" . $username . ";" . $hashed_pw . ";");
    echo substr($benutzerliste, $isAdmin, 1);

    $_SESSION["id"] = $hashed_pw;
    $_SESSION["isAdmin"] = substr($benutzerliste, $isAdmin, 1);
    $_SESSION["username"] = $username;

if($_SESSION["isAdmin"] == 1 ){
header ("Location:/team15/administration.php"); 
}else{
header ("Location:/team15/benutzerbereich.php"); 
}


    }

?>







