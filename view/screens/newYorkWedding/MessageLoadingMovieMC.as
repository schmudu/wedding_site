package com.schmudu.wedding.view.screens.newYorkWedding{
	import flash.display.MovieClip;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.view01.AbstractComp;
	
	public class MessageLoadingMovieMC extends AbstractComp{		
		public function MessageLoadingMovieMC(){
		}
		
		override protected function showIntroMC():void{
			introMC.alpha = 1;
			introMC.gotoAndPlay(2);
		}

		override protected function closeIntroMC():void{
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
