package com.schmudu.wedding.view.screens.rsvp.confirmation{
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
	import com.schmudu.wedding.view.screens.rsvp.guestSelection.*;
	
	public class SubScreenGuestConfirmation extends AbstractComp{
		//public var debugTextField						:TextField;
		public var confirmButton						:ButtonConfirm;
		public var backButton							:ButtonBack;
		public var menuButton							:MenuButton;
		public var pleaseConfirmMC						:MessagePleaseConfirm;
		
		private const INSTANCE_NAME_PLEASE_CONFIRM		:String = "pleaseConfirmMC";
		private const INSTANCE_NAME_MENU_BUTTON			:String = "menuButton";
		private const INSTANCE_NAME_CONFIRM_BUTTON			:String = "confirmButton";
		private const INSTANCE_NAME_BACK_BUTTON			:String = "backButton";
		
		private var _rsvpController						:RSVPController;
		private var _menuButtonPressed					:Boolean = false;
		private var _rsvpManager							:RSVPManager;
		private var _guestSelectionElementList			:ArrayIterator;
		private var _backButtonPressed					:Boolean = false;
		private var _confirmButtonPressed				:Boolean = false;
		
		public function SubScreenGuestConfirmation(){
		}
		
		public function get confirmButtonPressed():Boolean{
			return _confirmButtonPressed;
		}		
		
		public function get backButtonPressed():Boolean{
			return _backButtonPressed;
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
			//_guestAnonymousList = new ArrayIterator(new Array());
			
			//move to a faraway place
			this.x = AppConstants.HIDE_POSITION;
			
			
			pleaseConfirmMC = this.getChildByName(INSTANCE_NAME_PLEASE_CONFIRM) as MessagePleaseConfirm;
			pleaseConfirmMC.initWithIntro(true);
			
			backButton = this.getChildByName(INSTANCE_NAME_BACK_BUTTON) as ButtonBack;
			backButton.initWithIntro(true);
			backButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			backButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(backButton);
			
			confirmButton = this.getChildByName(INSTANCE_NAME_CONFIRM_BUTTON) as ButtonConfirm;
			confirmButton.initWithIntro(true);
			confirmButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			confirmButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(confirmButton);
			
			menuButton = this.getChildByName(INSTANCE_NAME_MENU_BUTTON) as MenuButton;
			menuButton.initWithIntro(true);
			menuButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			menuButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(menuButton);
				
			//listen
			menuButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMenuButtonPressed, false, 0, true);
			confirmButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onConfirmButtonPressed, false, 0, true);
			backButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onBackButtonPressed, false, 0, true);
		}
		
		override protected function onFinishedClosingIntro(evt:Event = null):void{
			//move to hide position
			this.x = AppConstants.HIDE_POSITION;
						
			super.onFinishedClosingIntro();
		}
		
		override public function launch():void{
			//reset variables
			_backButtonPressed = false;
			_confirmButtonPressed = false;
			_menuButtonPressed = false;
			//_rsvpController.attendanceButtonCurrentlyOpen(false);
			
			positionContentOnScreen();
			
			//create elements
			this.createGuestConfirmationElements();
			
			//show text
			pleaseConfirmMC.launch();
			
			//reset button
			_menuButtonPressed = false;
			
			//move to proper position
			this.x = 0;
			onFinishedLaunchingIntro();
			
		}
		
		private function positionContentOnScreen():void{
			//show text and position it
			pleaseConfirmMC.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + _rsvpManager.guestList.length * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y + AppConstants.MESSAGE_BUFFER_VERTICAL;
			
			//position buttons also
			//menuButton.y = pleaseConfirmMC.y + AppConstants.BUTTON_BUFFER_VERTICAL;
			confirmButton.y = pleaseConfirmMC.y + AppConstants.BUTTON_BUFFER_VERTICAL;
			backButton.y = pleaseConfirmMC.y + AppConstants.BUTTON_BUFFER_VERTICAL;
		}
		
		override public function close():void{
			//close and disable close button
			menuButton.disable();
			menuButton.close();
			
			//close messages
			pleaseConfirmMC.close();
			
			//remove elements
			this.removeGuestElements();
			
			//close sub components
			closeSubComponentsSimultaneouslyWithCascade(true);
		}
		
		override protected function onFinishedLaunchingElements():void{
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
		
		
		protected function onBackButtonPressed(evt:Event):void{
			_backButtonPressed = true;
			
			//close screen
			this.close();
		}
				
		private function createGuestConfirmationElements():void{
			//get the list of guests
			var guestList:ArrayIterator = _rsvpManager.guestList;
			//var guestSelectionElement:AbstractGuestSelectionElement;
			var guestSelectionElement:GuestConfirmationElement;
			var guestData:Guest;
			
			//reset list
			guestList.reset();
			
			//cycle through the guest list and create a element for each one
			for(var i:int=0; i<guestList.length; i++){
				//get data
				guestData = Guest(guestList.getCurrentObject());
				// ERROR BETWEEN
				
				//create new element
				guestSelectionElement = new GuestConfirmationElement(guestData);
				
				
				//if guest is anonmyous push it to the list that we will validate later
				
				//if(guestSelectionElement.isAnonymous){
				//	_guestAnonymousList.push(guestSelectionElement);
				//}
				
				//position it
				guestSelectionElement.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + i * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y;
				guestSelectionElement.x = AppConstants.RSVP_GUEST_SELECTION_POS_X;
				
				//add to stage
				addChild(guestSelectionElement);
				
				//listen
				//guestSelectionElement.addEventListener(UIObjectEvent.MOUSE_RELEASED, onGuestSelectionElementPressed, false, 0, true);
				//guestSelectionElement.addEventListener(GuestSelectionElement.EVENT_BUTTON_ATTENDING_PRESSED, onSelectionPressed, false, 0, true);
				//guestSelectionElement.addEventListener(GuestSelectionElement.EVENT_BUTTON_NOT_ATTENDING_PRESSED, onSelectionPressed, false, 0, true);
				
				//push to list to remove
				_guestSelectionElementList.push(guestSelectionElement);
				//AND HERE, END
				
				//increment
				guestList.increment();
			}
			
			//set the highest element to the last child added
			//_highestMC = guestSelectionElement;
			
		}
		
		/*
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
		*/
		private function onConfirmButtonPressed(evt:Event):void{
			_confirmButtonPressed = true;
			
			/*//validate input
			if(anonymousGuestListIsInvalid()){
				showInvalidGuestInput();
			}
			else if (!allGuestsSelected()){
				showSelectionForAllMessage();
			}
			else{
				this.close();
			}*/
			this.close();
		}
		
		private function removeGuestElements():void{
			var currentElement:MovieClip;
			
			/*
			//pop all from anonymous list
			while(_guestAnonymousList.length>0)
				_guestAnonymousList.pop();
			*/	
			//pop all of them
			while(_guestSelectionElementList.length>0){
				currentElement = MovieClip(_guestSelectionElementList.pop());
				
				//remove from stage
				this.removeChild(currentElement);
			}
			
				
		}
		/*
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
					
				if(!currentElement.attending){
					//do nothing if the guest is not attending
				}
				else if(!currentElement.guestNameChanged)
					return true;
					
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
		
		private function showInvalidGuestInput():void{
			selectionForAllMC.close();
			invalidGuestInputMC.launch();
		}

		private function hideInvalidGuestInput():void{
			invalidGuestInputMC.close();
		}

		private function showSelectionForAllMessage():void{
			invalidGuestInputMC.close();
			selectionForAllMC.launch();
		}

		private function hideSelectionForAllMessage():void{
			selectionForAllMC.close();
		}*/
	}
}