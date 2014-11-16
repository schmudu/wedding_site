package com.schmudu.wedding.view.screens.contentButton{
	import com.schmudu.lib.view01.AbstractButton;
	import com.schmudu.wedding.constants.AppConstants;
	import com.caurina.transitions.Tweener;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.SimpleButton;
	
	
	
	public class AbstractContentButton extends AbstractButton{
		public var lineMC							:MovieClip;
		
		private var INSTANCE_NAME_LINE_MC	:String = "lineMC";
		
		public function AbstractContentButton(){
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
		
			overTransitionTimeShow =.2;
			overTransitionTimeShow =.2;
			
			lineMC = this.getChildByName(INSTANCE_NAME_LINE_MC) as MovieClip;
			lineMC.alpha = 0;
		} 
		
		override public function close():void{
			//hide line mc
			hideLineMC();
			
			super.close();
		}

		public function hideSelectedState():void{
			Tweener.removeTweens(overMC);
			Tweener.addTween(overMC, {alpha:0, _color:AppConstants.WEDDING_PARTY_OVER_COLOR, time:overTransitionTimeShow, transition:_transitionType});
		}
		
		public function showSelectedState():void{
			Tweener.removeTweens(overMC);
			Tweener.addTween(overMC, {alpha:1, _color:AppConstants.WEDDING_PARTY_SELECTED_COLOR, time:overTransitionTimeShow, transition:_transitionType});
		}
		
	 	override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			//show the line
			showLineMC();
			
			super.onFinishedLaunchingIntro();
		}
		
		protected function showLineMC():void{
			Tweener.removeTweens(lineMC);
			Tweener.addTween(lineMC, {alpha:.3, time:overTransitionTimeShow, transition:_transitionType, onComplete:onFinishedShowingOverMC});
		
		}
		
		protected function hideLineMC():void{
			Tweener.removeTweens(lineMC);
			Tweener.addTween(lineMC, {alpha:0, time:overTransitionTimeHide, transition:_transitionType, onComplete:onFinishedHidingOverMC});
		}
	}
}