package com.schmudu.wedding.model {
 	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	import com.schmudu.lib.events.CustomEvent;
 
	public class Model extends EventDispatcher{
		public static var FINISHED_INITIALIZING 		:String = "FINISHED_INITIALIZING";
		public static var NEW_NAV_BUTTON_SELECTED		:String = "NEW_NAV_BUTTON_SELECTED";
		
		private static var _myInstance					:Model;
		private var _rsvpManager							:RSVPManager;
		//vars
		private var _navButtonSelected						:String;
		
		public function Model(enforcer:SingletonEnforcer){
		}
		
		/* Name: getInstance
		 * Comment: Singleton Pattern.  There should only be one type of view in the application
		 */
		public static function getInstance():Model{
			 if(Model._myInstance == null){
				 Model._myInstance = new Model(new SingletonEnforcer());
			 }
			 return Model._myInstance;
		}
		
		public function init():void{
			_rsvpManager = RSVPManager.getInstance();
			_rsvpManager.init();
			
			dispatchEvent(new Event(FINISHED_INITIALIZING));
		}
		
		public function get navButtonSelected():String{
			return _navButtonSelected;
		}
		
		public function set navButtonSelected(s:String):void{
			var myEvent:CustomEvent = new CustomEvent(NEW_NAV_BUTTON_SELECTED);
			
			//store the old button selected
			myEvent.customData = _navButtonSelected;
			
			//set new button selected
			_navButtonSelected = s;
			
			dispatchEvent(myEvent);
		}
	}
}
class SingletonEnforcer{}
		