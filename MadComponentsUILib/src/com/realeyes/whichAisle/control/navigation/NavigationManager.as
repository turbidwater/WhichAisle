////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.navigation
{
	import com.danielfreeman.madcomponents.UIBackButton;
	import com.danielfreeman.madcomponents.UIButton;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UINavigation;
	import com.danielfreeman.madcomponents.UINavigationBar;
	import com.danielfreeman.madcomponents.UIPages;
	import com.realeyes.whichAisle.events.MadPresenterEvent;
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.constants.ScreenTitles;
	import com.realeyes.whichAisle.model.constants.Screens;
	
	import flash.display.Sprite;

	public class NavigationManager extends NavigationManagerBase
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static var screens:Vector.<String> = new <String>[ 	Screens.TITLE_SCREEN, 
																	Screens.ITEMS_LIST,
																	Screens.ADD_ITEM,
																	Screens.STORES_LIST,
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
			_navigation.navigationBar.backButton.text = ''; //Disable the default back button
			_navigation.navigationBar.backButton.visible = false; //Disable the default back button
			_applicationModel = ApplicationModel.getInstance();
			_applicationModel.currentScreenTitleChanged.add( _onScreenTitleChanged );
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
		
		private function _setNavBarState( value:String ):void
		{
			//set the nav bar state based on the title from the constants
			var navBar:UINavigationBar = _navigation.navigationBar;
			navBar.alpha = int( value != ScreenTitles.TITLE_SCREEN );
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onScreenTitleChanged( value:String ):void
		{
			_navigation.navigationBar.text = value;
			
			//Manage nav bar state
			_setNavBarState( value );
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}