package com.schmudu.wedding.view.screens.rsvp.guestSelection{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import fl.controls.TextInput;
	import fl.managers.FocusManager;
   
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.iterators.ArrayIterator;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.lib.view01.AbstractComp;
	
	import com.schmudu.wedding.view.screens.MenuButton;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.controller.RSVPController;
	import com.schmudu.wedding.model.Model;
	import com.schmudu.wedding.model.Guest;
	import com.schmudu.wedding.model.RSVPManager;
	import com.schmudu.wedding.view.screens.SubmitButton;
	
	public class SubScreenGuestSelection extends AbstractComp{
		public var submitButton							:SubmitButton;
		public var menuButton							:MenuButton;
		//public var debugTextField						:TextField;
		public var invalidGuestInputMC				:MessageInvalidGuestInput;
		public var selectionForAllMC					:MessageSelectionForAll;
		public var invalidGuestNameMC					:MessageInvalidName;
		public var pleaseSelectAttendanceMC			:MessagePleaseSelectAttendance;
		
		private const INSTANCE_NAME_PLEASE_SELECT			:String = "pleaseSelectAttendanceMC";
		private const INSTANCE_NAME_INVALID_GUEST_NAME	:String = "invalidGuestNameMC";
		private const INSTANCE_NAME_INVALID_GUEST_INPUT	:String = "invalidGuestInputMC";
		private const INSTANCE_NAME_SELECT_FOR_ALL		:String = "selectionForAllMC";
		private const INSTANCE_NAME_SUBMIT_BUTTON			:String = "submitButton";
		private const INSTANCE_NAME_MENU_BUTTON			:String = "menuButton";
		//private const INSTANCE_NAME_DEBUG_TEXTFIELD		:String = "debugTextField";
		
		private var _rsvpController						:RSVPController;
		private var _menuButtonPressed					:Boolean = false;
		private var _rsvpManager							:RSVPManager;
		private var _guestSelectionElementList			:ArrayIterator;
		private var _highestMC								:MovieClip;
		private var _guestAnonymousList					:ArrayIterator;
		
		public function SubScreenGuestSelection(){
		}
		
		public function get menuButtonPressed():Boolean{
			return _menuButtonPressed;
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			//focus manager
			_rsvpController = RSVPController.getInstance();
			_rsvpManager = RSVPManager.getInstance();
			_guestSelectionElementList = new ArrayIterator(new Array());
			_guestAnonymousList = new ArrayIterator(new Array());
			
			//move to a faraway place
			this.x = AppConstants.HIDE_POSITION;
			
			pleaseSelectAttendanceMC = this.getChildByName(INSTANCE_NAME_PLEASE_SELECT) as MessagePleaseSelectAttendance;
			pleaseSelectAttendanceMC.initWithIntro(true);
			
			invalidGuestNameMC = this.getChildByName(INSTANCE_NAME_INVALID_GUEST_NAME) as MessageInvalidName;
			invalidGuestNameMC.initWithIntro(true);
			//debugTextField = this.getChildByName(INSTANCE_NAME_DEBUG_TEXTFIELD) as TextField;

			invalidGuestInputMC = this.getChildByName(INSTANCE_NAME_INVALID_GUEST_INPUT) as MessageInvalidGuestInput;
			invalidGuestInputMC.initWithIntro(true);
			
			selectionForAllMC = this.getChildByName(INSTANCE_NAME_SELECT_FOR_ALL) as MessageSelectionForAll;
			selectionForAllMC.initWithIntro(true);
			
			submitButton = this.getChildByName(INSTANCE_NAME_SUBMIT_BUTTON) as SubmitButton;
			submitButton.initWithIntro(true);
			submitButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			submitButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(submitButton);
			
			menuButton = this.getChildByName(INSTANCE_NAME_MENU_BUTTON) as MenuButton;
			menuButton.initWithIntro(true);
			menuButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			menuButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(menuButton);
				
			//listen
			menuButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMenuButtonPressed, false, 0, true);
			submitButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onSubmitButtonPressed, false, 0, true);
		}
		
		override protected function onFinishedClosingIntro(evt:Event = null):void{
			//move to hide position
			this.x = AppConstants.HIDE_POSITION;
						
			super.onFinishedClosingIntro();
		}
		
		override public function launch():void{
			//reset variables
			_rsvpController.attendanceButtonCurrentlyOpen(false);
				
//debugTextField.appendText("launch.\n");
			positionContentOnScreen();
			
			//launch directions
			pleaseSelectAttendanceMC.launch();
			
			this.createGuestSelectionElements();
			
			//reset button
			_menuButtonPressed = false;
			
			//move to proper position
			this.x = 0;
			onFinishedLaunchingIntro();
			
		}
			
		private function positionContentOnScreen():void{
			//position text
			pleaseSelectAttendanceMC.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + _rsvpManager.guestList.length * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y + AppConstants.MESSAGE_BUFFER_VERTICAL;
			invalidGuestInputMC.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + _rsvpManager.guestList.length * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y + AppConstants.MESSAGE_BUFFER_VERTICAL;
			selectionForAllMC.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + _rsvpManager.guestList.length * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y + AppConstants.MESSAGE_BUFFER_VERTICAL;
			invalidGuestNameMC.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + _rsvpManager.guestList.length * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y + AppConstants.MESSAGE_BUFFER_VERTICAL;
			
			//position buttons also
			//menuButton.y = invalidGuestInputMC.y + AppConstants.BUTTON_BUFFER_VERTICAL;
			submitButton.y = invalidGuestInputMC.y + AppConstants.BUTTON_BUFFER_VERTICAL;
		}
				
		override public function close():void{
			//close and disable close button
			menuButton.disable();
			menuButton.close();
			
			//close messages
			selectionForAllMC.close();
			invalidGuestInputMC.close();
			pleaseSelectAttendanceMC.close();
			hideSelectionForAllMessage();
			
			//remove elements
			this.removeGuestElements();
			
			//close sub components
			closeSubComponentsSimultaneouslyWithCascade(true);
		}
		
		override protected function onFinishedLaunchingElements():void{
//debugTextField.appendText("finished elements.\n");
			dispatchEvent(new Event(UIObjectEvent.FINISHED_LAUNCHING))
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			launchSubComponentsSimultaneouslyWithCascade(true);
		}
		
		protected function onMenuButtonPressed(evt:Event):void{
			_menuButtonPressed = true;
			
			//close screen
			this.close();
		}
		
		private function createGuestSelectionElements():void{
			//get the list of guests
			var guestList:ArrayIterator = _rsvpManager.guestList;
			//var guestSelectionElement:AbstractGuestSelectionElement;
			var guestSelectionElement:MovieClip;
			var guestData:Guest;
			
			//reset list
			guestList.reset();
			
			//cycle through the guest list and create a element for each one
			for(var i:int=0; i<guestList.length; i++){
				//get data
				guestData = Guest(guestList.getCurrentObject());
//debugTextField.appendText("creating guest: \n");
				
				//create new element
				guestSelectionElement = new GuestSelectionElement(guestData);
				
				//if guest is anonmyous push it to the list that we will validate later
				if(guestSelectionElement.isAnonymous){
					_guestAnonymousList.push(guestSelectionElement);
				}
				
				//position it
				guestSelectionElement.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + i * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y;
				guestSelectionElement.x = AppConstants.RSVP_GUEST_SELECTION_POS_X;
				
				//add to stage
				addChild(guestSelectionElement);
				
				//listen
				guestSelectionElement.addEventListener(UIObjectEvent.MOUSE_RELEASED, onGuestSelectionElementPressed, false, 0, true);
				guestSelectionElement.addEventListener(GuestSelectionElement.EVENT_BUTTON_ATTENDING_PRESSED, onSelectionPressed, false, 0, true);
				guestSelectionElement.addEventListener(GuestSelectionElement.EVENT_BUTTON_NOT_ATTENDING_PRESSED, onSelectionPressed, false, 0, true);
				
				//push to list to remove
				_guestSelectionElementList.push(guestSelectionElement);
				//AND HERE, END
				
				//increment
				guestList.increment();
			}
			
			//set the highest element to the last child added
			_highestMC = guestSelectionElement;
			
		}
		
		private function onGuestSelectionElementPressed(evt:Event):void{
			if(_highestMC!=MovieClip(evt.target)){
				//swap depth
				this.swapChildren(_highestMC,MovieClip(evt.target));
				
				//change to new mc
				_highestMC = MovieClip(evt.target);
			}
			
			//change variable that only allows one element to opened at a time
			_rsvpController.attendanceButtonCurrentlyOpen(true);
		}
		
		private function onSelectionPressed(evt:Event):void{	
			//change variable that only allows one element to opened at a time
			_rsvpController.attendanceButtonCurrentlyOpen(false);
		}
		
		private function onSubmitButtonPressed(evt:Event):void{
			
//debugTextField.appendText("submit button pressed.\n");
			//validate input
			if(anonymousGuestListIsInvalid()){
				showInvalidGuestInput();
			}
			else if (!allGuestsSelected()){
				showSelectionForAllMessage();
			}
			else if(!anonymousGuestNamesAreValid()){
				showInvalidGuestNames();
			}
			else{
				//save guest names
				this.saveGuestNames();
				
				//close window
				this.close();
			}
		}
		
		private function removeGuestElements():void{
			var currentElement:MovieClip;
			
			
			//pop all from anonymous list
			while(_guestAnonymousList.length>0)
				_guestAnonymousList.pop();
				
			//pop all of them
			while(_guestSelectionElementList.length>0){
				currentElement = MovieClip(_guestSelectionElementList.pop());
				
				//remove from stage
				this.removeChild(currentElement);
			}
			
				
		}
		
		private function saveGuestNames():void{
			//cycle through the whole list and make sure that each guest has entered a name
			//var validFlag:Boolean = true;
			var i:int = 0;
			var currentElement:GuestSelectionElement;
			
			//reset list
			_guestAnonymousList.reset();
			
			while(i<_guestAnonymousList.length){
				//get element
				currentElement = GuestSelectionElement(_guestAnonymousList.getCurrentObject());
				
				//if the guest is attending and guest name has not changed then invalid
				if((!currentElement.guestNameChanged) && (currentElement.attending) && (currentElement.nameIsEmpty())){
					//if invalid do nothing
				}
				else{
					//save the guest name entered
					currentElement.saveGuestData();
				}
					
				//increment
				i++;
				_guestAnonymousList.increment();
			}
			
			//return false;
		}
		
		
		private function anonymousGuestNamesAreValid():Boolean{
			//cycle through the whole list and make sure that each guest has entered a name
			var namePattern:RegExp = /^([a-z\-]+\s)+[a-z\-]+$/i;
			var validFlag:Boolean = true;
			var i:int = 0;
			var currentElement:GuestSelectionElement;
			
			//reset list
			_guestAnonymousList.reset();
			
			while(i<_guestAnonymousList.length){
				//get element
				currentElement = GuestSelectionElement(_guestAnonymousList.getCurrentObject());
			
				validFlag = namePattern.test(currentElement.guestName);
				
				//if the guest is attending and guest name has not changed then invalid
				if((!validFlag) && (currentElement.attending))
					return false;
					
				//increment
				i++;
				_guestAnonymousList.increment();
			}
			
			return true;
		}
				
		private function anonymousGuestListIsInvalid():Boolean{
			//cycle through the whole list and make sure that each guest has entered a name
			var validFlag:Boolean = true;
			var i:int = 0;
			var currentElement:GuestSelectionElement;
			
			//reset list
			_guestAnonymousList.reset();
			
			while(i<_guestAnonymousList.length){
				//get element
				currentElement = GuestSelectionElement(_guestAnonymousList.getCurrentObject());
			
				//if the guest is attending and guest name has not changed then invalid
				if(((!currentElement.guestNameChanged) && (currentElement.attending)) || (currentElement.nameIsEmpty()))
					return true;
				else{
					//if the guest name is the default and they're attending then also invalid
					if((currentElement.nameTextField.text == AppConstants.TEXT_ENTER_GUEST_NAME)&& (currentElement.attending))
						return true;
				}
					
				//increment
				i++;
				_guestAnonymousList.increment();
			}
			
			return false;
		}
		
		private function allGuestsSelected():Boolean{
			//cycle through the whole list and make sure that each guest has entered a name
			var validFlag:Boolean = true;
			var i:int = 0;
			var currentElement:GuestSelectionElement;
			
			//reset list
			_guestSelectionElementList.reset();
			
			while(i<_guestSelectionElementList.length){
				//get element
				currentElement = GuestSelectionElement(_guestSelectionElementList.getCurrentObject());
				
				//if the designated guest has not made a selection then return false
				if(!currentElement.selectionMade)
					return false;		
					
				//increment
				i++;
				_guestSelectionElementList.increment();
			}
			
			return true;
		}
		
		private function showInvalidGuestNames():void{
			invalidGuestNameMC.launch();
			selectionForAllMC.close();
			invalidGuestInputMC.close();
			pleaseSelectAttendanceMC.close();
		}	

		private function hideInvalidGuestNames():void{
			invalidGuestNameMC.close();
		}
				
		private function showInvalidGuestInput():void{
			selectionForAllMC.close();
			invalidGuestInputMC.launch();
			invalidGuestNameMC.close();
			pleaseSelectAttendanceMC.close();
		}

		private function hideInvalidGuestInput():void{
			invalidGuestInputMC.close();
		}

		private function showSelectionForAllMessage():void{
			invalidGuestInputMC.close();
			selectionForAllMC.launch();
			invalidGuestNameMC.close();
			pleaseSelectAttendanceMC.close();
		}

		private function hideSelectionForAllMessage():void{
			selectionForAllMC.close();
		}
	}
}