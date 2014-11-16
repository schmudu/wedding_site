package com.schmudu.wedding.view.screens.rsvp.guestAlreadyConfirmed{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import fl.controls.TextInput;
	import fl.managers.FocusManager;
   
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.iterators.ArrayIterator;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.lib.view01.AbstractComp;
	
	import com.schmudu.wedding.view.screens.MenuButton;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.controller.RSVPController;
	import com.schmudu.wedding.model.Model;
	import com.schmudu.wedding.model.Guest;
	import com.schmudu.wedding.model.RSVPManager;
	import com.schmudu.wedding.view.screens.SubmitButton;
	import com.schmudu.wedding.view.screens.rsvp.guestSelection.*;
	import com.schmudu.wedding.view.screens.rsvp.confirmation.GuestConfirmationElement;
	
	public class SubScreenGuestAlreadyConfirmed extends AbstractComp{
		//public var debugTextField						:TextField;
		public var menuButton							:MenuButton;
		public var alreadyConfirmedMC					:MessageAlreadyConfirmed;
		
		private const INSTANCE_NAME_ALREADY_CONFIRMED	:String = "alreadyConfirmedMC";
		private const INSTANCE_NAME_MENU_BUTTON			:String = "menuButton";
		
		private var _rsvpController						:RSVPController;
		private var _rsvpManager							:RSVPManager;
		private var _guestSelectionElementList			:ArrayIterator;
		
		public function SubScreenGuestAlreadyConfirmed(){
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			//focus manager
			_rsvpController = RSVPController.getInstance();
			_rsvpManager = RSVPManager.getInstance();
			_guestSelectionElementList = new ArrayIterator(new Array());
			
			//move to a faraway place
			this.x = AppConstants.HIDE_POSITION;
			
			alreadyConfirmedMC = this.getChildByName(INSTANCE_NAME_ALREADY_CONFIRMED) as MessageAlreadyConfirmed;
			alreadyConfirmedMC.initWithIntro(true);
			
			menuButton = this.getChildByName(INSTANCE_NAME_MENU_BUTTON) as MenuButton;
			menuButton.initWithIntro(true);
			menuButton.setDelayLaunchIndexAndInterval(_subComponents.length, AppConstants.RSVP_LAUNCH_INTERVAL);
			menuButton.setDelayCloseIndexAndInterval(_subComponents.length, AppConstants.RSVP_CLOSE_INTERVAL);
			_subComponents.push(menuButton);
				
			//listen
			menuButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMenuButtonPressed, false, 0, true);
		}
		
		override protected function onFinishedClosingIntro(evt:Event = null):void{
			//move to hide position
			this.x = AppConstants.HIDE_POSITION;
						
			super.onFinishedClosingIntro();
		}
		
		override public function launch():void{
			//reset variables
			
			positionContentOnScreen();
			
			//create elements
			this.createGuestConfirmationElements();
			
			//move to proper position
			this.x = 0;
			onFinishedLaunchingIntro();
			
		}
		
		private function positionContentOnScreen():void{
			//show text and position it
			alreadyConfirmedMC.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + _rsvpManager.guestList.length * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y + AppConstants.MESSAGE_BUFFER_VERTICAL;
			alreadyConfirmedMC.launch();
			
			//position buttons also
			//menuButton.y = alreadyConfirmedMC.y + AppConstants.BUTTON_BUFFER_VERTICAL;
		}
		
		override public function close():void{
			//close and disable close button
			menuButton.disable();
			menuButton.close();
			
			//close messages
			alreadyConfirmedMC.close();
			
			//remove elements
			this.removeGuestElements();
			
			//close sub components
			closeSubComponentsSimultaneouslyWithCascade(true);
		}
		
		override protected function onFinishedLaunchingElements():void{
			dispatchEvent(new Event(UIObjectEvent.FINISHED_LAUNCHING))
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			launchSubComponentsSimultaneouslyWithCascade(true);
		}
		
		protected function onMenuButtonPressed(evt:Event):void{
			//close screen
			this.close();
		}
			
		private function createGuestConfirmationElements():void{
			//get the list of guests
			var guestList:ArrayIterator = _rsvpManager.guestList;
			//var guestSelectionElement:AbstractGuestSelectionElement;
			var guestSelectionElement:GuestConfirmationElement;
			var guestData:Guest;
			
			//reset list
			guestList.reset();
			
			//cycle through the guest list and create a element for each one
			for(var i:int=0; i<guestList.length; i++){
				//get data
				guestData = Guest(guestList.getCurrentObject());
				
				//create new element
				guestSelectionElement = new GuestConfirmationElement(guestData);
				
				//position it
				guestSelectionElement.y = AppConstants.RSVP_GUEST_SELECTION_POS_STARTING_Y + i * AppConstants.RSVP_GUEST_SELECTION_INTERVAL_Y;
				guestSelectionElement.x = AppConstants.RSVP_GUEST_SELECTION_POS_X;
				
				//add to stage
				addChild(guestSelectionElement);
				
				//push to list to remove
				_guestSelectionElementList.push(guestSelectionElement);
				
				//increment
				guestList.increment();
			}			
		}
		
		private function removeGuestElements():void{
			var currentElement:MovieClip;
			
			//pop all of them
			while(_guestSelectionElementList.length>0){
				currentElement = MovieClip(_guestSelectionElementList.pop());
				
				//remove from stage
				this.removeChild(currentElement);
			}
			
				
		}
	}
}