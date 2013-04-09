////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.events
{
	import flash.events.Event;
	
	public class MadPresenterEvent extends Event
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static const SETUP:String = 'setup';
		public static const CLEANUP:String = 'cleanup';
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MadPresenterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		override public function clone():Event
		{
			return new MadPresenterEvent( type, bubbles, cancelable );
		}
	}
}