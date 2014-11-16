package com.schmudu.wedding.view.screens{
	import com.schmudu.wedding.view.screens.contentButton.*;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.lib.events.UIObjectEvent;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class ScreenRegistry extends AbstractScreen{
		public var buttonHoneyFund							:ButtonHoneyFund;
		public var buttonWilliamsSonoma						:ButtonWilliamsSonoma;
		public var buttonMacys								:ButtonMacys;
		public var buttonCrateAndBarrel					:ButtonCrateAndBarrel;
		
		private var INSTANCE_NAME_WILLIAMS_SONOMA		:String = "buttonWilliamsSonoma";
		private var INSTANCE_NAME_MACYS					:String = "buttonMacys";
		private var INSTANCE_NAME_CRATE_AND_BARREL		:String = "buttonCrateAndBarrel";
		private var INSTANCE_NAME_HONEY_FUND			:String = "buttonHoneyFund";
		
		public function ScreenRegistry(){
		}

		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			buttonCrateAndBarrel = this.getChildByName(INSTANCE_NAME_CRATE_AND_BARREL) as ButtonCrateAndBarrel;
			buttonCrateAndBarrel.initWithIntro(true);
			buttonCrateAndBarrel.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonCrateAndBarrel.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonCrateAndBarrel);
			
			buttonMacys = this.getChildByName(INSTANCE_NAME_MACYS) as ButtonMacys;
			buttonMacys.initWithIntro(true);
			buttonMacys.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonMacys.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonMacys);
			
			buttonWilliamsSonoma = this.getChildByName(INSTANCE_NAME_WILLIAMS_SONOMA) as ButtonWilliamsSonoma;
			buttonWilliamsSonoma.initWithIntro(true);
			buttonWilliamsSonoma.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonWilliamsSonoma.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonWilliamsSonoma);
			
			buttonHoneyFund = this.getChildByName(INSTANCE_NAME_HONEY_FUND) as ButtonHoneyFund;
			buttonHoneyFund.initWithIntro(true);
			buttonHoneyFund.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			buttonHoneyFund.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.SCREEN_CONTENT_BUTTON_LAUNCH_DELAY);
			_subComponents.push(buttonHoneyFund);
			
			_classType = "[object ScreenRegistry]";
			
			//listen
			buttonWilliamsSonoma.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedOnStoreButton, false, 0, true);
			buttonCrateAndBarrel.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedOnStoreButton, false, 0, true);
			buttonMacys.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedOnStoreButton, false, 0, true);
			buttonHoneyFund.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMouseReleasedOnStoreButton, false, 0, true);
		}
		
		override protected function launchElements():void{
			launchSubComponentsSimultaneouslyWithCascade(true);
		}
		
		private function onMouseReleasedOnStoreButton(evt:Event):void{
			var targetURL:String;
			var myURLRequest:URLRequest;
			
			//set target url
			switch(String(evt.target)){
				case ButtonMacys.classType:
					targetURL = "http://www.macys.com";
					break;
				case ButtonWilliamsSonoma.classType:
					targetURL = "http://www.williams-sonoma.com";
					break;
				case ButtonCrateAndBarrel.classType:
					targetURL = "http://www.crateandbarrel.com";
					break;
				case ButtonHoneyFund.classType:
					targetURL = "http://www.honeyfund.com";
					break;
			}
			
			//go to url
			myURLRequest = new URLRequest(targetURL);
			navigateToURL(myURLRequest, AppConstants.NAVIGATE_TO_URL_WINDOW);
			
		}
	}
}