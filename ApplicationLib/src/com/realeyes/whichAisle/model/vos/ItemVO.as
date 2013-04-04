////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.model.vos
{
	import org.osflash.signals.Signal;

	public class ItemVO
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var id:int;
		public var name:String;
		public var notes:String;
		
		public var storeChanged:Signal;
		public var aisleChanged:Signal;
		public var stapleChanged:Signal;
		public var crossedOutChanged:Signal;
		
		private var _store:StoreVO;
		private var _aisle:AisleVO;
		private var _staple:Boolean;
		private var _crossedOut:Boolean;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemVO( id:int=0, name:String="", notes:String="" )
		{
			//Signals
			storeChanged = new Signal();
			aisleChanged = new Signal();
			stapleChanged = new Signal();
			crossedOutChanged = new Signal();
			
			this.id = id;
			this.name = name;
			this.notes = notes;
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get store():StoreVO
		{
			return _store;
		}
		public function set store( value:StoreVO ):void
		{
			_store = value;
			
			storeChanged.dispatch( value );
		}
		
		public function get aisle():AisleVO
		{
			return _aisle;
		}
		public function set aisle( value:AisleVO ):void
		{
			_aisle = value;
			
			aisleChanged.dispatch( value );
		}
		
		public function get staple():Boolean
		{
			return _staple;
		}
		public function set staple( value:Boolean ):void
		{
			_staple = value;
			
			stapleChanged.dispatch( value );
		}
		
		public function get crossedOut():Boolean
		{
			return _crossedOut;
		}
		public function set crossedOut( value:Boolean ):void
		{
			_crossedOut = value;
			
			crossedOutChanged.dispatch( value );
		}

	}
}