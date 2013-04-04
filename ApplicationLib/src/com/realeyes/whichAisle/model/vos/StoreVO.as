////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.model.vos
{
	import org.osflash.signals.Signal;

	public class StoreVO
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var id:int;
		public var name:String;
		
		public var colorChanged:Signal;
		public var aislesChanged:Signal;
		
		private var _color:Number;
		private var _aisles:Vector.<AisleVO>;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function StoreVO( id:int=0, name:String='', color:Number=0 )
		{
			//Signals
			colorChanged = new Signal();
			aislesChanged = new Signal();
			
			this.id = id;
			this.name = name;
			this.color = color;
			
			aisles = new Vector.<AisleVO>();
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
			
			colorChanged.dispatch( value );
		}

		public function get aisles():Vector.<AisleVO>
		{
			return _aisles;
		}
		public function set aisles( value:Vector.<AisleVO> ):void
		{
			_aisles = value;
			
			aislesChanged.dispatch( value );
		}


	}
}