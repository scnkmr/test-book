<?php
error_reporting(E_ALL ^ E_NOTICE); 
error_reporting(E_ERROR);
require('conn.php');
header('Content-Type: application/json');

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
//header('Access-Control-Allow-Headers: Origin, Content-Type, Authorization, X-Auth-Token');
header('Access-Control-Allow-Methods: GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS');
$request_method = $_SERVER["REQUEST_METHOD"];
switch($request_method){
    case "POST":
        do_post($conn);
        break;
    case "GET":
        do_get($conn);
        break;
    case "PUT":
        do_put($conn);
        break;
    case "DELETE":   
        do_delete($conn);
        break;
    default:
        echo json_encode(array("status"=>"failed","error_message"=>"HTTP Method not defined :( (default method called)"));
        break;
}
function do_post($conn){
    $signup_data = json_decode(file_get_contents('php://input'));
        if(is_object($signup_data) ||is_array($signup_data)){
            $sql = "INSERT INTO users (Email,Password,FirstName,LastName,Verified) VALUES('".$signup_data->Email."','".password_hash($signup_data->Password, PASSWORD_DEFAULT)."','".$signup_data->First_name."','".$signup_data->Last_name."','".$signup_data->Verified."')";

            if ($conn->query($sql) === TRUE) {
                echo json_encode(array("status"=>"success","error_message"=>"Successfully Registered as username: ".$signup_data->Email));
            } else {
            echo json_encode(array("status"=>"failed","error_message"=>$conn->error));
            }

            $conn->close();
        }
        else{
            echo json_encode(array("status"=>"failed","error_message"=>"Please Enter Valid JSON"));
        }
}
function do_put($conn){
    $signup_update_data = json_decode(file_get_contents('php://input'));
        if(is_object($signup_update_data) ||is_array($signup_update_data)){
            if(isset($_GET["user_id"]) && !empty($signup_update_data->Email) && !empty($signup_update_data->Password) && !empty($signup_update_data->First_name) && !empty($signup_update_data->Last_name)){
                $sql = "UPDATE users SET Email='".$signup_update_data->Email."',Password='".password_hash($signup_update_data->Password, PASSWORD_DEFAULT)."',FirstName='".$signup_update_data->First_name."',LastName='".$signup_update_data->Last_name."' WHERE Userid = ".$_GET["user_id"];

                if ($conn->query($sql) === TRUE) {
                    echo json_encode(array("status"=>"success","error_message"=>"Successfully Updated "));
                } else {
                echo json_encode(array("status"=>"failed","error_message"=>$conn->error));
                }

                $conn->close();
            }
            else{
                echo json_encode(array("status"=>"failed","error_message"=>"Some Field is Empty"));
            }
        }
        else{
            echo json_encode(array("status"=>"failed","error_message"=>"Please Enter Valid JSON"));
        }
}

function do_get($conn){
    if(isset($_GET["user_id"])){
        $sql = "SELECT * FROM users WHERE Userid = ".$_GET["user_id"];
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            echo json_encode(array("status"=>"success","user-id" => $row["Userid"], "Email" => $row["Email"],"First_name" => $row["FirstName"], "Last_name" => $row["LastName"], "Verified"=>$row["Verified"]));
        }
        } else {
        echo json_encode(array("status"=>"failed","error_message"=>"No record found"));
        }


        $conn->close();
    }
    else{
        echo json_encode(array("status"=>"failed","error_message"=>"Invalid Url (user_id Parameter not specified)"));
    }
}
function do_delete($conn){
    if(isset($_GET["user_id"])){
        $sql = "DELETE FROM users WHERE Userid = ".$_GET["user_id"];
        if ($conn->query($sql) === TRUE) {
            echo json_encode(array("status"=>"success","error_message"=>"Successfully Deleted id=  ".$_GET["user_id"]));
          }
        else {
        echo json_encode(array("status"=>"failed","error_message"=>"No record found"));
        }


        $conn->close();
    }
    else{
        echo json_encode(array("status"=>"failed","error_message"=>"Invalid Url (user_id Parameter not specified)"));
    }
}
?>