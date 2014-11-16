package com.schmudu.wedding.view.navigationMenu{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.events.UIObjectEvent;
	
	
	
	public class NavButtonVenue extends AbstractNavButton{
		public static var classType = "[object NavButtonVenue]";
	
		public function NavButtonVenue(){
		}

		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			_classType = "[object NavButtonVenue]";
		}
		
		
	}
}