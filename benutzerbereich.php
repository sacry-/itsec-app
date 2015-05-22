
<?php
session_start();
include ('isUserActive.php');
?>

<html>
    <head>
        <title>Benutzerverwaltung</title>
	<h2>Hallo <?php echo $_SESSION["username"]; ?> </h2>
      <h3>Ändere hier dein Passwort<h3/>
    </head>
    <body>
<table>      
 <tr>

</tr>
<tr>	<td> <form action="user_update_pw.php" method="post">
            Neues Passwort:<br>
            <input type="text" size="24" maxlength="50"
                   name="pw_new_1"><br><br>
            Passwort wiederholen:<br>
            <input type="password" size="24" maxlength="50"
                   name="pw_new_2"><br>

            <input type="submit" value="Aendern">
        </form>
	</td>
	<td>
	</td>
 </tr>
</table>
<form action="logout.php" method="post">
		<input type="submit" value="Logout">
		</form> 
    </body>
</html>




