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
	import com.realeyes.whichAisle.model.vos.StoreVO;
	
	import org.osflash.signals.Signal;

	public class ItemsListScreenPresenter
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var applicationModel:ApplicationModel;
		
		public var dataProviderChanged:Signal;
		public var screenTitleChanged:Signal;
		
		private var _dataProvider:Vector.<ItemVO>;
		private var _screenTitle:String = ScreenTitles.ITEMS_LIST;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemsListScreenPresenter()
		{
			_init();
		}
		
		private function _init():void
		{
			//Signals
			dataProviderChanged = new Signal();
			screenTitleChanged = new Signal();
			
			applicationModel = ApplicationModel.getInstance();		
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function setup():void
		{
			applicationModel.itemsChanged.add( _onItemsChanged );	
			applicationModel.currentScreenTitleChange.add( _onScreenTitleChanged );
			
			//Init values
			_onItemsChanged( applicationModel.items );
			_onScreenTitleChanged( applicationModel.currentScreenTitle );
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
			/*
			var item:ItemVO = new ItemVO( 1, 'Lettuce' );
			item.store = new StoreVO( 1, 'Sprouts', 0xFF0000 );
			value = new <ItemVO>[ item ];
			*/
			dataProvider = value;
		}
		
		private function _onScreenTitleChanged( value:String ):void
		{
			screenTitle = value;
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

		public function get screenTitle():String
		{
			return _screenTitle;
		}
		public function set screenTitle( value:String ):void
		{
			_screenTitle = value;
			
			screenTitleChanged.dispatch( value );
		}

	}
}