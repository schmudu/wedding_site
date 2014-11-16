package com.schmudu.wedding.view.screens.newYorkWedding{
	import flash.events.Event;
	import flash.display.MovieClip
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.view01.AbstractButton;
	
	public class ButtonPlayPause extends AbstractButton{
		public var introMCPause					:MovieClip;
		public var introMCPlay					:MovieClip;
		public var introMCRestart				:MovieClip;
		
		private const INSTANCE_NAME_RESTART		:String = "introMCRestart";
		private const INSTANCE_NAME_PAUSE		:String = "introMCPause";
		private const INSTANCE_NAME_PLAY		:String = "introMCPlay";
		private const EVENT_PLAY_MODE_CHANGED	:String = "EVENT_PLAY_MODE_CHANGED";
		private const EVENT_RESTART_MODE_CHANGED	:String = "EVENT_RESTART_MODE_CHANGED";
		
		private var _inPlayMode					:Boolean = true;
		private var _inRestartMode				:Boolean = false;
		private var _currentlyDisplayedSymbol	:MovieClip;
		
		public function ButtonPlayPause(){
		}

		public function set inPlayMode(b:Boolean):void{
			_inPlayMode = b;
			
			dispatchEvent(new Event(EVENT_PLAY_MODE_CHANGED));
		}

		public function get inPlayMode():Boolean{
			return _inPlayMode;
		}

		public function set inRestartMode(b:Boolean):void{
			_inRestartMode = b;

			dispatchEvent(new Event(EVENT_RESTART_MODE_CHANGED));
		}

		public function get inRestartMode():Boolean{
			return _inRestartMode;
		}

		override public function close():void{
			//hide any symbols
			this.hidePlaySymbol();
			this.hidePauseSymbol();
			this.hideRestartSymbol();
			
			super.close();
		}	
			
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			//link vars
			introMCRestart = this.getChildByName(INSTANCE_NAME_RESTART) as MovieClip;
			introMCRestart.alpha = 0;
			
			introMCPause = this.getChildByName(INSTANCE_NAME_PAUSE) as MovieClip;
			introMCPause.alpha = 0;
			
			introMCPlay = this.getChildByName(INSTANCE_NAME_PLAY) as MovieClip;
			introMCPlay.alpha = 0;
			
			//start out in play mode
			_inPlayMode = true;
						
			//set which symbol to gray out when disabled
			_currentlyDisplayedSymbol = introMCPause;
			
			//listen
			this.addEventListener(EVENT_PLAY_MODE_CHANGED, onPlayModeChanged, false, 0, true);
			this.addEventListener(EVENT_RESTART_MODE_CHANGED, onRestartModeChanged, false, 0, true);
			
		}		
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			//enable button
			enable();

			//decide which symbol to launch
			if(_inPlayMode)
				showPauseSymbol();
			else
				showPlaySymbol();
				
			//launch any composition elements here,
			//can also call launchSubComponentsSmultaneously, launchSubComponentsSequentially, or launchSubComponentsCascade
			super.onFinishedLaunchingIntro();
		}

		private function showRestartSymbol():void{
			Tweener.removeTweens(introMCRestart);
			Tweener.addTween(introMCRestart, {alpha:1, time:_introTransitionTimeShow, transition:_transitionType});
		}

		private function hideRestartSymbol():void{
			Tweener.removeTweens(introMCRestart);
			Tweener.addTween(introMCRestart, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType});
		}
		
		private function showPlaySymbol():void{
			Tweener.removeTweens(introMCPlay);
			Tweener.addTween(introMCPlay, {alpha:1, time:_introTransitionTimeShow, transition:_transitionType});
		}

		private function hidePlaySymbol():void{
			Tweener.removeTweens(introMCPlay);
			Tweener.addTween(introMCPlay, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType});
		}
		
		private function showPauseSymbol():void{
			Tweener.removeTweens(introMCPause);
			Tweener.addTween(introMCPause, {alpha:1, time:_introTransitionTimeShow, transition:_transitionType});
		}

		private function hidePauseSymbol():void{
			Tweener.removeTweens(introMCPause);
			Tweener.addTween(introMCPause, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType});
		}
		
		private function onPlayModeChanged(evt:Event):void{
			//play mode changed, fade out old and show new
			if(!_inPlayMode){
				hidePauseSymbol();
				showPlaySymbol();
			}
			else{
				hidePlaySymbol();
				showPauseSymbol();
			}
		}

		private function onRestartModeChanged(evt:Event):void{
			//play mode changed, fade out old and show new
			if(_inRestartMode){
				showRestartSymbol();
				hidePlaySymbol();
				hidePauseSymbol();
			}
			else{
				//as soon as we restart we are going to play the movie
				hideRestartSymbol();
				showPlaySymbol();
			}
		}
		
	}
}