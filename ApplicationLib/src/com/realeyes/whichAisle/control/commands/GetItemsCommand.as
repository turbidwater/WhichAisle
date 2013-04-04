////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.commands
{
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	import com.realeyes.whichAisle.model.vos.requests.GetItemsRequest;
	import com.realeyes.whichAisle.service.ServiceManager;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	
	public class GetItemsCommand implements ICommand, IResponder
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var request:GetItemsRequest;
		public var serviceManager:ServiceManager;
		public var applicationModel:ApplicationModel;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function GetItemsCommand()
		{
			serviceManager = ServiceManager.getInstance();
			applicationModel = ApplicationModel.getInstance();
		}
		
		public function execute(data:Object=null):void
		{
			if( data is GetItemsRequest )
			{
				request = data as GetItemsRequest;
				serviceManager.getItems( this, request );
			}
		}
		
		public function result(data:Object):void
		{
			var result:SQLResult = SQLResult( data );
			var items:Vector.<ItemVO> = new Vector.<ItemVO>();
			
			if( result.data )
			{
				//Loop through the data to populate items
			}
			
			applicationModel.items = items;
		}
		
		public function fault(info:Object):void
		{
			var error:SQLError = info as SQLError;
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}