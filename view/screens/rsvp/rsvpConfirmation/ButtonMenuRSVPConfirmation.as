package com.schmudu.wedding.view.screens.rsvp.rsvpConfirmation{
	import com.schmudu.lib.view01.AbstractButton;
	import flash.events.Event;
	
	public class ButtonMenuRSVPConfirmation extends AbstractButton{
		public function MenuButtonRSVPConfirmation(){
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			//don't enable button until server has been confirmed
			//enable();
			
			//launch any composition elements here,
			//can also call launchSubComponentsSmultaneously, launchSubComponentsSequentially, or launchSubComponentsCascade
			launchElements();
		}
	}
}