////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.model
{
	import com.realeyes.whichAisle.model.vos.ItemVO;
	import com.realeyes.whichAisle.model.vos.StoreVO;
	
	import org.osflash.signals.Signal;

	public class ApplicationModel
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var itemsChanged:Signal;
		public var storesChanged:Signal;
		
		private static var _instance:ApplicationModel;
		
		private var _items:Vector.<ItemVO>;
		private var _stores:Vector.<StoreVO>;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ApplicationModel( sentry:SingletonSentry )
		{
			//Signals
			itemsChanged = new Signal();
			storesChanged = new Signal();
			
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

	}
}

class SingletonSentry{}