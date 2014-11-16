package com.schmudu.wedding.view.screens.rsvp.guestSelection{
 	import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
	import flash.events.Event;
	import flash.display.MovieClip
	
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.wedding.model.Guest;
	import com.schmudu.wedding.model.RSVPManager;
	import com.schmudu.wedding.constants.SiteFont;
	import com.schmudu.wedding.constants.AppConstants;
	
	public class GuestSelectionElement extends MovieClip{
		public static var classType										:String = "[object GuestSelectionElement]";
		public static const EVENT_BUTTON_ATTENDING_PRESSED 		:String = "EVENT_BUTTON_ATTENDING_PRESSED";
		public static const EVENT_BUTTON_NOT_ATTENDING_PRESSED 	:String = "EVENT_BUTTON_NOT_ATTENDING_PRESSED";
		public var nameTextField											:TextField;
		public var buttonAttendance										:ButtonAttendance;
		public var guestNameBGMC											:ElementGuestInputBGMC;
		
		private const INSTANCE_NAME_GUEST_NAME_BG						:String = "guestNameBGMC";
		private const INSTANCE_NAME_TEXT_FIELD							:String = "nameTextField";
		
		private var _guestData						:Guest;
		private var _siteFont						:SiteFont;
		private var _guestNameChanged				:Boolean;
		private var _selectionMade					:Boolean;
		private var _isAnonymous					:Boolean = false;
		
		public function GuestSelectionElement(p_guestData:Guest){
			
			_guestData = p_guestData;
			
			//if user already set variables then selection has already been made
			if(_guestData.rsvp == 0)
				_selectionMade = false;
			else{
				_selectionMade = true;
				_guestNameChanged = true;
			}
			_siteFont = new SiteFont();
			
			//determine if guest is anonymous
			//if((p_guestData.firstName == AppConstants.DATABASE_GUEST_DEFAULT_NAME))
			if(p_guestData.isAnonymous)
				this.isAnonymous = true;
			else
				this.isAnonymous = false;
				
			
			//create text field with the name
			this.createNameTextField();
			
			//create button attendance
			this.createButtonAttendance();
		}

		public function get guestName():String{
			return nameTextField.text;
		}
		
		public function saveGuestData():void{
			var textString:String = nameTextField.text;
			var splitIndex:int = textString.indexOf(" ");
			
			//save names
			_guestData.firstName = textString.substring(0,splitIndex);
			_guestData.lastName = textString.substring(splitIndex+1,textString.length);
		}
		
		public function nameIsEmpty():Boolean{
			if(String(nameTextField.text).length == 0)
				return true;
			else
				return false;
		}
		
		public function get attending():Boolean{
			if(_guestData.attending == 1)
				return true;
			else
				return false;
		}

		public function get isAnonymous():Boolean{
			return _isAnonymous;
		}	

		public function set isAnonymous(b:Boolean):void{
			_isAnonymous = b;
		}
		
		public function get selectionMade():Boolean{
			return _selectionMade;
		}
	
		public function get guestNameChanged():Boolean{
			return _guestNameChanged;
		}
		
		private function createNameTextField():void{
			nameTextField = this.getChildByName(INSTANCE_NAME_TEXT_FIELD) as TextField;
			nameTextField.addEventListener(Event.CHANGE, onTextInputChanged, false, 0, true);
			
			
			guestNameBGMC = this.getChildByName(INSTANCE_NAME_GUEST_NAME_BG) as ElementGuestInputBGMC;
			guestNameBGMC.initWithIntro(true);
			
			//launch bg if guest is anonymous
			if(this.isAnonymous){
				//if guest is anonymous do the following
				guestNameBGMC.launch();
				
				//listen to input
				if(_guestData.firstName == AppConstants.DATABASE_GUEST_DEFAULT_NAME)
					nameTextField.text = AppConstants.TEXT_ENTER_GUEST_NAME;
				else
					nameTextField.text = _guestData.firstName + " " + _guestData.lastName;
			}
			else{
				//if guest is already known, set name
				nameTextField.selectable = false;
				nameTextField.text = _guestData.firstName + " " + _guestData.lastName;
			}
			
			//set name if anonymous
		}
	
		private function createButtonAttendance():void{
			//create button
			buttonAttendance = new ButtonAttendance(_guestData.rsvp, _guestData.attending);
			buttonAttendance.initWithIntro(true);
			
			//position it
			buttonAttendance.x = AppConstants.GUEST_SELECTION_BUTTON_POS_X;
			
			//add to stage
			addChild(buttonAttendance);
			
			//listen
			buttonAttendance.addEventListener(UIObjectEvent.MOUSE_RELEASED, onButtonAttendancePressed, false, 0, true);
			buttonAttendance.addEventListener(ButtonAttendance.EVENT_BUTTON_NOT_ATTENDING_PRESSED, onButtonNotAttendingPressed, false, 0, true);
			buttonAttendance.addEventListener(ButtonAttendance.EVENT_BUTTON_ATTENDING_PRESSED, onButtonAttendingPressed, false, 0, true);
			
			//launch
			buttonAttendance.launch();
		}
	
		private function onButtonAttendancePressed(evt:Event):void{
			dispatchEvent(new Event(UIObjectEvent.MOUSE_RELEASED));
		}
		
		private function onButtonNotAttendingPressed(evt:Event):void{
			//change guest data
			_guestData.attending = 0;
			_guestData.rsvp = 1;
			_selectionMade = true;
			
			dispatchEvent(new Event(EVENT_BUTTON_NOT_ATTENDING_PRESSED));
		}

		private function onButtonAttendingPressed(evt:Event):void{
			//change guest data
			_guestData.attending = 1;
			_guestData.rsvp = 1;
			_selectionMade = true;
			
			dispatchEvent(new Event(EVENT_BUTTON_ATTENDING_PRESSED));
		}
	
		private function onTextInputChanged(evt:Event):void{
			//input has changed
			_guestNameChanged = true;
		}
	}
}