
<?php 
include('./../../../lib/constantsLogin.php');
include("classGuest.php");

//get variables from Flash
$userFirstName = $_GET['firstName'];
$userLastName = $_GET['lastName'];
//$userFirstName = 'Patrick';
//$userLastName = 'Lee';

//create connection
$con = mysql_connect($server, $user, $pass) or die ("FAILED_CONNECTION");

//select database
$selected = mysql_select_db($db,$con);

//query database
$result = mysql_query("select * from $table where last_name='$userLastName' and first_name='$userFirstName'");
//$result = mysql_query("select * from $table where last_name='Lee' and first_name='Patrick'");


//check if empty, result should only be one
if (mysql_num_rows($result) == 0) {
  	
	$guest[0] = new Guest();
	$guest[0]->setFirstName('NAME_NOT_FOUND');
	$guest[0]->setLastName('');
	$guest[0]->setAttending('');
	$guest[0]->setRSVP('');
	$guest[0]->setGroupID('');
	$guest[0]->setID('');
	
	//echo "NO_RESULT";
    //exit;
}
else if(mysql_num_rows($result) == 2){
	$guest[0] = new Guest();
	$guest[0]->setFirstName('DUPLICATE_NAMES');
	$guest[0]->setLastName('');
	$guest[0]->setAttending('');
	$guest[0]->setRSVP('');
	$guest[0]->setGroupID('');
	$guest[0]->setID('');
	//exit;
}
else{
	$userRow = mysql_fetch_assoc($result);
	$userGroupID = $userRow['group_id'];
	
	//query database for all matching guests
	$result = mysql_query("select * from $table where group_id='$userGroupID'");

	//counter
	$i=0;

	//cycle through all the indexed guests
	while ($row = mysql_fetch_array($result, MYSQL_ASSOC)) {
		//get values from row
		$myFirstName = $row["first_name"];
		$myLastName = $row["last_name"];
		$myAttending = $row["attending"];
		$myRSVP = $row["rsvp"];
		$myGroupID = $row["group_id"];
		$myID = $row["id"];

		//create new object
		$guest[$i] = new Guest();
		$guest[$i]->setFirstName($myFirstName);
		$guest[$i]->setLastName($myLastName);
		$guest[$i]->setAttending($myAttending);
		$guest[$i]->setRSVP($myRSVP);
		$guest[$i]->setGroupID($myGroupID);
		$guest[$i]->setID($myID);

		//increment
		$i++;
	}
}

//print out first names of all guests and send to JSON (Flash)
echo json_encode($guest);
//echo json_encode($userFirstName);

//close connection
mysql_close($con);

?>