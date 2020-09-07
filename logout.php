<?php
header('Content-Type: application/json');

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
//header('Access-Control-Allow-Headers: Origin, Content-Type, Authorization, X-Auth-Token');
header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS');
session_start();
session_unset();
session_destroy();
echo json_encode(array("loggedin"=>false,"status"=>"success","error_message"=>"Logged Out successfully!"));
?>