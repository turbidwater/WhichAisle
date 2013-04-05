////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.commands
{
	import com.realeyes.whichAisle.control.navigation.NavigationManagerBase;
	import com.realeyes.whichAisle.control.signals.GetItemsSignal;
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.constants.Screens;
	import com.realeyes.whichAisle.model.vos.requests.GetItemsRequest;
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
				switch( navRequest.screenID )
				{
					case Screens.ITEMS_LIST:
					{
						applicationModel.itemsChanged.addOnce( _onDataComplete );
						new GetItemsSignal().dispatch( new GetItemsRequest() );
						break;
					}
				}
			}
			else
			{
				navigationManager.navigateToScreen( navRequest.screenID );
			}
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onDataComplete( value:Object ):void
		{
			navigationManager.navigateToScreen( navRequest.screenID );
		}
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}