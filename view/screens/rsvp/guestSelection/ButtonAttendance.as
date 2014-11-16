package com.schmudu.wedding.view.screens.rsvp.guestSelection{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.schmudu.wedding.view.screens.contentButton.AbstractContentButton;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.caurina.transitions.Tweener;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.model.RSVPManager;
	 
	public class ButtonAttendance extends AbstractContentButton{
		public static var classType = "[object ButtonAttendance]";
		public static const EVENT_BUTTON_ATTENDING_PRESSED 		:String = "EVENT_BUTTON_ATTENDING_PRESSED";
		public static const EVENT_BUTTON_NOT_ATTENDING_PRESSED 	:String = "EVENT_BUTTON_NOT_ATTENDING_PRESSED";
		//MCs
		public var textAttending						:MovieClip;
		public var textNotAttending					:MovieClip;
		public var buttonNotAttending					:ButtonNotAttending;
		public var buttonAttending						:ButtonAttending;
		public var dropDownBGMC							:MovieClip;
		
		private const INSTANCE_NAME_DROP_DOWN_MC				:String = "dropDownBGMC";
		private const INSTANCE_NAME_TEXT_ATTENDING			:String = "textAttending";
		private const INSTANCE_NAME_TEXT_NOT_ATTENDING		:String = "textNotAttending";
		private const INSTANCE_NAME_BUTTON_ATTENDING			:String = "buttonAttending";
		private const INSTANCE_NAME_BUTTON_NOT_ATTENDING	:String = "buttonNotAttending";
		
		private var _initAttending						:int;
		private var _initRSVP							:int;
		private var _rsvpManager						:RSVPManager;
		
		public function ButtonAttendance(p_rsvp:int, p_attending:int){
			_initAttending = p_attending;
			_initRSVP = p_rsvp;
		}
		
		override public function launch():void{
			//set open to true
			isOpenFlag = true;
			
			//based on the rsvp and attendance, show appropriate mc
			if(_initRSVP == 0)
				showIntroMC();
			else if (_initAttending == 0){
				showTextNotAttending();	
				super.onFinishedLaunchingIntro();
			}
			else{
				showTextAttending();	
				super.onFinishedLaunchingIntro();				
			}
		}

		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			_rsvpManager = RSVPManager.getInstance();
			
			dropDownBGMC = this.getChildByName(INSTANCE_NAME_DROP_DOWN_MC) as MovieClip;
			dropDownBGMC.alpha = 0;
			hideDropDownBG();
			
			textAttending = this.getChildByName(INSTANCE_NAME_TEXT_ATTENDING) as MovieClip;
			textAttending.alpha = 0;
			
			textNotAttending = this.getChildByName(INSTANCE_NAME_TEXT_NOT_ATTENDING) as MovieClip;
			textNotAttending.alpha = 0;
			
			buttonNotAttending = this.getChildByName(INSTANCE_NAME_BUTTON_NOT_ATTENDING) as ButtonNotAttending;
			buttonNotAttending.initWithIntro(true);
			buttonNotAttending.setDelayLaunchIndexAndInterval(1,AppConstants.BUTTON_NOT_ATTENDING_DELAY);
			
			buttonAttending = this.getChildByName(INSTANCE_NAME_BUTTON_ATTENDING) as ButtonAttending;
			buttonAttending.initWithIntro(true);
			
			//listen
			buttonAttending.addEventListener(UIObjectEvent.MOUSE_RELEASED, onButtonAttendingPressed, false, 0, true);
			buttonNotAttending.addEventListener(UIObjectEvent.MOUSE_RELEASED, onButtonNotAttendingPressed, false, 0, true);
		}
		
		override protected function onMouseUpHandler(evt:Event=null):void{
			if(!_rsvpManager.oneButtonAttendanceCurrentlyOpen){
				//launch the buttons
				showDropDownBG();
				buttonAttending.launch();
				buttonNotAttending.launchWithDelay();
		
				dispatchEvent(new Event(UIObjectEvent.MOUSE_RELEASED));
			}
		}
		
		private function onButtonAttendingPressed(evt:Event = null):void{
			this.closeMenuButtons();
			
			showTextAttending();
			
			dispatchEvent(new Event(EVENT_BUTTON_ATTENDING_PRESSED));
		}

		private function onButtonNotAttendingPressed(evt:Event = null):void{
			this.closeMenuButtons();
			
			showTextNotAttending();
			
			dispatchEvent(new Event(EVENT_BUTTON_NOT_ATTENDING_PRESSED));
		}
		
		private function closeMenuButtons():void{
			buttonAttending.close();
			buttonNotAttending.close();
			hideDropDownBG();
		}
		
		private function showDropDownBG():void{
			dropDownBGMC.x = 0;
			dropDownBGMC.alpha = 1;
		}

		private function hideDropDownBG():void{
			dropDownBGMC.alpha=0;
			dropDownBGMC.x = AppConstants.HIDE_POSITION;
		}
		
		private function showTextNotAttending():void{
			//show appropriate text
			introMC.alpha = 0;
			textAttending.alpha = 0;
				
			Tweener.removeTweens(textNotAttending);
			Tweener.addTween(textNotAttending, {alpha:1, time:_introTransitionTimeShow, transition:_transitionType});
		}
		
		
		private function showTextAttending():void{
			//show appropriate text
			introMC.alpha = 0;
			textNotAttending.alpha = 0;
				
			Tweener.removeTweens(textAttending);
			Tweener.addTween(textAttending, {alpha:1, time:_introTransitionTimeShow, transition:_transitionType});
		}
	}
}