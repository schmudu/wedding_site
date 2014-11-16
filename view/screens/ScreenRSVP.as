package com.schmudu.wedding.view.screens{
	import com.schmudu.lib.view01.AbstractComp;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.caurina.transitions.Tweener;
	
	import flash.text.TextField;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	import com.schmudu.wedding.view.screens.rsvp.login.SubScreenLogin;
	import com.schmudu.wedding.view.screens.rsvp.guestSelection.SubScreenGuestSelection;
	import com.schmudu.wedding.view.screens.rsvp.confirmation.SubScreenGuestConfirmation;
	import com.schmudu.wedding.view.screens.rsvp.rsvpConfirmation.SubScreenRSVPConfirmation;
	import com.schmudu.wedding.view.screens.rsvp.guestAlreadyConfirmed.SubScreenGuestAlreadyConfirmed;
	import com.schmudu.wedding.constants.AppConstants;
	
	//DEBUG
	//import com.schmudu.wedding.view.screens.MenuButton;
	
	public class ScreenRSVP extends AbstractComp{
		public var textMC									:MovieClip;
		public var screenLogin							:SubScreenLogin;
		public var screenGuestSelection				:SubScreenGuestSelection;
		public var screenGuestConfirmation			:SubScreenGuestConfirmation;
		public var screenRSVPConfirmation			:SubScreenRSVPConfirmation;
		public var screenGuestAlreadyConfirmed		:SubScreenGuestAlreadyConfirmed;
		public var debugTextField						:TextField;
		
		//DEBUG
		//public var menuButton							:MenuButton;
		//private const INSTANCE_NAME_MENU_BUTTON				:String = "menuButton";
		
		private const INSTANCE_NAME_SCREEN_GUEST_ALREADY_CONFIRMED	:String = "screenGuestAlreadyConfirmed";
		private const INSTANCE_NAME_SCREEN_RSVP_CONFIRMATION	:String = "screenRSVPConfirmation";
		private const INSTANCE_NAME_SCREEN_GUEST_CONFIRMATION	:String = "screenGuestConfirmation";
		private const INSTANCE_NAME_SCREEN_GUEST_SELECTION		:String = "screenGuestSelection";
		private const INSTANCE_NAME_SCREEN_LOGIN					:String = "screenLogin";
		private const INSTANCE_NAME_TEXT_MC							:String = "textMC";
		//private const INSTANCE_NAME_DEBUG_TEXTFIELD				:String = "debugTextField";
	
		public function ScreenRSVP(){
		}

		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			//move to a faraway place
			this.x = AppConstants.HIDE_POSITION;
			
			//DEBUG
			/*
			menuButton = this.getChildByName(INSTANCE_NAME_MENU_BUTTON) as MenuButton;
			menuButton.initWithIntro(true);
			menuButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			menuButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			debugTextField = this.getChildByName(INSTANCE_NAME_DEBUG_TEXTFIELD) as TextField;
			*/
			textMC = this.getChildByName(INSTANCE_NAME_TEXT_MC) as MovieClip;
			textMC.alpha = 0;
			
			screenLogin = this.getChildByName(INSTANCE_NAME_SCREEN_LOGIN) as SubScreenLogin;
			screenLogin.initWithIntro(false);
			
			screenRSVPConfirmation = this.getChildByName(INSTANCE_NAME_SCREEN_RSVP_CONFIRMATION) as SubScreenRSVPConfirmation;
			screenRSVPConfirmation.initWithIntro(false);
			
			screenGuestSelection = this.getChildByName(INSTANCE_NAME_SCREEN_GUEST_SELECTION) as SubScreenGuestSelection;
			screenGuestSelection.initWithIntro(false);
			
			screenGuestAlreadyConfirmed = this.getChildByName(INSTANCE_NAME_SCREEN_GUEST_ALREADY_CONFIRMED) as SubScreenGuestAlreadyConfirmed;
			screenGuestAlreadyConfirmed.initWithIntro(false);
			
			screenGuestConfirmation = this.getChildByName(INSTANCE_NAME_SCREEN_GUEST_CONFIRMATION) as SubScreenGuestConfirmation;
			screenGuestConfirmation.initWithIntro(false);
			
			_classType = "[object ScreenRSVP]";
			
			//listen
			//screenLogin.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenLoginFinishedClosing, false, 0, true);
			//screenGuestSelection.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenGuestSelectionFinishedClosing, false, 0, true);
		}
		
		override public function launch():void{
			this.x = 0;
			
			screenLogin.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenLoginFinishedClosing, false, 0, true);
			
			super.launch();
		}

		override protected function onFinishedClosingIntro(evt:Event = null):void{
			//move to hide position
			this.x = AppConstants.HIDE_POSITION;

			super.onFinishedClosingIntro();
		}

		override public function close():void{
			Tweener.removeTweens(textMC);
			//Tweener.addTween(textMC, {_frame:1, time:_introTransitionTimeHide, transition:_transitionType, onComplete:onFinishedHidingTextMC});
			Tweener.addTween(textMC, {_frame:1, time:_introTransitionTimeHide, transition:_transitionType});

			//close sub components
			closeSubComponentsSimultaneouslyWithCascade(true);
		}

		protected function onFinishedHidingTextMC(evt:Event = null):void{
			//continue close process
			closeElements();
		}

		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			textMC.alpha = 1;
			Tweener.removeTweens(textMC);
			Tweener.addTween(textMC, {_frame:10, time:_introTransitionTimeShow, transition:_transitionType, onComplete:onFinishedShowingTextMC});
		}

		protected function onFinishedShowingTextMC(evt:Event = null):void{
			//launch the rest of the components
			this.launchSubComponentsSimultaneouslyWithCascade(true);
		}
		
		override protected function onFinishedLaunchingElements():void{
			screenLogin.launch();
			
			dispatchEvent(new Event(UIObjectEvent.FINISHED_LAUNCHING))
		}
		
		private function onScreenLoginFinishedClosing(evt:Event):void{
			
			screenLogin.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenLoginFinishedClosing);
			
			//determine whether or not the user pressed the back button
			//if so then close this
			if(screenLogin.menuButtonPressed){
				//close this
				this.close();
			}
			else if(screenLogin.userAlreadyConfirmed){
				//listen
				screenGuestAlreadyConfirmed.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenGuestAlreadyConfirmedFinishedClosing, false, 0, true);
				
				//need to go to next screen
				screenGuestAlreadyConfirmed.launch();
			}
			else{
				//listen
				screenGuestSelection.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenGuestSelectionFinishedClosing, false, 0, true);
				
				//need to go to next screen
				screenGuestSelection.launch();
			}
		}
		
		private function onScreenGuestAlreadyConfirmedFinishedClosing(evt:Event):void{
			//remove listener
			screenGuestAlreadyConfirmed.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenGuestAlreadyConfirmedFinishedClosing);
			
			//finished with RSVP screens
			this.close();
		}

		private function onScreenGuestSelectionFinishedClosing(evt:Event):void{
			//remove listener
			screenGuestSelection.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenGuestSelectionFinishedClosing);
			
			//determine whether or not the user pressed the back button
			//if so then close this
			if(screenGuestSelection.menuButtonPressed){
				//close this
				this.close();
			}
			else{
				//listen
				screenGuestConfirmation.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenGuestConfirmationFinishedClosing, false, 0, true);
				
				//need to go to next screen
				screenGuestConfirmation.launch();
			}
		}
		

		private function onScreenGuestConfirmationFinishedClosing(evt:Event):void{
			//remove listener
			screenGuestConfirmation.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenGuestConfirmationFinishedClosing);
			
			//determine whether or not the user pressed the back button
			//if so then close this
			if(screenGuestConfirmation.menuButtonPressed){
				//close this
				this.close();
			}
			else if(screenGuestConfirmation.backButtonPressed){
				//listen
				screenGuestSelection.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenGuestSelectionFinishedClosing, false, 0, true);
				
				screenGuestSelection.launch();
			}
			else{
				//listen
				screenRSVPConfirmation.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenRSVPConfirmationFinishedClosing, false, 0, true);
				
				//go back to guest confirmation
				//need to go to next screen
				screenRSVPConfirmation.launch();
			}
		}	
		
		private function onScreenRSVPConfirmationFinishedClosing(evt:Event):void{
			//remove listener
			screenRSVPConfirmation.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenRSVPConfirmationFinishedClosing);
			
			//finished with RSVP screens
			this.close();
		}	
	}
}