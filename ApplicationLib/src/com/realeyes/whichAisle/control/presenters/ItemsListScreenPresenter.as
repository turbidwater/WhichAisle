////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.presenters
{
	import com.realeyes.whichAisle.control.signals.NavigationSignal;
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.constants.ScreenTitles;
	import com.realeyes.whichAisle.model.constants.Screens;
	import com.realeyes.whichAisle.model.vos.AisleVO;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	import com.realeyes.whichAisle.model.vos.StoreVO;
	import com.realeyes.whichAisle.model.vos.requests.NavigationRequest;
	
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
			applicationModel.currentScreenTitleChanged.add( _onScreenTitleChanged );
			
			//Init values
			_onItemsChanged( applicationModel.items );
			_onScreenTitleChanged( applicationModel.currentScreenTitle );
		}
		
		public function cleanup():void
		{
			dataProviderChanged.removeAll();
			
			applicationModel.itemsChanged.remove( _onItemsChanged );
		}
		
		public function goToStoreList():void
		{
			trace( 'Go to stores!' );
			//new NavigationSignal().dispatch( new NavigationRequest( Screens.STORES_LIST, ScreenTitles.STORES_LIST ) );
		}
		
		public function goToAddItem():void
		{
			new NavigationSignal().dispatch( new NavigationRequest( Screens.ADD_ITEM, ScreenTitles.ADD_ITEM, false ) );
		}
		
		public function deleteCheckedItems():void
		{
			var deletedItems:Vector.<ItemVO> = new Vector.<ItemVO>();
			var len:int = dataProvider.length;
			for( var i:int = len-1; i >= 0; i-- )
			{
				var itemVO:ItemVO = dataProvider[i];
				if( itemVO.crossedOut )
				{
					deletedItems.push( itemVO );
					dataProvider.splice( i, 1 );
				}
			}
			
			//TODO: make data call here ###
			
			dataProviderChanged.dispatch( dataProvider );
		}
		
		public function getDetailsForItem( item:ItemVO ):void
		{
			trace( 'Get details for ' + item.name );
		}
		
		public function toggleItem( item:ItemVO ):void
		{
			item.crossedOut = !item.crossedOut;
			trace( item.name + ' crossed out ' + item.crossedOut );
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onItemsChanged( value:Vector.<ItemVO> ):void
		{
			/**/
			var item1:ItemVO = new ItemVO( 1, 'Lettuce' );
			item1.store = new StoreVO( 1, 'Sprouts', 0xFF0000 );
			item1.aisle = new AisleVO( 1, 'Produce' );
			var item2:ItemVO = new ItemVO( 2, 'Bananas' );
			item2.store = new StoreVO( 1, 'Sprouts', 0xFF0000 );
			item2.aisle = new AisleVO( 1, "Produce" );
			var item3:ItemVO = new ItemVO( 3, 'Jasmine Rice' );
			item3.store = new StoreVO( 2, 'King Soopers', 0xFF00FF );
			item3.aisle = new AisleVO( 2, "Rice and Beans" );
			value = new <ItemVO>[ item1, item2, item3 ];
			
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