////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.model.vos.requests
{
	public class NavigationRequest
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var screenID:String;
		public var makeDataCall:Boolean;
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function NavigationRequest( screenID:String, makeDataCall:Boolean=true )
		{
			this.screenID = screenID;
			this.makeDataCall = makeDataCall;
		}
	}
}