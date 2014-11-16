<?php
class Guest{
	public $firstName;
	public $lastName;
	public $groupID;
	public $rsvp;
	public $attending;
	public $id;
	
	public function setFirstName($p_firstName){
		$this->firstName = $p_firstName;
	}
	
	public function getFirstName(){
		return $this->firstName;
	}

	public function setLastName($p_lastName){
		$this->lastName = $p_lastName;
	}

	public function getLastName(){
		return $this->lastName;
	}
	
	public function getID(){
		return $this->id;
	}
	
	public function setID($p_ID){
		$this->id = $p_ID;
	}

	public function setGroupID($p_groupID){
		$this->groupID = $p_groupID;
	}

	public function getGroupID(){
		return $this->groupID;
	}

	public function setRSVP($p_rsvp){
		$this->rsvp = $p_rsvp;
	}

	public function getRSVP(){
		return $this->rsvp;
	}

	public function setAttending($p_attending){
		$this->attending = $p_attending;
	}

	public function getAttending(){
		return $this->attending;
	}

}

?>