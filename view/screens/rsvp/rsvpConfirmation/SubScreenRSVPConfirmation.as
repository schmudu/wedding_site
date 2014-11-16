package com.schmudu.wedding.view.screens.rsvp.rsvpConfirmation{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
   
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.iterators.ArrayIterator;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.lib.events.CustomEvent;
	import com.schmudu.lib.view01.AbstractComp;
	
	import com.schmudu.wedding.view.screens.MenuButton;
	import com.schmudu.wedding.view.screens.rsvp.login.MessageContactingServerMC;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.controller.RSVPController;
	import com.schmudu.wedding.model.RSVPManager;
	
	public class SubScreenRSVPConfirmation extends AbstractComp{
		//public var debugTextField						:TextField;
		
		public var rsvpFailedMC							:MessageRSVPFailedMC;
		public var contactingServerMC					:MessageContactingServerMC;
		public var rsvpConfirmedMC						:MessageRSVPConfirmedMC;
		public var menuButton							:ButtonMenuRSVPConfirmation;
		
		//DEBUG
		//public var menuDebugButton							:MenuButton;
		//private const INSTANCE_NAME_MENU_DEBUG_BUTTON				:String = "menuDebugButton";
		
		private const INSTANCE_NAME_MSG_RSVP_FAILED			:String = "rsvpFailedMC";
		private const INSTANCE_NAME_MSG_CONTACTING_SERVER	:String = "contactingServerMC";
		private const INSTANCE_NAME_MSG_RSVP_CONFIRMED		:String = "rsvpConfirmedMC";
		private const INSTANCE_NAME_MENU_BUTTON				:String = "menuButton";
		//private const INSTANCE_NAME_DEBUG_TEXTFIELD			:String = "debugTextField";
		
		private var _rsvpController						:RSVPController;
		private var _menuButtonPressed					:Boolean = false;
		private var _rsvpManager							:RSVPManager;
		
		public function SubScreenRSVPConfirmation(){
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			//focus manager
			_rsvpController = RSVPController.getInstance();
			_rsvpManager = RSVPManager.getInstance();
			
			//move to a faraway place
			this.x = AppConstants.HIDE_POSITION;
			
			contactingServerMC = this.getChildByName(INSTANCE_NAME_MSG_CONTACTING_SERVER) as MessageContactingServerMC;
			contactingServerMC.initWithIntro(true);	
			contactingServerMC.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			contactingServerMC.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(contactingServerMC);
			
			rsvpConfirmedMC = this.getChildByName(INSTANCE_NAME_MSG_RSVP_CONFIRMED) as MessageRSVPConfirmedMC;
			rsvpConfirmedMC.initWithIntro(true);
			
			rsvpFailedMC = this.getChildByName(INSTANCE_NAME_MSG_RSVP_FAILED) as MessageRSVPFailedMC;
			rsvpFailedMC.initWithIntro(true);
			
			
			menuButton = this.getChildByName(INSTANCE_NAME_MENU_BUTTON) as ButtonMenuRSVPConfirmation;
			menuButton.initWithIntro(true);
			menuButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			menuButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(menuButton);
				
			//listen
			menuButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMenuButtonPressed, false, 0, true);
		}

		private function onDebugMenuButtonPressed(evt:Event):void{
			onFinishedClosingIntro();
		}
		
		private function addRSVPManagerListeners():void{
			_rsvpManager.addEventListener(RSVPManager.EVENT_RSVP_SERVER_MESSAGE_RECEIVED, onServerConfirmedRSVP, false, 0, true);
		}
		
		private function removeRSVPManagerListeners():void{
			_rsvpManager.removeEventListener(RSVPManager.EVENT_RSVP_SERVER_MESSAGE_RECEIVED, onServerConfirmedRSVP);
		}
		
		
		override protected function onFinishedLaunchingElements():void{
			//add listener
			addRSVPManagerListeners();
			
			//make call to server
			_rsvpController.submitGuestDataToServer();
			
			//default event
			dispatchEvent(new Event(UIObjectEvent.FINISHED_LAUNCHING))
		}
		
		private function onServerConfirmedRSVP(evt:CustomEvent):void{
			//remove listener
			removeRSVPManagerListeners();

			//based on message received, show appropriate MC
			if(String(evt.customData) == AppConstants.MESSAGE_RSVP_FAILED)
				showFailedMessage();
			else
				showSuccessMessage();
				
			//enable button
			menuButton.enable();	
		}
		
		private function showSuccessMessage():void{
			//remove contacting server
			contactingServerMC.close();
			
			//launch message that rsvp was confirmed
			rsvpConfirmedMC.launch();
		}
		
		
		private function showFailedMessage():void{
			//remove contacting server
			contactingServerMC.close();
			
			//launch message that rsvp was confirmed
			rsvpFailedMC.launch();
		}
				
		override protected function onFinishedClosingIntro(evt:Event = null):void{
			//move to hide position
			this.x = AppConstants.HIDE_POSITION;
						
			super.onFinishedClosingIntro();
		}
		
		override public function launch():void{
			//reset variables
			_menuButtonPressed = false;
			rsvpConfirmedMC.close();
			rsvpFailedMC.close();
			
			//disable button
			menuButton.disable();
			
			this.x = 0;
			onFinishedLaunchingIntro();
			//super.launch();
		}
		
		override public function close():void{
			//close any messages
			rsvpConfirmedMC.close();
			contactingServerMC.close();
			rsvpFailedMC.close();
			
			//close and disable close button
			menuButton.disable();
			menuButton.close();
			
			//close sub components
			//closeSubComponentsSimultaneouslyWithCascade(true);
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			//launchSubComponentsSimultaneouslyWithCascade(true);
			contactingServerMC.launch();
			menuButton.launch();
			
			//finished launching elements
			onFinishedLaunchingElements();
		}
		
		protected function onMenuButtonPressed(evt:Event):void{
			_menuButtonPressed = true;

			//SHOULDN'T HAPPEN, THERE'S A BUG IN HERE.  SHOULD ONLY
			//HAVE TO CALL CLOSE
			this.close();
			
			onFinishedClosingIntro();
		}
	}
}