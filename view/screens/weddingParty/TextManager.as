package com.schmudu.wedding.view.screens.weddingParty{
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.view.screens.contentButton.*;
	
	import com.schmudu.lib.view01.AbstractComp;
	import com.schmudu.lib.events.UIObjectEvent;
	
	import com.caurina.transitions.Tweener;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class TextManager extends AbstractComp{
		public var textPatrick							:TextPatrick;
		public var textMichael							:TextMichael;
		public var textDustin							:TextDustin;
		public var textRyan								:TextRyan;
		public var textDarren							:TextDarren;
		
		public var textDina								:TextDina;
		public var textStacey							:TextStacey;
		public var textKari								:TextKari;
		public var textKeri								:TextKeri;
		public var textJun								:TextJun;
		public var textNgoce							:TextNgoce;
		
		private const INSTANCE_NAME_TEXT_PATRICK		:String = "textPatrick";
		private const INSTANCE_NAME_TEXT_MICHAEL		:String = "textMichael";
		private const INSTANCE_NAME_TEXT_DUSTIN			:String = "textDustin";
		private const INSTANCE_NAME_TEXT_RYAN			:String = "textRyan";
		private const INSTANCE_NAME_TEXT_DARREN			:String = "textDarren";
		
		private const INSTANCE_NAME_TEXT_DINA			:String = "textDina";
		private const INSTANCE_NAME_TEXT_STACEY			:String = "textStacey";
		private const INSTANCE_NAME_TEXT_KARI			:String = "textKari";
		private const INSTANCE_NAME_TEXT_KERI			:String = "textKeri";
		private const INSTANCE_NAME_TEXT_JUN			:String = "textJun";
		private const INSTANCE_NAME_TEXT_NGOCE			:String = "textNgoce";
		
		private var _currentText						:AbstractComp;
		private var _newButtonPressed					:String;
		
		public function TextManager(){
			
		}

		override public function close():void{
			//close any content that's opened
			if(_currentText!=null)
				_currentText.close();
			
			super.close();
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			textPatrick = this.getChildByName(INSTANCE_NAME_TEXT_PATRICK) as TextPatrick;
			textPatrick.initWithIntro(true);
			
			textMichael = this.getChildByName(INSTANCE_NAME_TEXT_MICHAEL) as TextMichael;
			textMichael.initWithIntro(true);
			textDustin = this.getChildByName(INSTANCE_NAME_TEXT_DUSTIN) as TextDustin;
			textDustin.initWithIntro(true);
			textRyan = this.getChildByName(INSTANCE_NAME_TEXT_RYAN) as TextRyan;
			textRyan.initWithIntro(true);
			textDarren = this.getChildByName(INSTANCE_NAME_TEXT_DARREN) as TextDarren;
			textDarren.initWithIntro(true);
			
			textDina = this.getChildByName(INSTANCE_NAME_TEXT_DINA) as TextDina;
			textDina.initWithIntro(true);
			textStacey = this.getChildByName(INSTANCE_NAME_TEXT_STACEY) as TextStacey;
			textStacey.initWithIntro(true);
			textKari = this.getChildByName(INSTANCE_NAME_TEXT_KARI) as TextKari;
			textKari.initWithIntro(true);
			textKeri = this.getChildByName(INSTANCE_NAME_TEXT_KERI) as TextKeri;
			textKeri.initWithIntro(true);
			textJun = this.getChildByName(INSTANCE_NAME_TEXT_JUN) as TextJun;
			textJun.initWithIntro(true);
			textNgoce = this.getChildByName(INSTANCE_NAME_TEXT_NGOCE) as TextNgoce;
			textNgoce.initWithIntro(true);
		}
		
		public function onButtonPressed(p_button:String):void{
			//store button information
			_newButtonPressed = p_button;
			
			//fade any previous
			if(_currentText != null){
				_currentText.addEventListener(UIObjectEvent.FINISHED_CLOSING, onTextFinishedClosingForNewText, false, 0, true);
				_currentText.close();
			}
			else{
				onTextFinishedClosingForNewText();
			}
			
			
		}
		
		private function onTextFinishedClosingForNewText(evt:Event = null):void{
			//remove listener
			if(_currentText !=null)
				_currentText.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onTextFinishedClosingForNewText);
			
			//this method launches the next text because the old text is finished closing
			switch(_newButtonPressed){
				case ButtonGroomsmenPatrick.classType:
					_currentText = textPatrick;
					break;
				case ButtonGroomsmenMichael.classType:
					_currentText = textMichael;
					break;
				case ButtonGroomsmenDustin.classType:
					_currentText = textDustin;
					break;
				case ButtonGroomsmenRyan.classType:
					_currentText = textRyan;
					break;
				case ButtonGroomsmenDarren.classType:
					_currentText = textDarren;
					break;
										
				case ButtonBridesmaidDina.classType:
					_currentText = textDina;
					break;
				case ButtonBridesmaidStacey.classType:
					_currentText = textStacey;
					break;
				case ButtonBridesmaidKari.classType:
					_currentText = textKari;
					break;
				case ButtonBridesmaidKeri.classType:
					_currentText = textKeri;
					break;
				case ButtonBridesmaidJun.classType:
					_currentText = textJun;
					break;
				case ButtonBridesmaidNgoce.classType:
					_currentText = textNgoce;
					break;
			}
			
			//launch new text
			if(_currentText!=null)
				_currentText.launch();
		}
	}
}
