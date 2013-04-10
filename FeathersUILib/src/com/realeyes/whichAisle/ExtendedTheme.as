////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle
{
	import com.realeyes.whichAisle.views.itemRenderers.ItemsListItemRenderer;
	
	import feathers.controls.Button;
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
		public static const ITEM_LIST_AISLE_LABEL:String = 'aisle_lbl';
		public static const ITEM_LIST_RENDERER_BUTTON:String = 'itemRenderer_btn';
		
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
			setInitializerForClass( Label, itemListAisleLabelInitializer, ITEM_LIST_AISLE_LABEL );
			//setInitializerForClass( Button, itemListRendererButtonInitializer, ITEM_LIST_RENDERER_BUTTON );
			setInitializerForClass( ItemsListItemRenderer, itemRendererInitializer);
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
		
		public function itemListAisleLabelInitializer( label:Label ):void
		{
			var tf:TextFormat = new TextFormat( "SourceSansProSemibold", 14, 0x666666 );
			tf.align = TextFormatAlign.RIGHT;
			label.textRendererProperties.textFormat = tf;
		}
		
		public function itemListRendererButtonInitializer( button:Button ):void
		{
			
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}