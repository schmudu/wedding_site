package com.schmudu.wedding.controller {
 	import flash.events.EventDispatcher;
	import flash.events.Event;
 
	public class Controller extends EventDispatcher{
		public static var FINISHED_INITIALIZING 		:String = "FINISHED_INITIALIZING";
		private static var _myInstance					:Controller;
		private var _navigationController				:NavigationController;
		private var _rsvpController						:RSVPController;
		public function Controller(enforcer:SingletonEnforcer){
		}
		
		/* Name: getInstance
		 * Comment: Singleton Pattern.  There should only be one type of view in the application
		 */
		public static function getInstance():Controller{
			 if(Controller._myInstance == null){
				 Controller._myInstance = new Controller(new SingletonEnforcer());
			 }
			 return Controller._myInstance;
		}
		
		public function init():void{
			_navigationController = NavigationController.getInstance();
			_navigationController.init();
			
			_rsvpController = RSVPController.getInstance();
			_rsvpController.init();
			
			dispatchEvent(new Event(FINISHED_INITIALIZING));
		}
	}
}
class SingletonEnforcer{}
