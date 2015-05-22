<?php
session_start();
include ('isUserActive.php');
?>
<?php
if($_SESSION["isAdmin"] != '1' ){
header ("Location:/team15/index.html"); 
}
?>
<html>
    <head>
        <title>Administrationsbereich</title>
	<h2>by TK & ChanneZ </h2>
      
    </head>
    <body>
<h2>Neuen Benutzer anlegen</h2>
	<form action="registerUser.php" method="post">
		username:<input type="text" size="24" name="new_username"></br>
 		Passwort:<input type="password" size="24" maxlength="50" name="new_pw"></br>
		Administrator? <input type="radio" name="isAdmin" value="1"> Ja
		<input type="radio" name="isAdmin" value="0" checked> Nein<br>
		<input type="submit" value="Register">
	</form> 

<h2>Benutzer loeschen</h2>
<form action="deleteUser.php" method="post">
		username:<input type="text" size="24" name="new_username"></br>
 				
		<input type="submit" value="Delete">
	</form> 
    </body>
</html>














