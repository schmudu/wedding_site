package com.schmudu.wedding.view.navigationMenu.wordMenu{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.lib.view01.AbstractButton;
	import com.schmudu.wedding.constants.AppConstants;
	
	
	public class AbstractWordNavButton extends AbstractButton{
		
		public function AbstractWordNavButton(){
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			//link title mc
			_transitionType = "easeOutQuad";
			overTransitionTimeShow = AppConstants.NAV_BUTTON_OVER_TIME_SHOW;
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			//enable button
			this.enable();
			
			super.onFinishedLaunchingIntro();
		}
		
		override protected function showOverMC():void{
			overMC.alpha = 1;
			overMC.gotoAndStop(1);
			Tweener.removeTweens(overMC);
			Tweener.addTween(overMC, {_frame:AppConstants.NAV_WORD_MENU_OVER_FRAMES_BEGIN, time:AppConstants.NAV_WORD_MENU_OVER_TIME, transition:_transitionType, onComplete:onFinishedShowingOverMC});
		}
	
		override protected function hideOverMC():void{
			Tweener.removeTweens(overMC);
			Tweener.addTween(overMC, {_frame:AppConstants.NAV_WORD_MENU_OVER_FRAMES_END, time:AppConstants.NAV_WORD_MENU_OVER_TIME, transition:_transitionType, onComplete:onFinishedHidingOverMC});
		}
		
		override protected function onFinishedHidingOverMC(evt:Event=null):void{
			//hide over
			overMC.alpha = 0;
		}
	}
}