<?php
error_reporting(E_ERROR);
require('conn.php');
header('Content-Type: application/json');

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

function check_test_schedule($test_id, $conn){
	date_default_timezone_set("Asia/Calcutta");
	
	//Fetching test details for compare if test is expired or not yet started
	$select_test_q='SELECT Title,StartAt,Duration from tests WHERE Testid ='.$test_id;
	$test = $conn->query($select_test_q);
	if($test->num_rows > 0){
		while($row = $test->fetch_assoc()){
			$test_title = $row["Title"];
			$test_starting_time = strtotime($row["StartAt"]);
			$currentDate=strtotime(date("Y-m-d h:i:sa"));
			$test_duration = strtotime($row["StartAt"]." ".$row["Duration"]);
			$question_object->title =$row["Title"];
		}
	}
	else{
		echo "No Test Found";
	}
		
	//echo $test_title."<br>".$test_starting_time."<br>".$currentDate."<br>".$test_duration."<hr>";
	if($currentDate<$test_starting_time){
		die("Yout test not started!");
	}
	else if($currentDate>$test_duration){
		die("Your Test has been expired!");
	}
	else{
		print_questions($test_id,$conn,$question_object);
	}
}

function print_questions($test_id, $conn, $question_object){
	// fetching question details for printing as object
	$select_question_q='SELECT Questionid,Question,Type, Marks from questions where testid='.$test_id;
	$question = $conn->query($select_question_q);
	if($question->num_rows > 0){
		$question_index=0;
		while($row = $question->fetch_assoc()){
			$question_object->questions[$question_index]->question = $row["Question"];
			$question_object->questions[$question_index]->questionid = $row["Questionid"];
			$question_object->questions[$question_index]->marks = $row["Marks"];
			$question_object->questions[$question_index]->questionType = $row["Type"];
			//fetchin option details for printing as object
			$select_option_q = 'SELECT Optiontext, Optionid from options INNER JOIN questions ON questions.Questionid = options.Questionid WHERE questions.Questionid ='.$row["Questionid"];
			$options = $conn->query($select_option_q);
			if($options->num_rows > 0){
				$option_index=0;
				while($option_row = $options->fetch_assoc()){
					$question_object->questions[$question_index]->optionsGroup[$option_index]->option = $option_row["Optiontext"];
					$question_object->questions[$question_index]->optionsGroup[$option_index]->optionid = $option_row["Optionid"];
					//echo $option_row["Optiontext"]."<br>";
					$option_index++;
				}
			}
			$question_index++;
		}
	}
	else{
		echo "No Question Found :(";
	}
	echo json_encode($question_object);
}
check_test_schedule(1,$conn);

$conn->close();
?>

