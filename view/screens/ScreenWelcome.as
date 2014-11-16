package com.schmudu.wedding.view.screens{
	import flash.display.MovieClip;
	
	public class ScreenWelcome extends AbstractScreen{
	
		public var disabledMC						:MovieClip;
		
		private const INSTANCE_NAME_DISABLED_MC		:String = "disabledMC";
		
		public function ScreenWelcome(){
		}

		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			disabledMC = this.getChildByName(INSTANCE_NAME_DISABLED_MC) as MovieClip;
			
			_classType = "[object ScreenWelcome]";
		}
		
		
	}
}