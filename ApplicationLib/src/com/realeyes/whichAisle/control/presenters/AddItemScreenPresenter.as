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
	import com.realeyes.whichAisle.model.vos.requests.NavigationRequest;

	public class AddItemScreenPresenter
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static const ADD_STAPLE:String = 'Add Staple';
		public static const NEW_ITEM:String = 'New Item';
		
		public var applicationModel:ApplicationModel;
		
		private var _dataProvider:Vector.<String>;
		private var _screenTitle:String = ScreenTitles.ADD_ITEM;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function AddItemScreenPresenter()
		{
			_init();
		}
		
		private function _init():void
		{
			applicationModel = ApplicationModel.getInstance();
			_dataProvider = new <String>[ ADD_STAPLE, NEW_ITEM ];
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function goToStaplesList():void
		{
			trace( 'add staple' );
			new NavigationSignal().dispatch( new NavigationRequest( Screens.STAPLES_LIST, ScreenTitles.STAPLES_LIST ) );
		}
		
		public function goToItemDetails():void
		{
			trace( 'add new item' );
			new NavigationSignal().dispatch( new NavigationRequest( Screens.ITEM_DETAILS, ScreenTitles.ITEM_DETAILS_ADD ) );
		}
		
		public function goToItemList():void
		{
			var title:String = ScreenTitles.ITEMS_LIST;
			if( applicationModel.currentStore ) title = ScreenTitles.ITEMS_LIST_BY_STORE;
			new NavigationSignal().dispatch( new NavigationRequest( Screens.ITEMS_LIST, title ) );
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get screenTitle():String
		{
			return _screenTitle;
		}
		
		public function get dataProvider():Vector.<String>
		{
			return _dataProvider;
		}
	}
}