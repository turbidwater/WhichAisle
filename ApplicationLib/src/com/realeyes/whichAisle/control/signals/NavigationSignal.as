////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.signals
{
	import com.realeyes.whichAisle.control.commands.NavigationCommand;
	
	import org.osflash.signals.Signal;
	
	public class NavigationSignal extends Signal
	{
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function NavigationSignal(...parameters)
		{
			super(parameters);
			
			//Ugly but efficient. Allows for refactoring later if a real command/signal map is used
			addOnce( new NavigationCommand().execute );
		}
	}
}