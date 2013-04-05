////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.navigation
{
	import feathers.controls.ScreenNavigator;

	public class NavigationManager extends NavigationManagerBase
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var navigator:ScreenNavigator;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function NavigationManager( navigator:ScreenNavigator )
		{
			super();
			
			this.navigator = navigator;
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		override public function navigateToScreen( screenID:String ):void
		{
			super.navigateToScreen( screenID );
			
			navigator.showScreen( screenID );
		}
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}