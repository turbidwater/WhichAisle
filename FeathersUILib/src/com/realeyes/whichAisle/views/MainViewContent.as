////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.realeyes.whichAisle.control.presenters.MainViewPresenter;
	import com.realeyes.whichAisle.control.signals.InitApplicationSignal;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.text.TextFormat;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class MainViewContent extends Screen
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var presenter:MainViewPresenter;
		
		public var red_btn:Button;
		public var green_btn:Button;
		public var blue_btn:Button;
		public var label_lbl:Label;
		
		protected var theme:MetalWorksMobileTheme;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MainViewContent()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, _onRemovedFromStage );
		}
		
		private function _init():void
		{
			presenter = new MainViewPresenter();
			theme = new MetalWorksMobileTheme();
			
			_initLayout();
			_initListeners();
			
			//Kick off the application start
			new InitApplicationSignal().dispatch();
		}
		
		private function _initLayout():void
		{
			red_btn = new Button();
			red_btn.x = 15;
			red_btn.y = 15;
			red_btn.width = 100;
			red_btn.height = 100;
			red_btn.label = "Red";
			addChild( red_btn );
			
			green_btn = new Button();
			green_btn.x = 130;
			green_btn.y = 15;
			green_btn.width = 100;
			green_btn.height = 100;
			green_btn.label = "Green";
			addChild( green_btn );
			
			blue_btn = new Button();
			blue_btn.x = 245;
			blue_btn.y = 15;
			blue_btn.width = 100;
			blue_btn.height = 100;
			blue_btn.label = "Blue";
			addChild( blue_btn );
			
			label_lbl = new Label();
			label_lbl.x = 15;
			label_lbl.y = 130;
			label_lbl.text = "This is a Feathers application";
			label_lbl.textRendererProperties.embedFonts = true;
			label_lbl.textRendererProperties.isHTML = true;
			addChild( label_lbl );
		}
		
		private function _initListeners():void
		{
			//Presenter listeners
			presenter.colorChangedSignal.add( _onColorChanged );
			
			//UI Listeners
			red_btn.addEventListener( Event.TRIGGERED, _onRedTouch );
			green_btn.addEventListener( Event.TRIGGERED, _onGreenTouch );
			blue_btn.addEventListener( Event.TRIGGERED, _onBlueTouch );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------

		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onAddedToStage( event:Event ):void
		{
			_init();
		}
		
		private function _onRemovedFromStage( event:Event ):void
		{
			presenter.cleanUp();
		}
		
		//=== Presenter Listeners ===
		private function _onColorChanged( value:Number ):void
		{
			trace( 'UI color changed ' + value );
			label_lbl.textRendererProperties.textFormat = new TextFormat( null, 24, value );
		}
		
		//=== UI Listeners ==
		private function _onRedTouch( event:Event ):void
		{
			presenter.changeColor( 0xFF0000 );
		}
		
		private function _onGreenTouch( event:Event ):void
		{
			presenter.changeColor( 0x00FF00 );
		}
		
		private function _onBlueTouch( event:Event ):void
		{
			presenter.changeColor( 0x0000FF );
		}
		
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}