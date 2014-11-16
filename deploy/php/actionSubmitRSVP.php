
<?php 
include('./../../../lib/constantsLogin.php');
include("classGuest.php");

$returnMessage = 'MESSAGE_RSVP_SUCCESSFUL';
/*
class Person
{
   public $first_name;
   public $last_name;
   public $email;
}*/

//get parameter from variables
if(isset($_GET['getPerson']))
{
	$jsonString = urldecode(@file_get_contents('php://input'));
   	$jsonString = str_replace("\\", "", $jsonString);

	//decode array of objects
	$data = json_decode($jsonString);			//works with array of objects
	
	//create connection
	$con = mysql_connect($server, $user, $pass) or die ("FAILED_CONNECTION");

	//select database
	$selected = mysql_select_db($db,$con);
	
	foreach($data as $guest){
		//update table
		$result = mysql_query("update guests set first_name='$guest->firstName', last_name='$guest->lastName', rsvp='$guest->rsvp', attending='$guest->attending' where id=$guest->id");

		//if any of them are a failure then return this message
		if(!$result)
			$returnMessage = 'MESSAGE_RSVP_FAILED';
		else{
			//send email 
			
			//set variable based on attending
			if($guest->attending == 1)
				$attending = "Attending";
			else
				$attending = "Not Attending";
				
			$to = "patrick.robin.lee@gmail.com, kokonishi32@gmail.com";
			$subject = "Wedding RSVP :: $guest->firstName $guest->lastName :: $attending";
			$body = "RSVP Confirmed";
			
			//send email
			mail($to,$subject,$body);
		}

	}
	
		//close connection
	mysql_close($con);
}

//echo return message
echo($returnMessage);
?>