package com.schmudu.wedding.view.navigationMenu{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import com.caurina.transitions.Tweener;
	import com.schmudu.lib.events.UIObjectEvent;
	
	
	
	public class NavButtonNewYorkWedding extends AbstractNavButton{
		public static var classType = "[object NavButtonNewYorkWedding]";
		
		public function NavButtonNewYorkWedding(){
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);
			
			_classType = "[object NavButtonNewYorkWedding]";
		}
	}
}