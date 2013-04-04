////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.signals
{
	import com.realeyes.whichAisle.control.commands.GetItemsCommand;
	
	import org.osflash.signals.Signal;
	
	public class GetItemsSignal extends Signal
	{
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function GetItemsSignal(...parameters)
		{
			super(parameters);
			
			addOnce( new GetItemsCommand().execute );
		}
	}
}