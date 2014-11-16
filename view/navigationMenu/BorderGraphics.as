package com.schmudu.wedding.view.navigationMenu{
	import flash.events.Event;
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.view01.AbstractComp;
	import com.schmudu.wedding.constants.AppConstants;
	
	public class BorderGraphics extends AbstractComp{
	
		public var imageOne									:AbstractComp;
		public var imageTwo									:AbstractComp;
		public var imageThree								:AbstractComp;
		public var imageFour								:AbstractComp;
		public var imageFive								:AbstractComp;
		public var imageSix									:AbstractComp;
		public var imageSeven								:AbstractComp;
		public var imageEight								:AbstractComp;
		
		private const INSTANCE_NAME_ONE						:String = "imageOne";
		private const INSTANCE_NAME_TWO						:String = "imageTwo";
		private const INSTANCE_NAME_THREE					:String = "imageThree";
		private const INSTANCE_NAME_FOUR					:String = "imageFour";
		private const INSTANCE_NAME_FIVE					:String = "imageFive";
		private const INSTANCE_NAME_SIX						:String = "imageSix";
		private const INSTANCE_NAME_SEVEN					:String = "imageSeven";
		private const INSTANCE_NAME_EIGHT					:String = "imageEight";
		
		//private var _navigationController				:NavigationController;
		//private var _model									:Model;
		
		public function BorderGraphics(){
		}
		
		
		/*
		override protected function onFinishedClosingElements():void{
			closeIntroMC();
		}*/
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
						
			imageOne = this.getChildByName(INSTANCE_NAME_ONE) as AbstractComp;
			_subComponents.push(imageOne);
			imageOne.initWithIntro(true);
			imageOne.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			imageOne.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			imageTwo = this.getChildByName(INSTANCE_NAME_TWO) as AbstractComp;
			_subComponents.push(imageTwo);
			imageTwo.initWithIntro(true);
			imageTwo.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			imageTwo.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			imageThree = this.getChildByName(INSTANCE_NAME_THREE) as AbstractComp;
			_subComponents.push(imageThree);
			imageThree.initWithIntro(true);
			imageThree.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			imageThree.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			imageFour = this.getChildByName(INSTANCE_NAME_FOUR) as AbstractComp;
			_subComponents.push(imageFour);
			imageFour.initWithIntro(true);
			imageFour.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			imageFour.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			imageFive = this.getChildByName(INSTANCE_NAME_FIVE) as AbstractComp;
			_subComponents.push(imageFive);
			imageFive.initWithIntro(true);
			imageFive.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			imageFive.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			imageSix = this.getChildByName(INSTANCE_NAME_SIX) as AbstractComp;
			_subComponents.push(imageSix);
			imageSix.initWithIntro(true);
			imageSix.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			imageSix.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			imageSeven = this.getChildByName(INSTANCE_NAME_SEVEN) as AbstractComp;
			_subComponents.push(imageSeven);
			imageSeven.initWithIntro(true);
			imageSeven.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			imageSeven.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			imageEight = this.getChildByName(INSTANCE_NAME_EIGHT) as AbstractComp;
			_subComponents.push(imageEight);
			imageEight.initWithIntro(true);
			imageEight.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			imageEight.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			//launch any composition elements here,
			//can also call launchSubComponentsSimultaneouslyWithCascade, launchSubComponentsSequentially
			launchSubComponentsSimultaneouslyWithCascade(true);
		}
		
		override protected function closeElements():void{
			closeSubComponentsSimultaneouslyWithCascade(true);
		}
	}
}