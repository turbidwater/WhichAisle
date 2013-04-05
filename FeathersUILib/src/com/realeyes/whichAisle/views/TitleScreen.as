////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import feathers.controls.Label;
	import feathers.controls.Screen;
	
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class TitleScreen extends Screen
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var title_lbl:Label;
		
		public var clickedSignal:Signal;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function TitleScreen()
		{
			super();
			
			clickedSignal = new Signal();
			_initLayout();
			_initListeners();
		}
		
		private function _initLayout():void
		{
			title_lbl = new Label();
			title_lbl.text = "Which Aisle?";
			
			title_lbl.y = height/3;
			title_lbl.x = width/2 - title_lbl.width/2;
			
			var textFormat:TextFormat = new TextFormat( null, 32, 0xFFFFFF );
			title_lbl.textRendererProperties = { textFormat:textFormat };
			
			addChild( title_lbl );
		}
		
		private function _initListeners():void
		{
			addEventListener( TouchEvent.TOUCH, _onTouch );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onTouch( event:TouchEvent ):void
		{
			event.stopImmediatePropagation();
			var touch:Touch = event.getTouch( this, TouchPhase.ENDED );
			if( touch )
			{
				clickedSignal.dispatch();
			}
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}