package com.schmudu.wedding.model {
 	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	
	import com.adobe.serialization.json.JSON;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.model.RSVPManager;
	import com.schmudu.lib.events.CustomEvent;
	import com.schmudu.lib.iterators.ArrayIterator;
 
	public class RSVPManager extends EventDispatcher{
		//events
		public static var EVENT_RSVP_ALREADY_CONFIRMED			 	:String = "EVENT_RSVP_ALREADY_CONFIRMED";
		public static var EVENT_RSVP_SERVER_MESSAGE_RECEIVED	 	:String = "EVENT_RSVP_SERVER_MESSAGE_RECEIVED";
		public static var EVENT_SERVER_CALL_USER_LOGIN			 	:String = "EVENT_SERVER_CALL_USER_LOGIN";
		public static var EVENT_USER_NOT_FOUND						:String = "EVENT_USER_NOT_FOUND";
		public static var EVENT_GUEST_LIST_RECEIVED					:String = "EVENT_GUEST_LIST_RECEIVED";
		
		private static var _myInstance									:RSVPManager;
		
		//vars
		private var _serverCallInProgress							:Boolean;
		private var _userNotFound									:Boolean;
		private var _urlLoader										:URLLoader;
		private var _guestList										:ArrayIterator;
		private var _validGuestListReceived							:Boolean;
		private var _oneButtonAttendanceCurrentlyOpen				:Boolean;
		private var _submitRSVPLoader								:URLLoader;
		
		public function RSVPManager(enforcer:SingletonEnforcer){
		}
		
		/* Name: getInstance
		 * Comment: Singleton Pattern.  There should only be one type of view in the application
		 */
		public static function getInstance():RSVPManager{
			 if(RSVPManager._myInstance == null){
				 RSVPManager._myInstance = new RSVPManager(new SingletonEnforcer());
			 }
			 return RSVPManager._myInstance;
		}
		
		public function init():void{
			_guestList = new ArrayIterator(new Array());
			_serverCallInProgress = false;
		}

		public function get oneButtonAttendanceCurrentlyOpen():Boolean{
			return _oneButtonAttendanceCurrentlyOpen;
		}

		public function set oneButtonAttendanceCurrentlyOpen(b:Boolean):void{
			_oneButtonAttendanceCurrentlyOpen = b;
		}

		public function get validGuestListReceived():Boolean{
			return _validGuestListReceived;
		}
		
		public function get serverCallInProgress():Boolean{
			return _serverCallInProgress;
		}

		public function set serverCallInProgress(b:Boolean):void{
			_serverCallInProgress = b;
		}
		
		public function get guestList():ArrayIterator{
			return _guestList;
		}
		
		public function submitGuestDataToServer():void{
			//function creates an array of objects to send to PHP
			//then listens for a response
			var phpGuests:Array = new Array();
			var currentGuest:Guest;
			var phpGuest:Object;
			var i:int = 0;
			
			//reset
			_guestList.reset();
			
			//go through all guests
			while(i<_guestList.length){
				//create new object
				phpGuest = new Object();
				
				//get guest
				currentGuest = Guest(_guestList.getCurrentObject());
				
				//store data into guest
				phpGuest.firstName = currentGuest.firstName;
				phpGuest.lastName = currentGuest.lastName;
				//phpGuest.groupID = currentGuest.groupID;
				phpGuest.rsvp = 1;
				phpGuest.attending = currentGuest.attending;
				phpGuest.id = currentGuest.id;
				
				//push onto array
				phpGuests.push(phpGuest);
				
				//increment
				i++;
				_guestList.increment();
			}
			//create loader
			_submitRSVPLoader = new URLLoader();
			
			//create URL
			var submitURL:String = AppConstants.URL_PHP_SUBMIT_RSVP+"?getPerson";
			
			//create request
			var actionRequest:URLRequest = new URLRequest(submitURL);
			actionRequest.method = URLRequestMethod.POST;
			
			//create variables 
			var actionVariables:URLVariables = new URLVariables();
			
			//var testArray:Array = new Array();
		 	var header:URLRequestHeader = new URLRequestHeader("content-type", "text/plain");
		   	var header2:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");

		   	actionRequest.requestHeaders.push(header);
		   	actionRequest.requestHeaders.push(header2);

		   	actionRequest.method = URLRequestMethod.POST;	
			actionRequest.data = escape(JSON.encode(phpGuests));
			
			//add listener to notify when we're don
			_submitRSVPLoader.addEventListener(Event.COMPLETE, onRSVPSentSuccessfully, false, 0, true);
			_submitRSVPLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_submitRSVPLoader.load(actionRequest);
		}
		
		private function onRSVPSentSuccessfully(evt:Event):void{
			var receiveLoader:URLLoader = URLLoader(evt.target);
			var customEvent:CustomEvent = new CustomEvent(EVENT_RSVP_SERVER_MESSAGE_RECEIVED);
			
			//store the data
			customEvent.customData = String(receiveLoader.data);
			//customEvent.customData = String(evt.target.data);
			
			//remove listener
			_submitRSVPLoader.removeEventListener(Event.COMPLETE, onRSVPSentSuccessfully);
			
			//dispatch event
			dispatchEvent(customEvent);
		}
		
		public function loginUser(p_firstName:String, p_lastName:String):void{
			//dispatch event
			dispatchEvent(new Event(EVENT_SERVER_CALL_USER_LOGIN));
			
			//reset list
			_guestList = null;
			_guestList = new ArrayIterator(new Array());
			_validGuestListReceived = false;
			
			//change status
			this.serverCallInProgress = true;
			
			//set variables
			var variables:URLVariables = new URLVariables();
			variables.firstName = p_firstName;
			variables.lastName = p_lastName;
			
			//create request
			var urlRequest:URLRequest = new URLRequest(AppConstants.URL_PHP_LOGIN);
			urlRequest.method  = URLRequestMethod.GET;
			urlRequest.data = variables;
			
			//send request
			_urlLoader = new URLLoader();
			_urlLoader.load(urlRequest);
			_urlLoader.addEventListener(Event.COMPLETE, onLoginUserResponseReceived, false, 0, true);
		}
		
		private function onLoginUserResponseReceived(evt:Event):void{
			//remove listener
			_urlLoader.removeEventListener(Event.COMPLETE, onLoginUserResponseReceived);
			
			//set data received
			var receivedGuestList:Object = JSON.decode(evt.target.data);
			
			//verify that name was found
			if((receivedGuestList.length == 1) && (receivedGuestList[0].firstName == "NAME_NOT_FOUND")){
				dispatchEvent(new Event(EVENT_USER_NOT_FOUND));
			}
			else{
				var newGuest:Guest;
				
				//set flag
				_validGuestListReceived = true;
				
				//save each guest
				for (var i:int = 0; i<receivedGuestList.length; i++){
					//create new guest
					newGuest = new Guest();

					//set vars
					newGuest.firstName = String(receivedGuestList[i].firstName);
					newGuest.lastName = String(receivedGuestList[i].lastName);
					newGuest.groupID = int(receivedGuestList[i].groupID);
					newGuest.rsvp = int(receivedGuestList[i].rsvp);
					newGuest.attending = int(receivedGuestList[i].attending);
					newGuest.id = int(receivedGuestList[i].id);
					newGuest.init();
					
					//push guest onto list
					_guestList.push(newGuest);
					
					//output_text.appendText("First Name: " + String(guests[i].firstName) + "\n");
				}
				
				//check if already confirmed
				if(receivedGuestList[0].rsvp == 1){
					//if user has already rsvp-ed
					dispatchEvent(new Event(EVENT_RSVP_ALREADY_CONFIRMED));
				}
				else
					dispatchEvent(new Event(EVENT_GUEST_LIST_RECEIVED));
				
			}
			
				
			//change status
			this.serverCallInProgress = false;
			
		}
	}
}
class SingletonEnforcer{}
