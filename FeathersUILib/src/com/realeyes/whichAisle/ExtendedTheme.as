////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle
{
	import feathers.controls.Label;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import starling.display.DisplayObjectContainer;
	
	public class ExtendedTheme extends MetalWorksMobileTheme
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static const NO_RESULTS_LABEL:String = 'noResults_lbl';
		public static const TITLE_SCREEN_LABEL:String = 'titleScreen_lbl';
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ExtendedTheme(container:DisplayObjectContainer=null, scaleToDPI:Boolean=true)
		{
			super(container, scaleToDPI);
		}
		
		
		override protected function initialize():void
		{
			super.initialize();
			
			setInitializerForClass( Label, noResultsLabelInitializer, NO_RESULTS_LABEL );
			setInitializerForClass( Label, titleScreenLabelInitializer, TITLE_SCREEN_LABEL );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function noResultsLabelInitializer( label:Label ):void
		{
			var tf:TextFormat = new TextFormat( "SourceSansProSemibold", 20, 0xFFFFFF );
			tf.align = TextFormatAlign.CENTER;
			label.textRendererProperties.textFormat = tf;
		}
		
		public function titleScreenLabelInitializer( label:Label ):void
		{
			var tf:TextFormat = new TextFormat( "SourceSansProSemibold", 40, 0xFFFFFF );
			tf.align = TextFormatAlign.CENTER;
			label.textRendererProperties.textFormat = tf;
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}