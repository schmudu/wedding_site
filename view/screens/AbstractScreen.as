package com.schmudu.wedding.view.screens{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.iterators.ArrayIterator;
	import com.schmudu.lib.events.UIObjectEvent;
	import com.schmudu.lib.view01.AbstractComp;
	import com.schmudu.lib.view01.AbstractButton;
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.controller.NavigationController;
	import com.schmudu.wedding.model.Model;
	
	public class AbstractScreen extends AbstractComp{
	
		public var textMC							:MovieClip;
		//public var menuButton						:MenuButton;
		public var menuButton						:AbstractButton;
		
		private const INSTANCE_NAME_TEXT_MC			:String = "textMC";
		private const INSTANCE_NAME_MENU_BUTTON		:String = "menuButton";
		
		private var _navigationController			:NavigationController;
		private var _model							:Model;
		
		public function AbstractScreen(){
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			//move to a faraway place
			this.x = AppConstants.HIDE_POSITION;
			
			//menuButton = this.getChildByName(INSTANCE_NAME_MENU_BUTTON) as MenuButton;
			menuButton = this.getChildByName(INSTANCE_NAME_MENU_BUTTON) as AbstractButton;
			menuButton.initWithIntro(true);
			
			textMC = this.getChildByName(INSTANCE_NAME_TEXT_MC) as MovieClip;
			textMC.alpha = 0;
			
			//listen
			menuButton.addEventListener(UIObjectEvent.MOUSE_RELEASED, onMenuButtonPressed, false, 0, true);
		}
		
		override protected function onFinishedClosingIntro(evt:Event = null):void{
			//move to hide position
			this.x = AppConstants.HIDE_POSITION;
			
			super.onFinishedClosingIntro();
		}
		
		override public function launch():void{
			this.x = 0;
			
			super.launch();
		}
		
		override public function close():void{
			//close and disable close button
			menuButton.disable();
			menuButton.close();
		
			Tweener.removeTweens(textMC);
			//Tweener.addTween(textMC, {_frame:1, time:_introTransitionTimeHide, transition:_transitionType, onComplete:onFinishedHidingTextMC});
			Tweener.addTween(textMC, {_frame:1, time:_introTransitionTimeHide, transition:_transitionType});
			
			//close sub components
			closeSubComponentsSimultaneouslyWithCascade(true);
		}

		protected function onFinishedHidingTextMC(evt:Event = null):void{
			//continue close process
			closeElements();
		}
		
		override protected function onFinishedLaunchingIntro(evt:Event = null):void{
			textMC.alpha = 1;
			Tweener.removeTweens(textMC);
			Tweener.addTween(textMC, {_frame:10, time:_introTransitionTimeShow, transition:_transitionType, onComplete:onFinishedShowingTextMC});
		}
		
		protected function onFinishedShowingTextMC(evt:Event = null):void{
			//listen
			menuButton.addEventListener(UIObjectEvent.FINISHED_LAUNCHING, onFinishedLaunchingMenuButton, false, 0, true);
			menuButton.launch();
		}
		
		protected function onFinishedLaunchingMenuButton(evt:Event):void{
			//remove listener
			menuButton.removeEventListener(UIObjectEvent.FINISHED_LAUNCHING, onFinishedLaunchingMenuButton);
			
			//enable
			menuButton.enable();
			
			//launch the rest of the components
			this.launchSubComponentsSimultaneouslyWithCascade(true);
		}
		
		protected function onMenuButtonPressed(evt:Event):void{
			//close screen
			this.close();
		}
	}
}