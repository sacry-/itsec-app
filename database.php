<?php

function db_path(){ return 'database.csv'; }

function write($data)
{
  $fp = fopen(db_path(), "w");
  foreach ($data as $fields) {
    fputcsv($fp, $fields);
  }
  fclose($fp);
}

function get_data()
{
  $file = fopen(db_path(),"r");

  $data = array();
  while($line = fgetcsv($file)){
    $data[] = $line;
  }
  fclose($file);
  return $data;
}

function show($username)
{
  $data = get_data();
  foreach($data as $val) {
    if($username == $val[0]){
      return $val;
    }
  }
  return null;
}

function has_user($username)
{
  show($username) != null;
}

function save($username, $pwd, $admin)
{
  $data = get_data();
  $entry = array( $username, $pwd, strval($admin) );

  $changed = False;
  $new_data = array();
  foreach($data as $val) {
    if($username == $val[0]){
      $new_data[] = $entry;
      $changed = True;
    } else {
      $new_data[] = $val;
    }
  }

  if(!$changed){
    $new_data[] =  $entry;
  }

  write($new_data);

  return has_user($username);
}

function delete($username)
{
  $data = get_data();
  $new_data = array();
  foreach($data as $val) {
    if($username != $val[0]){
      $new_data[] = $val;
    }
  }
  write($new_data);
  return has_user($username);
}

?>