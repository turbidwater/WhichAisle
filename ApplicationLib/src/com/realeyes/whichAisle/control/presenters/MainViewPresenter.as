////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.presenters
{
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	
	import org.osflash.signals.Signal;

	public class MainViewPresenter
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var applicationModel:ApplicationModel;
		
		public var colorChangedSignal:Signal = new Signal();
		
		private var _color:Number = 0x00FF00;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MainViewPresenter()
		{
			_init();
		}
		
		private function _init():void
		{
			applicationModel = ApplicationModel.getInstance();
			
			applicationModel.itemsChanged.add( _onItemsChanged );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function cleanUp():void
		{
			applicationModel.itemsChanged.remove( _onItemsChanged );
		}
		
		public function changeColor( value:Number ):void
		{
			color = value;
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onItemsChanged( value:Vector.<ItemVO> ):void
		{
			trace( 'I got my items and there are ' + value.length + ' of them' );
		}
		
		
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