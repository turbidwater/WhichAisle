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
		public var screenTitle:String;
		public var makeDataCall:Boolean;
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function NavigationRequest( screenID:String, screenTitle:String, makeDataCall:Boolean=true )
		{
			this.screenID = screenID;
			this.screenTitle = screenTitle;
			this.makeDataCall = makeDataCall;
		}
	}
}