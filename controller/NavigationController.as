package com.schmudu.wedding.controller {
 	import flash.events.EventDispatcher;
	import flash.events.Event;
 
	import com.schmudu.wedding.model.Model;
	
	public class NavigationController extends EventDispatcher{
		
		private static var _myInstance					:NavigationController;
		private var _model									:Model;
		
		public function NavigationController(enforcer:SingletonEnforcer){
		}
		
		/* Name: getInstance
		 * Comment: Singleton Pattern.  There should only be one type of view in the application
		 */
		public static function getInstance():NavigationController{
			 if(NavigationController._myInstance == null){
				 NavigationController._myInstance = new NavigationController(new SingletonEnforcer());
			 }
			 return NavigationController._myInstance;
		}
		
		public function init():void{
			_model = Model.getInstance();
		}
		
		public function navButtonPressed(p_button:String):void{
			//set the new button pressed
			_model.navButtonSelected = p_button;
		}
	}
}
class SingletonEnforcer{}
