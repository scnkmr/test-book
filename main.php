<?php
error_reporting(E_ERROR);
function checkSchedule($obj){
date_default_timezone_set("Asia/Calcutta");
$sechDate=strtotime($obj->scheduledTime);
$currentDate=strtotime(date("Y-m-d h:i:sa"));
$duration=strtotime($obj->scheduledTime." ".$obj->testDuration);
if($currentDate>=$sechDate && $currentDate<=$duration){
	
}
elseif($currentDate<=$sechDate){
	echo '{"sechEr":"true","erMsg":"Your Test <span class=\'text-success\'>\''.$obj->testTitle.'\' </span>is Sechedule for <span class=\'text-danger\'>'.date("D d/M/Y @ h:i a", $sechDate).' </span> ","t":"'.$obj->testTitle.'"}';
	die();
}
elseif($currentDate>=$duration){
	echo '{"sechEr":"true","erMsg":"Your Test <span class=\'text-success\'>\' '.$obj->testTitle.' \' </span> has been <span class=\'text-danger\'>Expired!</span><br> Contact to Publisher of Test","t":"'.$obj->testTitle.'"}';
	die();
}
else{
	echo '{"sechEr":"true","erMsg":"Some Error Occured!","t":"OOPs! :( "}';
	die();
}
}
?>
<?php
require('conn.php');
if ($stmt = $con->prepare('SELECT testurl FROM tests WHERE testid = ?')) {
	// Bind parameters (s = string, i = int, b = blob, etc), in our case the username is a string so we use "s"
	$stmt->bind_param('s', $_GET['testid']);
	$stmt->execute();
	// Store the result so we can check if the account exists in the database.
	$stmt->store_result();
	if ($stmt->num_rows > 0) {
	$stmt->bind_result($testurl);
	$stmt->fetch();
	//echo $testurl;
	}
	$stmt->close();
	$con->close();
}
//echo $testurl;
$myFile=fopen("$testurl","r") or die("Unable to Open File| Database Error! <br>Contact website adiministration");
$job=fread($myFile,filesize("qa.json"));
fclose($myFile);
 
$obj=json_decode($job);
checkSchedule($obj);
$cObj->t=$obj->testTitle;
$cObjIndex=0;
foreach ($obj->q as $value) {
	$cObj->q[$cObjIndex]->question->question=$value->question->question;
	$cObj->q[$cObjIndex]->question->options=$value->question->Options;
	$cObjIndex++;
}

echo json_encode($cObj);
?>
