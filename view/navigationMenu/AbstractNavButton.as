package com.schmudu.wedding.view.navigationMenu{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.lib.view01.AbstractButton;
	import com.schmudu.wedding.constants.AppConstants;
	
	
	public class AbstractNavButton extends AbstractButton{
		public var titleMC								:MovieClip;
		public var tintMC									:MovieClip;
		
		private const INSTANCE_NAME_TITLE_MC		:String = "titleMC";
		private const INSTANCE_NAME_TINT_MC			:String = "tintMC";
	
		public function AbstractNavButton(){
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			//link title mc
			titleMC = this.getChildByName(INSTANCE_NAME_TITLE_MC) as MovieClip;
			tintMC = this.getChildByName(INSTANCE_NAME_TINT_MC) as MovieClip;
			
			overTransitionTimeShow = AppConstants.NAV_BUTTON_OVER_TIME_SHOW;
			
			//init over mc
			overMC.scaleX = AppConstants.NAV_BUTTON_FRAME_SCALE_OVER;
			overMC.scaleY = AppConstants.NAV_BUTTON_FRAME_SCALE_OVER;
			
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			//enable button
			this.enable();
			
			super.onFinishedLaunchingIntro();
		}
		
		override protected function showOverMC():void{
			Tweener.removeTweens(overMC);
			Tweener.addTween(overMC, {scaleX:1, scaleY:1, alpha:AppConstants.NAV_BUTTON_OVER_FRAME_ALPHA, time:overTransitionTimeShow, transition:_transitionType, onComplete:onFinishedShowingOverMC});
			Tweener.removeTweens(titleMC);
			Tweener.addTween(titleMC, {alpha:1, time:overTransitionTimeShow, transition:_transitionType});
			Tweener.removeTweens(tintMC);
			Tweener.addTween(tintMC, {alpha:AppConstants.NAV_BUTTON_TINT_MC_ALPHA_OVER, time:overTransitionTimeShow, transition:_transitionType});
		}
	
		override protected function hideOverMC():void{
			Tweener.removeTweens(overMC);
			Tweener.addTween(overMC, {scaleX:AppConstants.NAV_BUTTON_FRAME_SCALE_OVER, scaleY:AppConstants.NAV_BUTTON_FRAME_SCALE_OVER, alpha:0, time:overTransitionTimeHide, transition:_transitionType, onComplete:onFinishedHidingOverMC});
			Tweener.removeTweens(titleMC);
			Tweener.addTween(titleMC, {alpha:0, time:overTransitionTimeHide, transition:_transitionType});
			Tweener.removeTweens(tintMC);
			Tweener.addTween(tintMC, {alpha:0, time:overTransitionTimeHide, transition:_transitionType});
		}
	}
}