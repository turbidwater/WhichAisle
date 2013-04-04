////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.commands
{
	import com.realeyes.whichAisle.control.signals.GetItemsSignal;
	import com.realeyes.whichAisle.model.vos.requests.GetItemsRequest;
	import com.realeyes.whichAisle.service.ServiceManager;
	
	import flash.data.SQLConnection;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	public class InitApplicationCommand implements ICommand, IResponder
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var serviceManager:ServiceManager;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function InitApplicationCommand()
		{
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function execute( data:Object=null ):void
		{
			serviceManager = ServiceManager.getInstance();
			if( !serviceManager.dbInitialized )
			{
				serviceManager.dbInitializedSignal.add( _onDBInitialized );
			}
			else
			{
				_onDBInitialized( true );
			}
		}
		
		public function result( data:Object ):void
		{
			
		}
		
		public function fault( info:Object ):void
		{
			
		}
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onDBInitialized( value:Boolean ):void
		{
			if( value )
			{
				serviceManager.dbInitializedSignal.remove( _onDBInitialized );
				new GetItemsSignal().dispatch( new GetItemsRequest() );
			}
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}