package com.schmudu.wedding.view.screens.rsvp.confirmation{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.schmudu.lib.view01.AbstractComp;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.caurina.transitions.Tweener;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.model.RSVPManager;
	 
	public class ConfirmationAttendanceMC extends AbstractComp{
		public static var classType										:String = "[object ConfirmationAttendanceMC]";
		public static const EVENT_BUTTON_ATTENDING_PRESSED 		:String = "EVENT_BUTTON_ATTENDING_PRESSED";
		public static const EVENT_BUTTON_NOT_ATTENDING_PRESSED 	:String = "EVENT_BUTTON_NOT_ATTENDING_PRESSED";
		//MCs
		public var lineMC														:MovieClip;
		public var textAttending											:MovieClip;
		public var textNotAttending										:MovieClip;
		
		private const INSTANCE_NAME_LINE_MC								:String = "lineMC";
		private const INSTANCE_NAME_TEXT_ATTENDING					:String = "textAttending";
		private const INSTANCE_NAME_TEXT_NOT_ATTENDING				:String = "textNotAttending";
		
		private var _initAttending						:int;
		private var _rsvpManager						:RSVPManager;
		
		public function ConfirmationAttendanceMC(p_attending:int){
			_initAttending = p_attending;
		}

		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			_rsvpManager = RSVPManager.getInstance();
			
			lineMC = this.getChildByName(INSTANCE_NAME_LINE_MC) as MovieClip;
			lineMC.alpha = 0;
			
			textAttending = this.getChildByName(INSTANCE_NAME_TEXT_ATTENDING) as MovieClip;
			textAttending.alpha = 0;
			
			textNotAttending = this.getChildByName(INSTANCE_NAME_TEXT_NOT_ATTENDING) as MovieClip;
			textNotAttending.alpha = 0;
		}
		
		override protected function showIntroMC():void{
			if(lineMC!=null){
				Tweener.removeTweens(lineMC);
				Tweener.addTween(lineMC, {alpha:1, time:_introTransitionTimeShow, transition:_transitionType, onComplete:onFinishedLaunchingIntro});
				
				//show appropriate mc
				if(_initAttending)
					showAttendingText();
				else
					showNotAttendingText();
			}
			else
				onFinishedLaunchingIntro();
		}

		override protected function closeIntroMC():void{
			if(lineMC!=null){
				Tweener.removeTweens(lineMC);
				Tweener.addTween(lineMC, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType, onComplete:onFinishedClosingIntro});
			
				//show appropriate mc
				if(_initAttending)
					hideAttendingText();
				else
					hideNotAttendingText();
			}
			else
				onFinishedClosingIntro();
		}
		
		private function showAttendingText():void{
			Tweener.removeTweens(textAttending);
			Tweener.addTween(textAttending, {alpha:1, time:_introTransitionTimeShow, transition:_transitionType});
		}
		
		private function hideAttendingText():void{
			Tweener.removeTweens(textAttending);
			Tweener.addTween(textAttending, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType});
		}		
		
		private function showNotAttendingText():void{
			Tweener.removeTweens(textNotAttending);
			Tweener.addTween(textNotAttending, {alpha:1, time:_introTransitionTimeShow, transition:_transitionType});
		}
				
		private function hideNotAttendingText():void{
			Tweener.removeTweens(textNotAttending);
			Tweener.addTween(textNotAttending, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType});
		}
	}
}