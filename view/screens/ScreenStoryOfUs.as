package com.schmudu.wedding.view.screens{
	import com.schmudu.wedding.view.screens.contentButton.*;
	import com.schmudu.wedding.view.screens.newYorkWedding.*;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.caurina.transitions.Tweener;
	import flash.utils.Timer;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.URLRequest;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;
	import flash.display.MovieClip;


	public class ScreenStoryOfUs extends AbstractScreen{
		//debug
		//public var debugTextField							:TextField;
		//private const INSTANCE_NAME_DEBUG_TEXTFIELD			:String = "debugTextField";

		public var buttonLowBandwidth						:ButtonLowBandwidth;
		public var buttonHighBandwidth						:ButtonHighBandwidth;
		public var messageLoadingMovie						:MessageLoadingMovieMC;
		public var buttonPlayPause							:ButtonPlayPause;
		public var loadIndicator							:MovieClip;
		public var playIndicator							:MovieClip;

		private var _featureVideo							:Video = new Video();
		//private var _featureNC							:NetConnection = new NetConnection();
		private var _featureNS								:NetStream;
		private var _featureVideoAddedToStage				:Boolean = false;							

		private var INSTANCE_NAME_PLAY_INDICATOR			:String = "playIndicator";
		private var INSTANCE_NAME_LOAD_INDICATOR			:String = "loadIndicator";
		private var INSTANCE_NAME_BUTTON_PLAY_PAUSE			:String = "buttonPlayPause";
		private var INSTANCE_NAME_MESSAGE_LOADING_MOVIE		:String = "messageLoadingMovie";
		private var INSTANCE_NAME_BANDWIDTH_LOW				:String = "buttonLowBandwidth";
		private var INSTANCE_NAME_BANDWIDTH_HIGH			:String = "buttonHighBandwidth";

		private var _highBandwidthMCSelected				:Boolean = false;
		private var _updateMovieProgressTimer				:Timer = new Timer(AppConstants.MOVIE_PROGRESS_TIMER, 0);
		private var _mediaDuration							:Number;
		public function ScreenStoryOfUs(){
		}

		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			//_netStreamListener = NetStreamListener.getInstance();

			//DEBUG
			// = this.getChildByName(INSTANCE_NAME_DEBUG_TEXTFIELD) as TextField;

			loadIndicator = this.getChildByName(INSTANCE_NAME_LOAD_INDICATOR) as MovieClip;
			loadIndicator.alpha = 0;

			playIndicator = this.getChildByName(INSTANCE_NAME_PLAY_INDICATOR) as MovieClip;
			playIndicator.alpha = 0;


			buttonPlayPause = this.getChildByName(INSTANCE_NAME_BUTTON_PLAY_PAUSE) as ButtonPlayPause;
			buttonPlayPause.initWithIntro(true);

			messageLoadingMovie = this.getChildByName(INSTANCE_NAME_MESSAGE_LOADING_MOVIE) as MessageLoadingMovieMC;
			messageLoadingMovie.initWithIntro(true);

			buttonLowBandwidth = this.getChildByName(INSTANCE_NAME_BANDWIDTH_LOW) as ButtonLowBandwidth;
			buttonLowBandwidth.initWithIntro(true);
			buttonLowBandwidth.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonLowBandwidth.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonLowBandwidth);

			buttonHighBandwidth = this.getChildByName(INSTANCE_NAME_BANDWIDTH_HIGH) as ButtonHighBandwidth;
			buttonHighBandwidth.initWithIntro(true);
			buttonHighBandwidth.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonHighBandwidth.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonHighBandwidth);

			_classType = "[object ScreenStoryOfUs]";

			//listen
			buttonLowBandwidth.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedOnStoreButton, false, 0, true);
			buttonHighBandwidth.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedOnStoreButton, false, 0, true);
			buttonPlayPause.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasePlayPauseButton, false, 0, true);
		}

		override public function launch():void{
			loadIndicator.alpha = 0;
			playIndicator.alpha = 0;

			super.launch();
		}

		override protected function launchElements():void{
			launchSubComponentsSimultaneouslyWithCascade(true);
		}

		override protected function onFinishedShowingTextMC(evt:Event = null):void{
			//position button
			menuButton.x = AppConstants.MENU_BUTTON_ORIGINAL_POS_X;
			menuButton.y = AppConstants.MENU_BUTTON_ORIGINAL_POS_Y;

			//listen
			menuButton.addEventListener(UIObjectEvent.FINISHED_LAUNCHING, onFinishedLaunchingMenuButton, false, 0, true);
			menuButton.launch();
		}		

		override public function close():void{
			//problem if we take this out and use AbstractScreen method instead
			//if we click low or high bandwidth, the whole screen will close
			//hide any tweens

			//stop timer
			_updateMovieProgressTimer.addEventListener("timer", onUpdateMovieProgressTimerComplete, false, 0, true);
			_updateMovieProgressTimer.stop();

			//close stream, reset variables
			if(_featureNS!=null)
				_featureNS.close();

			//remove children
			if(_featureVideoAddedToStage){
				//remove from stage
				removeChild(_featureVideo);

				//clear any image
				_featureVideo.clear();
				_featureVideoAddedToStage = false;
			}

			//move menu button back
			menuButton.addEventListener(UIObjectEvent.FINISHED_CLOSING, onFinishedClosingMenuButtonForMoveToOriginalPosition, false, 0, true);
			menuButton.close();

			//close everything
			Tweener.removeTweens(loadIndicator);
			Tweener.addTween(loadIndicator, {alpha:0, scaleX:.01, time:_introTransitionTimeShow, transition:_transitionType});
			Tweener.removeTweens(playIndicator);
			Tweener.addTween(playIndicator, {alpha:0, scaleX:.01, time:_introTransitionTimeShow, transition:_transitionType});

			messageLoadingMovie.close();
			buttonLowBandwidth.close();
			buttonHighBandwidth.close();	
			this.hideIntroMCForPlayer();
			this.hideTextMCForPlayer();
			buttonPlayPause.close();

			closeElements();
		}

		private function onFinishedClosingMenuButtonForMoveToOriginalPosition(evt:Event):void{
			//remove listener
			menuButton.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onFinishedClosingMenuButtonForMoveToOriginalPosition);

			//move menu button to desired position
			menuButton.x = AppConstants.MENU_BUTTON_ORIGINAL_POS_X;
			menuButton.y = AppConstants.MENU_BUTTON_ORIGINAL_POS_Y;


		}

		private function onMouseReleasedOnStoreButton(evt:Event):void{
			//set movie to load
			switch(String(evt.target)){
				case ButtonLowBandwidth.classType:
					_highBandwidthMCSelected = false;
					break;
				case ButtonHighBandwidth.classType:
					_highBandwidthMCSelected = true;
					break;
			}

			//user selected movie, close unecessary screen components
			this.closeNonPlayerScreenElements();

		}

		private function closeNonPlayerScreenElements():void{
			buttonLowBandwidth.close();
			buttonHighBandwidth.close();
			this.hideIntroMCForPlayer();
			this.hideTextMCForPlayer();

			//move menu button to desired position
			menuButton.addEventListener(UIObjectEvent.FINISHED_CLOSING, onFinishedClosingMenuButtonForMoveToPlayerPosition, false, 0, true);
			menuButton.close();
		}

		private function hideIntroMCForPlayer():void{
			Tweener.removeTweens(introMC);
			Tweener.addTween(introMC, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType, onComplete:onFinishedHidingIntroForPlayer});
		}

		private function hideTextMCForPlayer():void{
			Tweener.removeTweens(textMC);
			Tweener.addTween(textMC, {_frame:1, time:_introTransitionTimeHide, transition:_transitionType});	
		}

		private function onFinishedHidingIntroForPlayer(evt:Event=null):void{
			//show loading movie
			messageLoadingMovie.launch();

			//load movie
			this.loadMovieClip();
		}

		private function onFinishedClosingMenuButtonForMoveToPlayerPosition(evt:Event=null):void{
			//remove listener
			menuButton.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onFinishedClosingMenuButtonForMoveToPlayerPosition);

			//move menu button to desired position
			menuButton.x = AppConstants.MENU_BUTTON_PLAYER_POSITION_X;
			menuButton.y = AppConstants.MENU_BUTTON_PLAYER_POSITION_Y;

			//launch menu button
			menuButton.launch();
		}

		private function onUpdateMovieProgressTimerComplete(evt:TimerEvent):void{
			if(_featureNS!=null){
				loadIndicator.scaleX = _featureNS.bytesLoaded/_featureNS.bytesTotal;
				playIndicator.scaleX = _featureNS.time/_mediaDuration;
			}

		}

		private function loadMovieClip(){
			var featureNC:NetConnection = new NetConnection();

			//start timer
			_updateMovieProgressTimer.addEventListener("timer", onUpdateMovieProgressTimerComplete, false, 0, true);
			_updateMovieProgressTimer.start();

			//add video to stage
			//addChild(_featureVideo);
			//_featureVideoAddedToStage = true;

			featureNC.connect(null);

			_featureNS = new NetStream(featureNC);
			_featureNS.bufferTime = AppConstants.NETSTREAM_BUFFER_TIME;
			_featureNS.client = {onMetaData:onMetaDataHandler};
			_featureNS.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onAsyncErrorHandler, false, 0, true);
			_featureNS.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusReceived, false, 0, true);

			//listen to the client
			//_netStreamListener.addEventListener(NetStreamListener.EVENT_MOVIE_LOADED, onMovieLoaded, false, 0, true);

			//set state of buttons
			//buttonPlayPause.inPlayMode = true;
			//buttonPlayPause.inRestartMode = false;

			//show load indicator
			Tweener.removeTweens(loadIndicator);
			Tweener.addTween(loadIndicator, {alpha:1, scaleX:.01, time:_introTransitionTimeShow, transition:_transitionType});
			
			//determine if we should load low or high version
			if(_highBandwidthMCSelected){				
				_featureNS.play("./movies/StoryOfUs_High.f4v");
			}
			else{
				_featureNS.play("./movies/StoryOfUs_Low.f4v");
			}

			//attach net stream
			_featureVideo.attachNetStream(_featureNS);


		}
		
		private function onAsyncErrorHandler(evt:Event):void{
			//do nothing
		}
		
		private function onMetaDataHandler(p_obj:Object):void{
			//add video to stage
			addChild(_featureVideo);
			_featureVideoAddedToStage = true;

			//set state of buttons
			buttonPlayPause.inPlayMode = true;

			//get duration
			_mediaDuration = p_obj.duration;

			//set width and height
			_featureVideo.width = p_obj.width;
			_featureVideo.height = p_obj.height;

			//set position
			_featureVideo.y = AppConstants.MOVIE_CONSTANT_HEIGHT - _featureVideo.height;
			_featureVideo.x = AppConstants.MOVIE_CONSTANT_WIDTH - (_featureVideo.width/2);

			//show load indicator
			//Tweener.removeTweens(loadIndicator);
			//Tweener.addTween(loadIndicator, {alpha:1, scaleX:.01, time:_introTransitionTimeShow, transition:_transitionType});
			
			//show play indicator
			Tweener.removeTweens(playIndicator);
			Tweener.addTween(playIndicator, {alpha:1, scaleX:.01, time:_introTransitionTimeShow, transition:_transitionType});

			//movie loaded so show play button and hide movie loading MC
			messageLoadingMovie.close();
			buttonPlayPause.launch();
		}

		private function onMouseReleasePlayPauseButton(evt:Event=null):void{
			//toggle play/plause button
			if(!buttonPlayPause.inRestartMode){
				if(buttonPlayPause.inPlayMode){
					//toggle
					buttonPlayPause.inPlayMode = false;

					//pause movie
					_featureNS.pause();
				}
				else{
					//toggle
					buttonPlayPause.inPlayMode = true;

					//play movie
					_featureNS.resume();
				}
			}
			else{
				//toggle
				buttonPlayPause.inRestartMode = false;
				buttonPlayPause.inPlayMode = true;

				//play movie
				_featureNS.seek(0);
				_featureNS.play();

			}
		}

		private function onNetStatusReceived(evt:NetStatusEvent):void{
			if(evt.info.code == "NetStream.Play.Stop"){
				buttonPlayPause.inRestartMode = true;
			}
		}
	}
}
