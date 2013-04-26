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
	import com.realeyes.whichAisle.model.vos.ItemVO;
	import com.realeyes.whichAisle.model.vos.requests.NavigationRequest;
	
	import org.osflash.signals.Signal;

	public class ItemDetailsScreenPresenter implements IPresenter
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var applicationModel:ApplicationModel;
		public var screentTitle:String = ScreenTitles.ITEM_DETAILS_ADD;
		
		public var dataProviderChanged:Signal;
		
		private var _dataProvider:ItemVO;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemDetailsScreenPresenter()
		{
			applicationModel = ApplicationModel.getInstance();
			dataProviderChanged = new Signal();
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function setup():void
		{
			screentTitle = applicationModel.currentScreenTitle;
			
			applicationModel.currentItemChanged.add( _onCurrentItemChanged );
			_onCurrentItemChanged( applicationModel.currentItem );
		}
		
		public function cleanup():void
		{
			applicationModel.currentItemChanged.remove( _onCurrentItemChanged );
		}
		
		public function submitItem( item:ItemVO ):void
		{
			if( dataProvider )
			{
				//TODO: make update data call here
			}
			else
			{
				//TODO: make add data call here
			}
		}
		
		public function goToAddItem():void
		{
			new NavigationSignal().dispatch( new NavigationRequest( Screens.ADD_ITEM, ScreenTitles.ADD_ITEM, false ) );
		}

		public function goToItemsList():void
		{
			var title:String = ScreenTitles.ITEMS_LIST;
			if( applicationModel.currentStore ) title = ScreenTitles.ITEMS_LIST_BY_STORE;
			new NavigationSignal().dispatch( new NavigationRequest( Screens.ITEMS_LIST, title ) );
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onCurrentItemChanged( value:ItemVO ):void
		{
			dataProvider = value;
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get dataProvider():ItemVO
		{
			return _dataProvider;
		}
		public function set dataProvider( value:ItemVO ):void
		{
			_dataProvider = value;
			
			dataProviderChanged.dispatch( value );
		}
	}
}