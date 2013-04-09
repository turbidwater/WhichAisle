////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.navigation
{
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UINavigation;
	import com.danielfreeman.madcomponents.UIPages;
	import com.realeyes.whichAisle.events.MadPresenterEvent;
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.constants.Screens;
	
	import flash.display.Sprite;

	public class NavigationManager extends NavigationManagerBase
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static var screens:Vector.<String> = new <String>[ 	Screens.TITLE_SCREEN, 
																	Screens.ITEMS_LIST,
																	Screens.STORES_LIST,
																	Screens.ADD_ITEM,
																	Screens.ITEM_DETAILS,
																	Screens.STORE_DETAILS,
																	Screens.AISLE_DETAILS,
																	Screens.STAPLES_LIST ];
		
		private var _navigation:UINavigation;
		private var _currentScreenIndex:int = 0;
		private var _applicationModel:ApplicationModel;
		private var _currentPage:UIForm;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function NavigationManager( navigation:UINavigation )
		{
			super();
			
			_navigation = navigation;
			_applicationModel = ApplicationModel.getInstance();
			_applicationModel.currentScreenTitleChange.add( _onScreenTitleChanged );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		override public function navigateToScreen( screenID:String ):void
		{
			super.navigateToScreen( screenID );
			
			if( _currentPage ) _currentPage.dispatchEvent( new MadPresenterEvent( MadPresenterEvent.CLEANUP ) ); 
			
			var screenIndex:int = getIndexForScreen( screenID );
			var dir:String = UIPages.SLIDE_LEFT;
			if( screenIndex < _currentScreenIndex ) dir = UIPages.SLIDE_RIGHT;
			
			_currentScreenIndex = screenIndex;
			_navigation.goToPage( screenIndex, dir );
			
			//Trigger the presenter for the current page. Our original pages get wrapped in another page, so 
			//we have to dig them out
			_currentPage = UIForm( _navigation.pages[ _currentScreenIndex ] ).findViewById( screenID ) as UIForm;
			_currentPage.dispatchEvent( new MadPresenterEvent( MadPresenterEvent.SETUP ) );
		}
		
		public function getIndexForScreen( screenID:String ):int
		{
			var index:int = screens.indexOf( screenID );
			
			return index;
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onScreenTitleChanged( value:String ):void
		{
			_navigation.navigationBar.text = value;
			_navigation.navigationBar.alpha = int(value != "");
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}