package com.schmudu.wedding.model{
	
	import com.schmudu.wedding.constants.AppConstants;
	
	public class Guest{

		//vars
		private var _firstName							:String;
		private var _isAnonymous						:Boolean;
		private var _lastName							:String;
		private var _groupID								:int;
		private var _rsvp									:int;
		private var _attending							:int;
		private var _id									:int;
		
		public function Guest(){
		}
		
		public function get firstName():String{
			return _firstName;
		}
		
		public function init():void{
			//determine if its a guest or not
			if(firstName == AppConstants.DATABASE_GUEST_DEFAULT_NAME)
				_isAnonymous = true;
			else
				_isAnonymous = false;
		}
		
		public function get isAnonymous():Boolean{
			return _isAnonymous;
		}
		
		public function set firstName(s:String):void{
			_firstName = s;
		}

		public function get lastName():String{
			return _lastName;
		}

		public function set lastName(s:String):void{
			_lastName = s;
		}

		public function get groupID():int{
			return _groupID;
		}

		public function set groupID(i:int):void{
			_groupID = i;
		}

		public function get rsvp():int{
			return _rsvp;
		}

		public function set rsvp(i:int):void{
			_rsvp = i;
		}

		public function get attending():int{
			return _attending;
		}

		public function set attending(i:int):void{
			_attending = i;
		}

		public function get id():int{
			return _id;
		}

		public function set id(i:int):void{
			_id = i;
		}
	}
}
