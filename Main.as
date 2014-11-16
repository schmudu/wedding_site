package com.schmudu.wedding{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.BlurFilter;
	
	import com.caurina.transitions.properties.DisplayShortcuts;
	import com.caurina.transitions.properties.ColorShortcuts;
	
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.lib.view01.AbstractComp;
	
	import com.schmudu.wedding.view.navigationMenu.*;
	import com.schmudu.wedding.view.screens.*;
	import com.schmudu.wedding.model.Model;
	import com.schmudu.wedding.controller.Controller;
	
	public class Main extends MovieClip{
		private const INSTANCE_NAME_BUTTON_ATTENDANCE				:String = "buttonAttendance";
		
		public var navigationMenu							:NavigationMenu;
		public var screenRegistry							:ScreenRegistry;
		public var screenThingsToDo							:ScreenThingsToDo;
		public var screenVenue								:ScreenVenue;
		public var screenWeddingParty						:ScreenWeddingParty;
		public var screenStoryOfUs							:ScreenStoryOfUs;
		public var screenNewYorkWedding						:ScreenNewYorkWedding;
		public var screenRSVP								:ScreenRSVP;
		public var screenWelcome							:ScreenWelcome;
		
		private const INSTANCE_NAME_NAVIGATION_MENU				:String = "navigationMenu";
		private const INSTANCE_NAME_SCREEN_REGISTRY				:String = "screenRegistry";
		private const INSTANCE_NAME_SCREEN_THINGS_TO_DO			:String = "screenThingsToDo";
		private const INSTANCE_NAME_SCREEN_VENUE					:String = "screenVenue";
		private const INSTANCE_NAME_SCREEN_WEDDING_PARTY		:String = "screenWeddingParty";
		private const INSTANCE_NAME_SCREEN_NEW_YORK_WEDDING	:String = "screenNewYorkWedding";
		private const INSTANCE_NAME_SCREEN_STORY_OF_US			:String = "screenStoryOfUs";
		private const INSTANCE_NAME_SCREEN_RSVP					:String = "screenRSVP";
		private const INSTANCE_NAME_SCREEN_WELCOME				:String = "screenWelcome";
		
		//private vars
		private var _model									:Model;
		private var _controller								:Controller;
		
		public function Main(){
		}
		
		public function init():void{
			//init ui objects
			DisplayShortcuts.init();
			ColorShortcuts.init();
			
			navigationMenu = this.parent.getChildByName(INSTANCE_NAME_NAVIGATION_MENU) as NavigationMenu;
			navigationMenu.initWithIntro(true);
			
			screenRegistry = this.parent.getChildByName(INSTANCE_NAME_SCREEN_REGISTRY) as ScreenRegistry;
			screenRegistry.initWithIntro(true);
			
			screenThingsToDo = this.parent.getChildByName(INSTANCE_NAME_SCREEN_THINGS_TO_DO) as ScreenThingsToDo;
			screenThingsToDo.initWithIntro(true);
			
			screenVenue = this.parent.getChildByName(INSTANCE_NAME_SCREEN_VENUE) as ScreenVenue;
			screenVenue.initWithIntro(true);
			
			screenWeddingParty = this.parent.getChildByName(INSTANCE_NAME_SCREEN_WEDDING_PARTY) as ScreenWeddingParty;
			screenWeddingParty.initWithIntro(true);
			
			screenNewYorkWedding = this.parent.getChildByName(INSTANCE_NAME_SCREEN_NEW_YORK_WEDDING) as ScreenNewYorkWedding;
			screenNewYorkWedding.initWithIntro(true);
			
			screenStoryOfUs = this.parent.getChildByName(INSTANCE_NAME_SCREEN_STORY_OF_US) as ScreenStoryOfUs;
			screenStoryOfUs.initWithIntro(true);
			
			screenRSVP = this.parent.getChildByName(INSTANCE_NAME_SCREEN_RSVP) as ScreenRSVP;
			screenRSVP.initWithIntro(true);
			
			screenWelcome = this.parent.getChildByName(INSTANCE_NAME_SCREEN_WELCOME) as ScreenWelcome;
			screenWelcome.initWithIntro(true);
			
			//init model
			_model = Model.getInstance();
			
			//listen
			_model.addEventListener(Model.FINISHED_INITIALIZING, onModelFinishedInitializing, false, 0, true);
			navigationMenu.addEventListener(UIObjectEvent.FINISHED_CLOSING, onNavMenuFinishedClosing, false, 0, true);
			screenRegistry.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenFinishedClosing, false, 0, true);
			screenThingsToDo.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenFinishedClosing, false, 0, true);
			screenVenue.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenFinishedClosing, false, 0, true);
			screenWeddingParty.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenFinishedClosing, false, 0, true);
			screenNewYorkWedding.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenFinishedClosing, false, 0, true);
			screenStoryOfUs.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenFinishedClosing, false, 0, true);
			screenRSVP.addEventListener(UIObjectEvent.FINISHED_CLOSING, onScreenFinishedClosing, false, 0, true);
			
			_model.init();
			
		}
		
		private function addNavigationMenuBlur():void{
			var filter:BitmapFilter = new BlurFilter(20, 20, BitmapFilterQuality.LOW);
		    var myFilters:Array = new Array();
		    myFilters.push(filter);
		    navigationMenu.filters = myFilters;
		 
		}
		
		private function onModelFinishedInitializing(evt:Event):void{
			//remove listener
			_model.removeEventListener(Model.FINISHED_INITIALIZING, onModelFinishedInitializing);
			
			_controller = Controller.getInstance();
			_controller.addEventListener(Controller.FINISHED_INITIALIZING, onControllerFinishedInitializing, false, 0, true);
			_controller.init();
		}

		private function onControllerFinishedInitializing(evt:Event):void{
			//remove listener
			_controller.removeEventListener(Controller.FINISHED_INITIALIZING, onControllerFinishedInitializing);
			
			//add listener for welcome screen
			screenWelcome.addEventListener(UIObjectEvent.FINISHED_CLOSING, onWelcomeScreenFinishedClosing, false, 0, true);
			
			//launch welcome screen
			screenWelcome.launch();
			
			//add blurs to navigation menu
			this.addNavigationMenuBlur();
						
			//launch ui objects
			navigationMenu.launch();
		}
		
		private function onNavMenuFinishedClosing(evt:Event):void{
//trace("nav menu finished closing model: " + _model.navButtonSelected);
			//launch the screen based on the model
			switch(_model.navButtonSelected){
				case NavButtonRegistry.classType:
					screenRegistry.launch();
					break;
				case NavButtonThingsToDo.classType:
					screenThingsToDo.launch();
					break;
				case NavButtonVenue.classType:
					screenVenue.launch();
					break;
				case NavButtonWeddingParty.classType:
					screenWeddingParty.launch();
					break;
				case NavButtonNewYorkWedding.classType:
					screenNewYorkWedding.launch();
					break;
				case NavButtonStoryOfUs.classType:
					screenStoryOfUs.launch();
					break;
				case NavButtonRSVP.classType:
					screenRSVP.launch();
					break;
			}
		}
		
		private function onScreenFinishedClosing(evt:Event):void{
			navigationMenu.launch();
		}
		
		private function onWelcomeScreenFinishedClosing(evt:Event):void{
			//remove listener
			screenWelcome.addEventListener(UIObjectEvent.FINISHED_CLOSING, onWelcomeScreenFinishedClosing);
			
			//remove blurs
			this.removeNavigationMenuBlur();
		}
		
		private function removeNavigationMenuBlur():void{
			navigationMenu.filters = null;
		}
	}
}