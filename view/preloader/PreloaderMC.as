package com.schmudu.wedding.view.preloader{
	import flash.display.MovieClip;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.view01.AbstractComp;
	
	public class PreloaderMC extends AbstractComp{		
		//public var preloadingIcon								:MovieClip;
		
		//private const INSTANCE_NAME_PRELOADING_ICON		:String = "preloadingIcon";
		
		public function PreloaderMC(){
		}
		
		override protected function showIntroMC():void{
			introMC.alpha = 1;
			introMC.gotoAndPlay(2);
		}

		override protected function closeIntroMC():void{
			//Tweener.removeTweens(preloadingIcon);
			//Tweener.addTween(preloadingIcon, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType});
			introMC.gotoAndStop(1);
			
			if(introMC!=null){
				
				Tweener.removeTweens(introMC);
				Tweener.addTween(introMC, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType, onComplete:onFinishedClosingIntro});
				
			}
			else
				onFinishedClosingIntro();
		}
	}
}
