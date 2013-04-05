////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.commands
{
	import com.realeyes.whichAisle.control.navigation.NavigationManagerBase;
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.vos.requests.NavigationRequest;

	public class NavigationCommand implements ICommand
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var applicationModel:ApplicationModel;
		public var navigationManager:NavigationManagerBase;
		public var navRequest:NavigationRequest;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function NavigationCommand()
		{
			applicationModel = ApplicationModel.getInstance();
			navigationManager = applicationModel.navigationManager;
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function execute( data:Object=null ):void
		{
			navRequest = NavigationRequest( data );
			
			if( navRequest.makeDataCall )
			{
				//TODO: handle data requests here
				
			}
			else
			{
				navigationManager.navigateToScreen( navRequest.screenID );
			}
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}