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
		public var currentScreenTitleChange:Signal;
		
		private static var _instance:ApplicationModel;
		
		private var _items:Vector.<ItemVO>;
		private var _stores:Vector.<StoreVO>;
		private var _currentScreenTitle:String;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ApplicationModel( sentry:SingletonSentry )
		{
			//Signals
			itemsChanged = new Signal();
			storesChanged = new Signal();
			currentScreenTitleChange = new Signal();
			
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
			
			currentScreenTitleChange.dispatch( value );
		}
	}
}

class SingletonSentry{}