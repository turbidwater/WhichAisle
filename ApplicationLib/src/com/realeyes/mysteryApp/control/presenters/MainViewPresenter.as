////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.mysteryApp.control.presenters
{
	import org.osflash.signals.Signal;

	public class MainViewPresenter
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var colorChangedSignal:Signal = new Signal();
		
		private var _color:Number = 0x00FF00;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MainViewPresenter()
		{
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function changeColor( value:Number ):void
		{
			color = value;
		}
		
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------
		public function get color():Number
		{
			return _color;
		}
		public function set color( value:Number ):void
		{
			_color = value;
			colorChangedSignal.dispatch( _color );
		}
	}
}