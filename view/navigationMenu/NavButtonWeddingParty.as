package com.schmudu.wedding.view.navigationMenu{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.events.UIObjectEvent;
	
	
	
	public class NavButtonWeddingParty extends AbstractNavButton{
		public static var classType = "[object NavButtonWeddingParty]";
	
		public function NavButtonWeddingParty(){
		}

		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			_classType = "[object NavButtonWeddingParty]";
		}
		
		
	}
}