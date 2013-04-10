////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.model.vos
{
	import feathers.core.FeathersControl;
	
	import org.osflash.signals.Signal;

	public class ItemListItemVO
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var itemVO:ItemVO;
		public var accessory:FeathersControl;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemListItemVO( itemVO:ItemVO, accessory:FeathersControl=null )
		{
			this.itemVO = itemVO;
			this.accessory = accessory;
		}
		
		
		//-----------------------------------------------------------
		//  GETTER/SETTERS
		//-----------------------------------------------------------
		public function get itemName():String
		{
			return itemVO.name;
		}
		
		public function get aisleName():String
		{
			return itemVO.aisle.name;
		}
		
		public function get crossedOutChangedSignal():Signal
		{
			return itemVO.crossedOutChanged;
		}
	}
}