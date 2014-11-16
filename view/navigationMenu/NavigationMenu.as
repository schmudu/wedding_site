package com.schmudu.wedding.view.navigationMenu{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.iterators.ArrayIterator;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.lib.view01.AbstractComp;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.controller.NavigationController;
	import com.schmudu.wedding.model.Model;
	import com.schmudu.wedding.view.navigationMenu.wordMenu.WordMenu;
	
	public class NavigationMenu extends AbstractComp{
	
		public var wordMenu									:WordMenu;
		public var rsvpButton								:NavButtonRSVP;
		public var newYorkWeddingButton					:NavButtonNewYorkWedding;
		public var thingsToDoButton						:NavButtonThingsToDo;
		public var weddingPartyButton						:NavButtonWeddingParty;
		public var registryButton							:NavButtonRegistry;
		public var storyOfUsButton							:NavButtonStoryOfUs;
		public var venueButton								:NavButtonVenue;
		public var borderGraphics							:BorderGraphics;
		
		private const INSTANCE_NAME_BORDER_GRAPHICS			:String = "borderGraphics";
		private const INSTANCE_NAME_WORD_MENU					:String = "wordMenu";
		private const INSTANCE_NAME_BUTTON_RSVP				:String = "rsvpButton";
		private const INSTANCE_NAME_BUTTON_NEW_YORK			:String = "newYorkWeddingButton";
		private const INSTANCE_NAME_BUTTON_THINGS_TO_DO		:String = "thingsToDoButton";
		private const INSTANCE_NAME_BUTTON_WEDDING_PARTY	:String = "weddingPartyButton";
		private const INSTANCE_NAME_BUTTON_REGISTRY			:String = "registryButton";
		private const INSTANCE_NAME_BUTTON_STORY				:String = "storyOfUsButton";
		private const INSTANCE_NAME_BUTTON_VENUE				:String = "venueButton";
		
		private var _navigationController				:NavigationController;
		private var _model									:Model;
		
		public function NavigationMenu(){
		}
		
		
		
		override protected function onFinishedClosingElements():void{
			closeIntroMC();
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			rsvpButton = this.getChildByName(INSTANCE_NAME_BUTTON_RSVP) as NavButtonRSVP;
			_subComponents.push(rsvpButton);
			rsvpButton.initWithIntro(true);
			rsvpButton.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			rsvpButton.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			newYorkWeddingButton = this.getChildByName(INSTANCE_NAME_BUTTON_NEW_YORK) as NavButtonNewYorkWedding;
			_subComponents.push(newYorkWeddingButton);
			newYorkWeddingButton.initWithIntro(true);
			newYorkWeddingButton.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			newYorkWeddingButton.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			thingsToDoButton = this.getChildByName(INSTANCE_NAME_BUTTON_THINGS_TO_DO) as NavButtonThingsToDo;
			_subComponents.push(thingsToDoButton);
			thingsToDoButton.initWithIntro(true);
			thingsToDoButton.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			thingsToDoButton.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			weddingPartyButton = this.getChildByName(INSTANCE_NAME_BUTTON_WEDDING_PARTY) as NavButtonWeddingParty;
			_subComponents.push(weddingPartyButton);
			weddingPartyButton.initWithIntro(true);
			weddingPartyButton.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			weddingPartyButton.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			registryButton = this.getChildByName(INSTANCE_NAME_BUTTON_REGISTRY) as NavButtonRegistry;
			_subComponents.push(registryButton);
			registryButton.initWithIntro(true);
			registryButton.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			registryButton.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			storyOfUsButton = this.getChildByName(INSTANCE_NAME_BUTTON_STORY) as NavButtonStoryOfUs;
			_subComponents.push(storyOfUsButton);
			storyOfUsButton.initWithIntro(true);
			storyOfUsButton.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			storyOfUsButton.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			venueButton = this.getChildByName(INSTANCE_NAME_BUTTON_VENUE) as NavButtonVenue;
			_subComponents.push(venueButton);
			venueButton.initWithIntro(true);
			venueButton.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			venueButton.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			wordMenu = this.getChildByName(INSTANCE_NAME_WORD_MENU) as WordMenu;
			_subComponents.push(wordMenu);
			wordMenu.initWithIntro(true);
			wordMenu.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			wordMenu.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			borderGraphics = this.getChildByName(INSTANCE_NAME_BORDER_GRAPHICS) as BorderGraphics;
			_subComponents.push(borderGraphics);
			borderGraphics.initWithIntro(false);
			borderGraphics.setDelayLaunchIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_LAUNCH_INTERVAL);
			borderGraphics.setDelayCloseIndexAndInterval(_subComponents.length,AppConstants.NAV_MENU_CLOSE_INTERVAL);
			
			_navigationController = NavigationController.getInstance();
			_model = Model.getInstance();
			
			//listen
			rsvpButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onNavButtonPressed, false, 0, true);
			newYorkWeddingButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onNavButtonPressed, false, 0, true);
			thingsToDoButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onNavButtonPressed, false, 0, true);
			weddingPartyButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onNavButtonPressed, false, 0, true);
			registryButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onNavButtonPressed, false, 0, true);
			storyOfUsButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onNavButtonPressed, false, 0, true);
			venueButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onNavButtonPressed, false, 0, true);
			_model.addEventListener(Model.NEW_NAV_BUTTON_SELECTED, onNewNavButtonSelected, false, 0, true);
			
			
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			//launch any composition elements here,
			//can also call launchSubComponentsSimultaneouslyWithCascade(true or false) or launchSubComponentsSequentially
			this.launchSubComponentsSimultaneouslyWithCascade(true);
		}
		
		private function onNavButtonPressed(evt:Event):void{
			_navigationController.navButtonPressed(String(evt.target));
		}
		
		private function onNewNavButtonSelected(evt:Event):void{
			this.closeSubComponentsSimultaneouslyWithCascade(true);
		}
	}
}