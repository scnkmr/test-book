<?php
error_reporting(E_ALL ^ E_NOTICE); 
error_reporting(E_ERROR);
require('conn.php');
header('Content-Type: application/json');

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
//header('Access-Control-Allow-Headers: Origin, Content-Type, Authorization, X-Auth-Token');
header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS');
session_start();
$request_method = $_SERVER["REQUEST_METHOD"];
switch($request_method){
    case "POST":
        do_post($conn);
        break;
    case "GET":
    echo json_encode(array("loggedin"=>false,"status"=>"failed","error_message"=>"HTTP GET not supported :("));
        break;
    case "PUT":
    echo json_encode(array("loggedin"=>false,"status"=>"failed","error_message"=>"HTTP PUT not supported :("));
        break;
    case "DELETE":   
    echo json_encode(array("loggedin"=>false,"status"=>"failed","error_message"=>"HTTP DELETE not supported :("));
        break;
    default:
    echo json_encode(array("loggedin"=>false,"status"=>"failed","error_message"=>"HTTP Method not defined :( (default method called)"));
        break;
}
function do_post($conn){
    $signin_data = json_decode(file_get_contents('php://input'));
        if(is_object($signin_data) ||is_array($signin_data)){
            if ( empty($signin_data->Email) && empty($signin_data->Password) ) {
                exit(json_encode(array("loggedin"=>false,"status"=>"failed","error_message"=>"Email and Passowrd Should not be Blank")));
            }
            if ($stmt = $conn->prepare('SELECT Userid, Password, FirstName, LastName, Verified FROM users WHERE Email = ?')) {
                // Bind parameters (s = string, i = int, b = blob, etc), in our case the username is a string so we use "s"
                $stmt->bind_param('s', $signin_data->Email);
                $stmt->execute();
                // Store the result so we can check if the account exists in the database.
                $stmt->store_result();
                if ($stmt->num_rows > 0) {
                $stmt->bind_result($id, $password, $fname, $lname, $verified);
                $stmt->fetch();
                // Account exists, now we verify the password.
                // Note: remember to use password_hash in your registration file to store the hashed passwords.
                if (password_verify($signin_data->Password, $password)) {
                    session_regenerate_id();
                    $_SESSION['loggedin'] = TRUE;
                    $_SESSION['email'] = $signin_data->Email;
                    $_SESSION['id'] = $id;
                    $_SESSION['name'] = $fname." ".$lname;
                    $user_details=array("Userid"=>$id,"Email"=>$signin_data->Email,"Name"=>$fname." ".$lname,"Verified"=>$verified);
                    echo json_encode(array("loggedin"=>true,"status"=>"success","error_message"=>"Logged in as ".$_SESSION['name'],"user_details"=>$user_details));
                } else {
                    echo json_encode(array("loggedin"=>false,"status"=>"failed","error_message"=>"Incorrect Password! for -> ".$signin_data->Email));
                }
            } else {
                echo json_encode(array("loggedin"=>false,"status"=>"failed","error_message"=>"Incorrect UserName!"));
            }
                $stmt->close();
                $conn->close();
            }
        }
        else{
            echo json_encode(array("status"=>"failed","error_message"=>"Please Enter Valid JSON"));
        }
}
?>