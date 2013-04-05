////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.navigation
{
	/**
	 * This class is meant to be extended to accommodate the different implementations of
	 * navigation management from the different UI frameworks. It is not meant to be used
	 * on its own.
	 */
	public class NavigationManagerBase
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		private var _currentScreen:String;
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function navigateToScreen( screenID:String ):void
		{
			_currentScreen = screenID;
		}


		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get currentScreen():String
		{
			return _currentScreen;
		}
	}
}