package com.schmudu.wedding.view.screens.rsvp.confirmation{
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
	
	public class GuestConfirmationElement extends MovieClip{
		public static var classType										:String = "[object GuestSelectionElement]";
		public static const EVENT_BUTTON_ATTENDING_PRESSED 		:String = "EVENT_BUTTON_ATTENDING_PRESSED";
		public static const EVENT_BUTTON_NOT_ATTENDING_PRESSED 	:String = "EVENT_BUTTON_NOT_ATTENDING_PRESSED";
		public var nameTextField											:TextField;
		public var confirmationAttendanceMC								:ConfirmationAttendanceMC;
		
		private const INSTANCE_NAME_TEXT_FIELD							:String = "nameTextField";
		
		private var _guestData						:Guest;
		private var _siteFont						:SiteFont;
		
		public function GuestConfirmationElement(p_guestData:Guest){
			
			_guestData = p_guestData;
			_siteFont = new SiteFont();
			
			//create text field with the name
			this.createNameTextField();
			
			//create button attendance
			this.createConfirmationAttendanceMC();
		}

/*
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
	*/	
		private function createNameTextField():void{
			nameTextField = this.getChildByName(INSTANCE_NAME_TEXT_FIELD) as TextField;
			//	nameTextField.addEventListener(Event.CHANGE, onTextInputChanged, false, 0, true);
			
			nameTextField.selectable = false;
			if((_guestData.firstName == AppConstants.DATABASE_GUEST_DEFAULT_NAME) && (_guestData.lastName == AppConstants.DATABASE_GUEST_DEFAULT_NAME))
				nameTextField.text = AppConstants.DATABASE_GUEST_DEFAULT_NAME;
			else
				nameTextField.text = _guestData.firstName + " " + _guestData.lastName;
			/*
			guestNameBGMC = this.getChildByName(INSTANCE_NAME_GUEST_NAME_BG) as ElementGuestInputBGMC;
			guestNameBGMC.initWithIntro(true);
			
			//launch bg if guest is anonymous
			if(this.isAnonymous){
				//if guest is anonymous do the following
				guestNameBGMC.launch();
				
				//listen to input
				nameTextField.text = AppConstants.TEXT_ENTER_GUEST_NAME;
			}
			else{
				//if guest is already known, set name
				nameTextField.selectable = false;
				nameTextField.text = _guestData.firstName + " " + _guestData.lastName;
			}
			*/
		}
	
		private function createConfirmationAttendanceMC():void{
			//create button
			confirmationAttendanceMC = new ConfirmationAttendanceMC(_guestData.attending);
			confirmationAttendanceMC.initWithIntro(false);
			
			//position it
			confirmationAttendanceMC.x = AppConstants.GUEST_SELECTION_BUTTON_POS_X;
			
			//add to stage
			addChild(confirmationAttendanceMC);
			
			/*
			//listen
			buttonAttendance.addEventListener(UIObjectEvent.MOUSE_RELEASED, onButtonAttendancePressed, false, 0, true);
			buttonAttendance.addEventListener(ButtonAttendance.EVENT_BUTTON_NOT_ATTENDING_PRESSED, onButtonNotAttendingPressed, false, 0, true);
			buttonAttendance.addEventListener(ButtonAttendance.EVENT_BUTTON_ATTENDING_PRESSED, onButtonAttendingPressed, false, 0, true);
			*/
			//launch
			confirmationAttendanceMC.launch();
		}
	/*
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
		*/
	}
}