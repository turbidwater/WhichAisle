////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.mysteryApp.views
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIButton;
	import com.danielfreeman.madcomponents.UILabel;
	import com.realeyes.mysteryApp.control.presenters.MainViewPresenter;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	[SWF( width="480", height="800")]
	public class MainView extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var presenter:MainViewPresenter;
		
		public var red_btn:UIButton;
		public var green_btn:UIButton;
		public var blue_btn:UIButton;
		public var label_lbl:UILabel;
		
		public var layoutXML:XML =	<vertical>
										<horizontal>
											<button id="red_btn">Red</button>
											<button id="green_btn">Green</button>
											<button id="blue_btn">Blue</button>
										</horizontal>
										<label id="label_lbl">This is a MADComponents App</label>
									</vertical>;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MainView()
		{
			super();
			
			presenter = new MainViewPresenter();
			
			addEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
		}
		
		private function _init():void
		{
			_initLayout();
			_initListeners();
		}
		
		private function _onAddedToStage( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
			_init();
		}
		
		private function _initLayout():void
		{
			UI.create( this, layoutXML );
			
			red_btn = UIButton( UI.findViewById( "red_btn" ) );
			green_btn = UIButton( UI.findViewById( "green_btn" ) );
			blue_btn = UIButton( UI.findViewById( "blue_btn" ) );
			
			label_lbl = UILabel( UI.findViewById( "label_lbl" ) );
			
		}
		
		private function _initListeners():void
		{
			//Presenter listeners
			presenter.colorChangedSignal.add( _onColorChanged );
			
			//UI Listeners
			red_btn.addEventListener( UIButton.CLICKED, _onRedClick );
			green_btn.addEventListener( UIButton.CLICKED, _onGreenClick );
			blue_btn.addEventListener( UIButton.CLICKED, _onBlueClick );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		//=== Presenter Listeners ===
		private function _onColorChanged( value:Number ):void
		{
			trace( 'UI color changed ' + value );
			label_lbl.textColor = value;
		}
		
		//=== UI Listeners ==
		private function _onRedClick( event:Event ):void
		{
			presenter.changeColor( 0xFF0000 );
		}
		
		private function _onGreenClick( event:Event ):void
		{
			presenter.changeColor( 0x00FF00 );
		}
		
		private function _onBlueClick( event:Event ):void
		{
			presenter.changeColor( 0x0000FF );
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}