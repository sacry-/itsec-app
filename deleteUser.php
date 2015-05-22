<?php
session_start();
include ('isUserActive.php');
?>


<?php
$user =$_POST['new_username'];
$showUser = file("/var/www/team15/benutzerliste");
for($i=0; $showUser. < count($mitarbeiter); $i++)
   {
   echo $mitarbeiter[$i]."<br>";
   }
$benutzerliste = file_get_contents("/var/www/team15/benutzerliste");
$modified = str_replace($user , "" ,$benutzerliste);

file_put_contents("/var/www/team15/benutzerliste", $modified);
?>