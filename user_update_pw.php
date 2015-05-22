<?php
session_start();
include ('isUserActive.php');
?>
<?php

$pw1 = $_POST['pw_new_1'];
$pw2 = $_POST['pw_new_2'];


if($pw1 != $pw2){
echo "Passwort stimmt nicht ueberein!";
?>
<br>
<a href="/team15/benutzerbereich.php">Zurueck</a> 

<?php
}

else{


$benutzerliste = file_get_contents("/var/www/team15/benutzerliste");


$pw_old = $_SESSION['id'];
$pw_new = hash('sha256', $pw1.strlen($_SESSION["username"]));
$modified = str_replace($_SESSION['username'].';'.$pw_old,$_SESSION['username'].';'.$pw_new ,  $benutzerliste);

file_put_contents("/var/www/team15/benutzerliste", $modified);
echo "Passwort geaendert";
?>
<br>
<a href="/team15/benutzerbereich.php">Zurueck</a> 

<?php

}





?>

