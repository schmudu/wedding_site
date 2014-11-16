//
//  AppConstants.as
//
//  Created by Patrick Lee on 2009-08-10.
//  Copyright (c) 2009 Patrick Lee. All rights reserved.
//
package com.schmudu.wedding.constants{
	import flash.display.*;
	
	public class AppConstants{
		public static const HIDE_POSITION							:Number = -9999;
		
		public static const NAV_MENU_LAUNCH_INTERVAL				:Number = 50;
		public static const NAV_BUTTON_OVER_FRAME_ALPHA				:Number = .7;
		public static const NAV_BUTTON_OVER_TIME_SHOW				:Number = .3;
		public static const NAV_BUTTON_FRAME_SCALE_OVER				:Number = 1.2;
		public static const NAV_BUTTON_TINT_MC_ALPHA_OVER			:Number = .6;
		public static const NAV_MENU_CLOSE_INTERVAL					:Number = 60;
		public static const NAV_WORD_MENU_OVER_TIME					:Number = .2;
		public static const NAV_WORD_MENU_OVER_FRAMES_BEGIN			:Number = 8;
		public static const NAV_WORD_MENU_OVER_FRAMES_END			:Number = 15;
		public static const SCREEN_POSITION_REGISTRY_X				:Number = 100;
		public static const SCREEN_POSITION_THINGS_TO_DO_X			:Number = 100;
		public static const SCREEN_CONTENT_BUTTON_LAUNCH_DELAY		:Number = 50;
		public static const NAVIGATE_TO_URL_WINDOW					:String = "_self";
		
		//rsvp
		public static const RSVP_CLOSE_INTERVAL						:Number = 50;
		public static const RSVP_LAUNCH_INTERVAL					:Number = 50;
		public static const RSVP_GUEST_SELECTION_POS_X				:Number = 723.1;
		public static const RSVP_GUEST_SELECTION_POS_STARTING_Y		:Number = -269;
		public static const RSVP_GUEST_SELECTION_INTERVAL_Y			:Number = 40;
		public static const GUEST_SELECTION_FONT_FAMILY				:String = "BlairMdITC TT";
		public static const GUEST_SELECTION_FONT_SIZE				:int = 12;
		public static const GUEST_SELECTION_FONT_COLOR				:uint = 0xffffff;
		public static const GUEST_SELECTION_TEXTFIELD_WIDTH			:Number = 180;
		public static const BUTTON_NOT_ATTENDING_DELAY				:Number = 50;
		public static const GUEST_SELECTION_BUTTON_POS_X			:Number = 216;
		public static const MESSAGE_BUFFER_VERTICAL					:Number = 20;
		public static const BUTTON_BUFFER_VERTICAL					:Number = 35;
		public static const DATABASE_GUEST_DEFAULT_NAME				:String = "Guest";
		public static const TEXT_ENTER_GUEST_NAME					:String = "Enter guest name";
		public static const URL_PHP_SUBMIT_RSVP						:String = "./php/actionSubmitRSVP.php";
		public static const URL_PHP_LOGIN							:String = "./php/actionLogin.php";
		public static const MESSAGE_RSVP_SUCCESSFUL					:String = "MESSAGE_RSVP_SUCCESSFUL";
		public static const MESSAGE_RSVP_FAILED						:String = "MESSAGE_RSVP_FAILED";
		
		//player 
		public static const MENU_BUTTON_ORIGINAL_POS_X				:Number = 575.5;
		public static const MENU_BUTTON_ORIGINAL_POS_Y				:Number = 420.5;
		public static const MENU_BUTTON_PLAYER_POSITION_X			:Number = 927;
		public static const MENU_BUTTON_PLAYER_POSITION_Y			:Number = 400;
		public static const MOVIE_PROGRESS_TIMER					:Number = 10;
		public static const MOVIE_CONSTANT_HEIGHT					:Number = 380;	
		public static const MOVIE_CONSTANT_WIDTH					:Number = 720;
		public static const NETSTREAM_BUFFER_TIME					:Number = 10;
		
		//wedding party
		public static const WEDDING_PARTY_OVER_COLOR				:uint = 0x333333;
		public static const WEDDING_PARTY_SELECTED_COLOR			:uint = 0x6699cc;
		
	}
}