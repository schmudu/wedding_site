package com.schmudu.wedding.view.screens.weddingParty{
	import com.schmudu.wedding.constants.AppConstants;
	import com.schmudu.wedding.view.screens.contentButton.*;
	
	import com.schmudu.lib.view01.AbstractComp;
	import com.schmudu.lib.events.UIObjectEvent;
	
	import com.caurina.transitions.Tweener;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class ImageManager extends AbstractComp{
		public var imagePatrick							:ImagePatrick;
		public var imageMichael							:ImageMichael;
		public var imageDustin							:ImageDustin;
		public var imageRyan							:ImageRyan;
		public var imageDarren							:ImageDarren;
		
		public var imageDina							:ImageDina;
		public var imageStacey							:ImageStacey;
		public var imageKari							:ImageKari;
		public var imageKeri							:ImageKeri;
		public var imageJun								:ImageJun;
		public var imageNgoce							:ImageNgoce;
		
		private const INSTANCE_NAME_TEXT_PATRICK		:String = "imagePatrick";
		private const INSTANCE_NAME_TEXT_MICHAEL		:String = "imageMichael";
		private const INSTANCE_NAME_TEXT_DUSTIN			:String = "imageDustin";
		private const INSTANCE_NAME_TEXT_RYAN			:String = "imageRyan";
		private const INSTANCE_NAME_TEXT_DARREN			:String = "imageDarren";
		
		private const INSTANCE_NAME_TEXT_DINA			:String = "imageDina";
		private const INSTANCE_NAME_TEXT_STACEY			:String = "imageStacey";
		private const INSTANCE_NAME_TEXT_KARI			:String = "imageKari";
		private const INSTANCE_NAME_TEXT_KERI			:String = "imageKeri";
		private const INSTANCE_NAME_TEXT_JUN			:String = "imageJun";
		private const INSTANCE_NAME_TEXT_NGOCE			:String = "imageNgoce";
		
		private var _currentImage						:AbstractComp;
		private var _newButtonPressed					:String;
		
		public function ImageManager(){
			
		}

		override public function close():void{
			//close any content that's opened	
			if(_currentImage!=null)
				_currentImage.close();
			
			super.close();
		}
		
		override public function initWithIntro(p_intro:Boolean):void{
			super.initWithIntro(p_intro);

			imagePatrick = this.getChildByName(INSTANCE_NAME_TEXT_PATRICK) as ImagePatrick;
			imagePatrick.initWithIntro(true);			
			imageMichael = this.getChildByName(INSTANCE_NAME_TEXT_MICHAEL) as ImageMichael;
			imageMichael.initWithIntro(true);
			imageDustin = this.getChildByName(INSTANCE_NAME_TEXT_DUSTIN) as ImageDustin;
			imageDustin.initWithIntro(true);
			imageRyan = this.getChildByName(INSTANCE_NAME_TEXT_RYAN) as ImageRyan;
			imageRyan.initWithIntro(true);
			imageDarren = this.getChildByName(INSTANCE_NAME_TEXT_DARREN) as ImageDarren;
			imageDarren.initWithIntro(true);
			
			imageDina = this.getChildByName(INSTANCE_NAME_TEXT_DINA) as ImageDina;
			imageDina.initWithIntro(true);
			imageStacey = this.getChildByName(INSTANCE_NAME_TEXT_STACEY) as ImageStacey;
			imageStacey.initWithIntro(true);
			imageKari = this.getChildByName(INSTANCE_NAME_TEXT_KARI) as ImageKari;
			imageKari.initWithIntro(true);
			imageKeri = this.getChildByName(INSTANCE_NAME_TEXT_KERI) as ImageKeri;
			imageKeri.initWithIntro(true);
			imageJun = this.getChildByName(INSTANCE_NAME_TEXT_JUN) as ImageJun;
			imageJun.initWithIntro(true);
			imageNgoce = this.getChildByName(INSTANCE_NAME_TEXT_NGOCE) as ImageNgoce;
			imageNgoce.initWithIntro(true);
			
		}
		
		public function onButtonPressed(p_button:String):void{
			//store button information
			_newButtonPressed = p_button;
			
			//fade any previous
			if(_currentImage != null){
				_currentImage.addEventListener(UIObjectEvent.FINISHED_CLOSING, onImageFinishedClosingForNewImage, false, 0, true);
				_currentImage.close();
			}
			else{
				onImageFinishedClosingForNewImage();
			}
			
			
		}
		
		private function onImageFinishedClosingForNewImage(evt:Event = null):void{
			//remove listener
			if(_currentImage !=null)
				_currentImage.removeEventListener(UIObjectEvent.FINISHED_CLOSING, onImageFinishedClosingForNewImage);
			
			//this method launches the next image because the old image is finished closing
			switch(_newButtonPressed){
				case ButtonGroomsmenPatrick.classType:
					_currentImage = imagePatrick;
					break;
				case ButtonGroomsmenMichael.classType:
					_currentImage = imageMichael;
					break;
				case ButtonGroomsmenDustin.classType:
					_currentImage = imageDustin;
					break;
				case ButtonGroomsmenRyan.classType:
					_currentImage = imageRyan;
					break;
				case ButtonGroomsmenDarren.classType:
					_currentImage = imageDarren;
					break;
					
					
				case ButtonBridesmaidDina.classType:
					_currentImage = imageDina;
					break;
				case ButtonBridesmaidStacey.classType:
					_currentImage = imageStacey;
					break;
				case ButtonBridesmaidKari.classType:
					_currentImage = imageKari;
					break;
				case ButtonBridesmaidKeri.classType:
					_currentImage = imageKeri;
					break;
				case ButtonBridesmaidJun.classType:
					_currentImage = imageJun;
					break;
				case ButtonBridesmaidNgoce.classType:
					_currentImage = imageNgoce;
					break;
				
			}
			
			//launch new image
			if(_currentImage!=null)
				_currentImage.launch();
		}
	}
}
