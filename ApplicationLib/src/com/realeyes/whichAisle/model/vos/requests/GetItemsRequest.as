////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.model.vos.requests
{
	public class GetItemsRequest
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var storeID:int;
		public var staple:Boolean;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function GetItemsRequest( storeID:int=0, staple:Boolean=false )
		{
			this.storeID = storeID;
			this.staple = staple;
		}
	}
}