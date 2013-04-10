////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.events
{
	import com.realeyes.whichAisle.model.vos.ItemVO;
	
	import starling.events.Event;
	
	public class LongPressListEvent extends Event
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static const LONG_PRESS_LIST_ITEM:String = 'longPressListItem';
		
		public var item:ItemVO;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function LongPressListEvent(type:String, item:ItemVO, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
			
			this.item = item;
		}
	}
}