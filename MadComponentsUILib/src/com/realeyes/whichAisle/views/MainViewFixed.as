////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.danielfreeman.madcomponents.UIButton;
	import com.danielfreeman.madcomponents.UILabel;
	import com.realeyes.whichAisle.control.presenters.MainViewPresenter;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	public class MainViewFixed extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var presenter:MainViewPresenter;
		
		public var red_btn:UIButton;
		public var green_btn:UIButton;
		public var blue_btn:UIButton;
		public var label_lbl:UILabel;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MainViewFixed()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
		}
		
		private function _init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			presenter = new MainViewPresenter();
			
			_initLayout();
			_initListeners();
		}
		
		private function _initLayout():void
		{
			red_btn = new UIButton( this, 15, 15, "Red" );
			red_btn.width = 100;
			red_btn.height = 100;
			addChild( red_btn );
			
			green_btn = new UIButton( this, 130, 15, "Green" );
			green_btn.width = 100;
			green_btn.height = 100;
			addChild( green_btn );
			
			blue_btn = new UIButton( this, 245, 15, "Blue" );
			blue_btn.width = 100;
			blue_btn.height = 100;
			addChild( blue_btn );
			
			var textFormat:TextFormat = new TextFormat( null, 24, presenter.color );
			label_lbl = new UILabel( this, 15, 130, "This is a Mad Components application", textFormat );
			addChild( label_lbl );
		}
		
		private function _initListeners():void
		{
			//Presenter listeners
			presenter.colorChangedSignal.add( _onColorChanged );
			
			//UI Listeners
			red_btn.addEventListener( MouseEvent.CLICK, _onRedTouch );
			green_btn.addEventListener( MouseEvent.CLICK, _onGreenTouch );
			blue_btn.addEventListener( MouseEvent.CLICK, _onBlueTouch );
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
		
		//=== Presenter Listeners ===
		private function _onColorChanged( value:Number ):void
		{
			trace( 'UI color changed ' + value );
			label_lbl.textColor = value;
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