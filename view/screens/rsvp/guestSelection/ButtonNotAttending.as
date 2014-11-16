package com.schmudu.wedding.view.screens.rsvp.guestSelection{
	import com.schmudu.wedding.view.screens.contentButton.AbstractContentButton;
	import com.schmudu.wedding.constants.AppConstants;
	import flash.events.Event;
	
	public class ButtonNotAttending extends AbstractContentButton{
		public static var classType = "[object ButtonNotAttending]";
		
		public function ButtonNotAttending(){
		}	
		
		override public function initWithIntro(p_intro:Boolean):void{
			this.x = AppConstants.HIDE_POSITION;

			super.initWithIntro(p_intro);
		}

		override public function launch():void{
			this.x = 0;

			super.launch();
		}

		override protected function onFinishedClosingIntro(evt:Event = null):void{
			this.x = AppConstants.HIDE_POSITION;

			super.onFinishedClosingIntro();
				}
		}
}