////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package
{
	import com.realeyes.whichAisle.views.MainView;
	
	import flash.display.Sprite;
	
	public class DesktopApplication extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var mainView:MainView;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function DesktopApplication()
		{
			super();
			_initApp();
		}
		
		private function _initApp():void
		{
			mainView = new MainView();
			addChild( mainView );
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