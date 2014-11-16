package com.schmudu.wedding.view.screens{
	import com.schmudu.wedding.view.screens.weddingParty.TextManager;
	import com.schmudu.wedding.view.screens.weddingParty.ImageManager;
	import com.schmudu.wedding.view.screens.contentButton.*;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.caurina.transitions.Tweener;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class ScreenWeddingParty extends AbstractScreen{
		public var textManager							:TextManager;
		public var imageManager							:ImageManager;
		public var buttonKeri							:ButtonBridesmaidKeri;
		public var buttonStacey							:ButtonBridesmaidStacey;
		public var buttonNgoce							:ButtonBridesmaidNgoce;
		public var buttonDina							:ButtonBridesmaidDina;
		public var buttonJun							:ButtonBridesmaidJun;
		public var buttonKari							:ButtonBridesmaidKari;
		
		public var buttonPatrick						:ButtonGroomsmenPatrick;
		public var buttonMichael						:ButtonGroomsmenMichael;
		public var buttonDustin							:ButtonGroomsmenDustin;
		public var buttonRyan							:ButtonGroomsmenRyan;
		public var buttonDarren							:ButtonGroomsmenDarren;
		
		private var _currentSelectedButton				:AbstractContentButton;
		private var _introMCClosed						:Boolean;
		
		private var INSTANCE_NAME_IMAGE_MANAGER			:String = "imageManager";
		private var INSTANCE_NAME_TEXT_MANAGER			:String = "textManager";
		private var INSTANCE_NAME_BRIDESMAID_NGOCE		:String = "buttonNgoce";
		private var INSTANCE_NAME_BRIDESMAID_DINA		:String = "buttonDina";
		private var INSTANCE_NAME_BRIDESMAID_STACEY		:String = "buttonStacey";
		private var INSTANCE_NAME_BRIDESMAID_KERI		:String = "buttonKeri";
		private var INSTANCE_NAME_BRIDESMAID_JUN		:String = "buttonJun";
		private var INSTANCE_NAME_BRIDESMAID_KARI		:String = "buttonKari";
		private var INSTANCE_NAME_GROOMSMEN_PATRICK		:String = "buttonPatrick";
		private var INSTANCE_NAME_GROOMSMEN_MICHAEL		:String = "buttonMichael";
		private var INSTANCE_NAME_GROOMSMEN_DUSTIN		:String = "buttonDustin";
		private var INSTANCE_NAME_GROOMSMEN_RYAN		:String = "buttonRyan";
		private var INSTANCE_NAME_GROOMSMEN_DARREN		:String = "buttonDarren";
		
		public function ScreenWeddingParty(){
		}

		override public function close():void{
			//close any content
			textManager.close();
			imageManager.close();
			super.close();
			
			//reset variables
			_introMCClosed = false;
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			textManager = this.getChildByName(INSTANCE_NAME_TEXT_MANAGER) as TextManager;
			textManager.initWithIntro(false);

			imageManager = this.getChildByName(INSTANCE_NAME_IMAGE_MANAGER) as ImageManager;
			imageManager.initWithIntro(false);

			buttonKeri = this.getChildByName(INSTANCE_NAME_BRIDESMAID_KERI) as ButtonBridesmaidKeri;
			buttonKeri.initWithIntro(true);
			buttonKeri.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonKeri.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonKeri);
						
			buttonStacey = this.getChildByName(INSTANCE_NAME_BRIDESMAID_STACEY) as ButtonBridesmaidStacey;
			buttonStacey.initWithIntro(true);
			buttonStacey.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonStacey.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonStacey);
			
			buttonNgoce = this.getChildByName(INSTANCE_NAME_BRIDESMAID_NGOCE) as ButtonBridesmaidNgoce;
			buttonNgoce.initWithIntro(true);
			buttonNgoce.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonNgoce.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonNgoce);
			
			buttonDina = this.getChildByName(INSTANCE_NAME_BRIDESMAID_DINA) as ButtonBridesmaidDina;
			buttonDina.initWithIntro(true);
			buttonDina.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonDina.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonDina);
			
			buttonKari = this.getChildByName(INSTANCE_NAME_BRIDESMAID_KARI) as ButtonBridesmaidKari;
			buttonKari.initWithIntro(true);
			buttonKari.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonKari.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonKari);
			
			buttonJun = this.getChildByName(INSTANCE_NAME_BRIDESMAID_JUN) as ButtonBridesmaidJun;
			buttonJun.initWithIntro(true);
			buttonJun.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonJun.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonJun);
			
			
			
			buttonPatrick = this.getChildByName(INSTANCE_NAME_GROOMSMEN_PATRICK) as ButtonGroomsmenPatrick;
			buttonPatrick.initWithIntro(true);
			buttonPatrick.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonPatrick.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonPatrick);
			
			buttonMichael = this.getChildByName(INSTANCE_NAME_GROOMSMEN_MICHAEL) as ButtonGroomsmenMichael;
			buttonMichael.initWithIntro(true);
			buttonMichael.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonMichael.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonMichael);
			
			buttonDustin = this.getChildByName(INSTANCE_NAME_GROOMSMEN_DUSTIN) as ButtonGroomsmenDustin;
			buttonDustin.initWithIntro(true);
			buttonDustin.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonDustin.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonDustin);
			
			buttonRyan = this.getChildByName(INSTANCE_NAME_GROOMSMEN_RYAN) as ButtonGroomsmenRyan;
			buttonRyan.initWithIntro(true);
			buttonRyan.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonRyan.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonRyan);
			
			buttonDarren = this.getChildByName(INSTANCE_NAME_GROOMSMEN_DARREN) as ButtonGroomsmenDarren;
			buttonDarren.initWithIntro(true);
			buttonDarren.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonDarren.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonDarren);
			
			_classType = "[object ScreenWeddingParty]";
			
			//listen
			buttonKeri.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonStacey.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonNgoce.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonDina.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonJun.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonKari.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonPatrick.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonMichael.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonDustin.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonRyan.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			buttonDarren.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedButton, false, 0, true);
			
		}
		
		override protected function launchElements():void{
			launchSubComponentsSimultaneouslyWithCascade(true);
		}
		
		private function onMouseReleasedButton(evt:Event):void{
			if(!_introMCClosed){
				//close introMC
				Tweener.removeTweens(introMC);
				Tweener.addTween(introMC, {alpha:0, time:_introTransitionTimeShow, transition:_transitionType});
				
				//only close the intro once
				_introMCClosed = true;
			}
			//this method selects the button that the user just pressed
			//and deselects any previous button
			var newSelectedButton:AbstractContentButton = AbstractContentButton(evt.target);

			//tell old button to be re-enable
			if(_currentSelectedButton != null){
				_currentSelectedButton.enable();
				_currentSelectedButton.hideSelectedState();
			}
			
			//tell new button to disable and show selected state
			newSelectedButton.disable();
			newSelectedButton.showSelectedState();
			
			//set the new button as the current button
			_currentSelectedButton = newSelectedButton;
			
			//tell text manager to show text according to button pressed
			textManager.onButtonPressed(String(_currentSelectedButton));
			
			//tell picture manager to show image according to button pressed
			imageManager.onButtonPressed(String(_currentSelectedButton));
			
			
		}
	}
}