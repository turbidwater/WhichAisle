////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.presenters
{
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.constants.ScreenTitles;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	
	import org.osflash.signals.Signal;

	public class ItemListScreenPresenter
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var applicationModel:ApplicationModel;
		
		public var dataProviderChanged:Signal;
		
		private var _dataProvider:Vector.<ItemVO>;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemListScreenPresenter()
		{
			_init();
		}
		
		private function _init():void
		{
			//Signals
			dataProviderChanged = new Signal();
			
			applicationModel = ApplicationModel.getInstance();		
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function setup():void
		{
			applicationModel.currentScreenTitle = ScreenTitles.ITEMS_LIST;
			
			applicationModel.itemsChanged.add( _onItemsChanged );	
			_onItemsChanged( applicationModel.items );
		}
		
		public function cleanup():void
		{
			dataProviderChanged.removeAll();
			
			applicationModel.itemsChanged.remove( _onItemsChanged );
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onItemsChanged( value:Vector.<ItemVO> ):void
		{
			dataProvider = value;
		}

		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get dataProvider():Vector.<ItemVO>
		{
			return _dataProvider;
		}
		public function set dataProvider( value:Vector.<ItemVO> ):void
		{
			_dataProvider = value;
			
			dataProviderChanged.dispatch( value );
		}
	}
}