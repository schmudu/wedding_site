package com.schmudu.wedding.controller {
 	import flash.events.EventDispatcher;
	import flash.events.Event;
 	
	import com.schmudu.wedding.model.RSVPManager;
	public class RSVPController extends EventDispatcher{
		private static var _myInstance					:RSVPController;
		
		private var _rsvpManager							:RSVPManager;
		public function RSVPController(enforcer:SingletonEnforcer){
		}
		
		/* Name: getInstance
		 * Comment: Singleton Pattern.  There should only be one type of view in the application
		 */
		public static function getInstance():RSVPController{
			 if(RSVPController._myInstance == null){
				 RSVPController._myInstance = new RSVPController(new SingletonEnforcer());
			 }
			 return RSVPController._myInstance;
		}
		
		public function init():void{
			_rsvpManager = RSVPManager.getInstance();
		}
		
		public function loginUser(p_firstName:String, p_lastName:String):void{
			_rsvpManager.loginUser(p_firstName, p_lastName);
		}
		
		public function attendanceButtonCurrentlyOpen(p_open:Boolean):void{
			_rsvpManager.oneButtonAttendanceCurrentlyOpen = p_open;
		}
		
		public function submitGuestDataToServer():void{
			_rsvpManager.submitGuestDataToServer();
		}
	}
}
class SingletonEnforcer{}
