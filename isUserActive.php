<?php
session_start();


if(strlen($_SESSION["username"]) <= 0  ){
header ("Location:/team15/index.html"); 
}

?>