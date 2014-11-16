package com.schmudu.wedding.view.screens.rsvp.login{
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
	import com.schmudu.lib.events.CustomEvent;
	
	import com.schmudu.wedding.view.screens.MenuButton;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.controller.RSVPController;
	import com.schmudu.wedding.model.Model;
	import com.schmudu.wedding.model.RSVPManager;
	import com.schmudu.wedding.view.screens.LoginButton;
	
	public class SubScreenLogin extends AbstractComp{
		public var contactingServerMC					:MessageContactingServerMC;
		public var invalidInputMC						:MessageInputInvalidMC;
		public var nameNotFoundMC						:MessageNameNotFoundMC;
		public var questionsMC							:MessageQuestionsMC;
		public var loginButton							:LoginButton;
		public var menuButton							:MenuButton;
		public var firstNameBGMC						:LoginNameBGMC;
		public var lastNameBGMC							:LoginNameBGMC;
		public var textFieldFirstName					:TextField;
		public var textFieldLastName					:TextField;
		
		private const INSTANCE_NAME_MSG_QUESTIONS			:String = "questionsMC";
		private const INSTANCE_NAME_MSG_CONTACTING_SERVER	:String = "contactingServerMC";
		private const INSTANCE_NAME_MSG_INVALID_INPUT		:String = "invalidInputMC";
		private const INSTANCE_NAME_MSG_NAME_NOT_FOUND		:String = "nameNotFoundMC";
		private const INSTANCE_NAME_LOGIN_BUTTON			:String = "loginButton";
		private const INSTANCE_NAME_MENU_BUTTON				:String = "menuButton";
		private const INSTANCE_NAME_FIRST_NAME				:String = "firstNameBGMC";
		private const INSTANCE_NAME_LAST_NAME				:String = "lastNameBGMC";
		private const INSTANCE_NAME_FIRST_NAME_TEXTFIELD	:String = "textFieldFirstName";
		private const INSTANCE_NAME_LAST_NAME_TEXTFIELD		:String = "textFieldLastName";
		
		private var _rsvpController							:RSVPController;
		private var _model									:Model;
		private var _focusManager							:FocusManager;
		private var _menuButtonPressed						:Boolean = false;
		private var _textFieldFirstNameChanged				:Boolean = false;
		private var _textFieldLastNameChanged				:Boolean = false;
		private var _userAlreadyConfirmed					:Boolean = false;
		private var _rsvpManager							:RSVPManager;
		
		public function SubScreenLogin(){
		}
		
		public function get menuButtonPressed():Boolean{
			return _menuButtonPressed;
		}
			
		public function get userAlreadyConfirmed():Boolean{
			return _userAlreadyConfirmed;
		}		
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			//focus manager
			_focusManager = new FocusManager(this);
			_rsvpController = RSVPController.getInstance();
			_rsvpManager = RSVPManager.getInstance();
			
			//move to a faraway place
			this.x = AppConstants.HIDE_POSITION;
			
			contactingServerMC = this.getChildByName(INSTANCE_NAME_MSG_CONTACTING_SERVER) as MessageContactingServerMC;
			contactingServerMC.initWithIntro(true);
			
			invalidInputMC = this.getChildByName(INSTANCE_NAME_MSG_INVALID_INPUT) as MessageInputInvalidMC;
			invalidInputMC.initWithIntro(true);
			
			nameNotFoundMC = this.getChildByName(INSTANCE_NAME_MSG_NAME_NOT_FOUND) as MessageNameNotFoundMC;
			nameNotFoundMC.initWithIntro(true);
			
			textFieldFirstName = this.getChildByName(INSTANCE_NAME_FIRST_NAME_TEXTFIELD) as TextField;
			textFieldFirstName.text = "";
			textFieldFirstName.tabIndex = 1;
			
			textFieldLastName = this.getChildByName(INSTANCE_NAME_LAST_NAME_TEXTFIELD) as TextField;
			textFieldLastName.text = "";
			textFieldLastName.tabIndex = 2;
			
			firstNameBGMC = this.getChildByName(INSTANCE_NAME_FIRST_NAME) as LoginNameBGMC;
			firstNameBGMC.initWithIntro(true);
			firstNameBGMC.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			firstNameBGMC.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(firstNameBGMC);
			
			lastNameBGMC = this.getChildByName(INSTANCE_NAME_LAST_NAME) as LoginNameBGMC;
			lastNameBGMC.initWithIntro(true);
			lastNameBGMC.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			lastNameBGMC.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(lastNameBGMC);
			
			loginButton = this.getChildByName(INSTANCE_NAME_LOGIN_BUTTON) as LoginButton;
			loginButton.initWithIntro(true);
			loginButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			loginButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(loginButton);
			loginButton.tabIndex = 3;
			
			menuButton = this.getChildByName(INSTANCE_NAME_MENU_BUTTON) as MenuButton;
			menuButton.initWithIntro(true);
			menuButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			menuButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(menuButton);
			menuButton.tabIndex = 4;
				
			questionsMC = this.getChildByName(INSTANCE_NAME_MSG_QUESTIONS) as MessageQuestionsMC;
			questionsMC.initWithIntro(true);
			questionsMC.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			questionsMC.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(questionsMC);
			
			//listen
			textFieldLastName.addEventListener(FocusEvent.FOCUS_IN, onUserSelectedLastName, false, 0, true);
			textFieldFirstName.addEventListener(FocusEvent.FOCUS_IN, onUserSelectedFirstName, false, 0, true);
			textFieldLastName.addEventListener(Event.CHANGE, textFieldLastNameChange, false, 0, true);
			textFieldFirstName.addEventListener(Event.CHANGE, textFieldFirstNameChange, false, 0, true);
			menuButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMenuButtonPressed, false, 0, true);
			loginButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onSubmitButtonPressed, false, 0, true);
		}
		
		private function addRSVPManagerListeners():void{
			_rsvpManager.addEventListener(RSVPManager.EVENT_SERVER_CALL_USER_LOGIN, onServerCallUserLogin, false, 0, true);
			_rsvpManager.addEventListener(RSVPManager.EVENT_GUEST_LIST_RECEIVED, onGuestListReceived, false, 0, true);
			_rsvpManager.addEventListener(RSVPManager.EVENT_USER_NOT_FOUND, onUserNotFound, false, 0, true);
			_rsvpManager.addEventListener(RSVPManager.EVENT_RSVP_ALREADY_CONFIRMED, onGuestRSVPAlreadyConfirmed, false, 0, true);
		}
		
		private function removeRSVPManagerListeners():void{
			_rsvpManager.removeEventListener(RSVPManager.EVENT_SERVER_CALL_USER_LOGIN, onServerCallUserLogin);
			_rsvpManager.removeEventListener(RSVPManager.EVENT_GUEST_LIST_RECEIVED, onGuestListReceived);
			_rsvpManager.removeEventListener(RSVPManager.EVENT_USER_NOT_FOUND, onUserNotFound);
			_rsvpManager.removeEventListener(RSVPManager.EVENT_RSVP_ALREADY_CONFIRMED, onGuestRSVPAlreadyConfirmed);
		}
		
		override protected function onFinishedClosingIntro(evt:Event = null):void{
			//move to hide position
			this.x = AppConstants.HIDE_POSITION;
						
			super.onFinishedClosingIntro();
		}
		
		override public function launch():void{
			//reset button
			_menuButtonPressed = false;
			_textFieldFirstNameChanged = false;
			_textFieldLastNameChanged = false;
			_userAlreadyConfirmed = false;
			
			//disable login
			disableLogin();
			
			this.x = 0;
			onFinishedLaunchingIntro();
			//super.launch();
		}
		
		override public function close():void{
			//close any messages
			invalidInputMC.close();
			contactingServerMC.close();
			nameNotFoundMC.close();
			
			//close and disable close button
			menuButton.disable();
			menuButton.close();
			
			//hide text
			textFieldLastName.text = "";
			textFieldFirstName.text = "";
		
			//close sub components
			closeSubComponentsSimultaneouslyWithCascade(true);
		}
		
		override protected function onFinishedLaunchingElements():void{
			this.setDefaultTextInput();
			
			//enable login
			enableLogin();
			
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
		
		private function setDefaultTextInput():void{
			textFieldFirstName.text = "Enter first name";
			textFieldLastName.text = "Enter last name";
			
			//set selection
			_focusManager.setFocus(textFieldFirstName);
			textFieldFirstName.setSelection(0,textFieldFirstName.length);
		}
		
		private function onUserSelectedLastName(evt:Event):void{
			textFieldLastName.setSelection(0,textFieldLastName.length);
		}

		private function onUserSelectedFirstName(evt:Event):void{
			textFieldFirstName.setSelection(0,textFieldFirstName.length);
		}
		
		private function onSubmitButtonPressed(evt:Event):void{
			//validate input
			if(this.inputIsValid()){
				//add listeners
				this.addRSVPManagerListeners();
				
				//close any mc that may be open
				nameNotFoundMC.close();
				
				//send data to controller
				_rsvpController.loginUser(textFieldFirstName.text, textFieldLastName.text);
			}
			else{
				//show invalid mc
				invalidInputMC.launch();
			}
		}
		
		private function textFieldFirstNameChange(evt:Event):void{
			_textFieldFirstNameChanged = true;
			invalidInputMC.close();
			nameNotFoundMC.close();
		}

		private function textFieldLastNameChange(evt:Event):void{
			_textFieldLastNameChanged = true;
			invalidInputMC.close();
			nameNotFoundMC.close();
		}
		
		private function inputIsValid():Boolean{
			//don't allow guests to input 'guest'/'guest' as a login
			if((String(textFieldFirstName.text).toLowerCase() == "guest") || (String(textFieldLastName.text).toLowerCase() == "guest"))
				return false;
			else if((textFieldFirstName.length>0) && (textFieldLastName.length>0) && (_textFieldFirstNameChanged) && (_textFieldLastNameChanged))
				return true;
			else
				return false;
		}
		
		private function onServerCallUserLogin(evt:Event):void{
			//disable buttons
			disableLogin();
					
			//hide any messages, then show contacting server
			invalidInputMC.addEventListener(UIObjectEvent.FINISHED_CLOSING, onNameNotFoundFinishedClosingShowContactingServer, false, 0, true);
			invalidInputMC.close();
		}

		private function onNameNotFoundFinishedClosingShowContactingServer(evt:Event):void{
			//remove listener
			invalidInputMC.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onNameNotFoundFinishedClosingShowContactingServer);

			//show user not found
			contactingServerMC.launch();
		}
		
		private function onUserNotFound(evt:Event):void{
			//re-enable buttons
			enableLogin();
			
			//hide contacting server msg
			//after that show user not found
			contactingServerMC.addEventListener(UIObjectEvent.FINISHED_CLOSING, onContactingServerFinishedClosingShowUserNotFound, false, 0, true);
		
			contactingServerMC.close();
		}
		
		private function onContactingServerFinishedClosingShowUserNotFound(evt:Event):void{
			//remove listener
			contactingServerMC.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onContactingServerFinishedClosingShowUserNotFound);
		
			//show user not found
			nameNotFoundMC.launch();
		}
		
		private function onGuestListReceived(evt:Event):void{
			//remove rsvp listeners
			this.removeRSVPManagerListeners();
			
			//close everything
			this.close();
		}
			
		private function onGuestRSVPAlreadyConfirmed(evt:Event):void{
			//remove rsvp listeners
			this.removeRSVPManagerListeners();
			
			//set variable to let rsvp screen know
			_userAlreadyConfirmed = true;
			
			//close everything
			this.close();
		}
				
		private function enableLogin():void{
			textFieldFirstName.selectable = true;
			textFieldLastName.selectable = true;
			loginButton.enable();
		}

		private function disableLogin():void{
			textFieldFirstName.selectable = false;
			textFieldLastName.selectable = false;
			loginButton.disable();
		}
	}
}