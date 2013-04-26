////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.model
{
	import com.realeyes.whichAisle.control.navigation.NavigationManagerBase;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	import com.realeyes.whichAisle.model.vos.StoreVO;
	
	import org.osflash.signals.Signal;

	public class ApplicationModel
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var navigationManager:NavigationManagerBase;
		
		public var itemsChanged:Signal;
		public var storesChanged:Signal;
		public var currentScreenTitleChanged:Signal;
		public var currentStoreChanged:Signal;
		public var currentItemChanged:Signal;
		
		private static var _instance:ApplicationModel;
		
		private var _items:Vector.<ItemVO>;
		private var _stores:Vector.<StoreVO>;
		private var _currentScreenTitle:String;
		private var _currentStore:StoreVO;
		private var _currentItem:ItemVO;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ApplicationModel( sentry:SingletonSentry )
		{
			//Signals
			itemsChanged = new Signal();
			storesChanged = new Signal();
			currentScreenTitleChanged = new Signal();
			currentStoreChanged = new Signal();
			currentItemChanged = new Signal();
			
			_items = new Vector.<ItemVO>();
			_stores = new Vector.<StoreVO>();
		}
		
		public static function getInstance():ApplicationModel
		{
			if( !_instance )
			{
				_instance = new ApplicationModel( new SingletonSentry() );
			}
			
			return _instance;
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get items():Vector.<ItemVO>
		{
			return _items;
		}
		public function set items( value:Vector.<ItemVO> ):void
		{
			_items = value;
			
			itemsChanged.dispatch( value );
		}
		
		public function get stores():Vector.<StoreVO>
		{
			return _stores;
		}
		public function set stores( value:Vector.<StoreVO> ):void
		{
			_stores = value;
			
			storesChanged.dispatch( value );
		}

		public function get currentScreenTitle():String
		{
			return _currentScreenTitle;
		}
		public function set currentScreenTitle( value:String ):void
		{
			_currentScreenTitle = value;
			
			currentScreenTitleChanged.dispatch( value );
		}

		public function get currentStore():StoreVO
		{
			return _currentStore;
		}
		public function set currentStore( value:StoreVO ):void
		{
			_currentStore = value;
			
			currentStoreChanged.dispatch( value );
		}

		public function get currentItem():ItemVO
		{
			return _currentItem;
		}
		public function set currentItem( value:ItemVO ):void
		{
			_currentItem = value;
			
			currentItemChanged.dispatch( value );
		}


	}
}

class SingletonSentry{}