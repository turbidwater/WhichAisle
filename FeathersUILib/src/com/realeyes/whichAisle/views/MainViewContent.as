////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.realeyes.whichAisle.ExtendedTheme;
	import com.realeyes.whichAisle.control.navigation.NavigationManager;
	import com.realeyes.whichAisle.control.presenters.MainViewPresenter;
	import com.realeyes.whichAisle.control.signals.InitApplicationSignal;
	import com.realeyes.whichAisle.control.signals.NavigationSignal;
	import com.realeyes.whichAisle.model.constants.Screens;
	import com.realeyes.whichAisle.model.vos.requests.NavigationRequest;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScrollContainer;
	import feathers.layout.AnchorLayout;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;
	
	import flash.text.TextFormat;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class MainViewContent extends Screen
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var presenter:MainViewPresenter;
		
		protected var container:ScrollContainer;
		protected var navigator:ScreenNavigator;
		protected var transitions:ScreenSlidingStackTransitionManager;
		protected var theme:MetalWorksMobileTheme;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MainViewContent()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, _onRemovedFromStage );
		}
		
		private function _init():void
		{
			presenter = new MainViewPresenter();
			theme = new ExtendedTheme();
			
			//Init screen navigator to handle app navigation
			navigator = new ScreenNavigator();
			presenter.registerNavigation( new NavigationManager( navigator ) );
			
			//Add screens to the navigator
			_initLayout();
			
			//Listen for events from presenter and UI
			_initListeners();
			
			//Init transitions manager
			transitions = new ScreenSlidingStackTransitionManager( navigator );
			transitions.duration = 0.4;
			
			//Init scroll container that wraps app
			/* removing this for now as it causes issues on orientation change
			container = new ScrollContainer();
			container.layout = new AnchorLayout();
			container.clipContent = true;
			container.horizontalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			container.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_OFF;
			container.width = stage.stageWidth;
			container.height = stage.stageHeight;
			*/
			addChild( navigator );
			
			//Display the UI, starting with the title screen
			//container.addChild( navigator );
			navigator.showScreen( Screens.TITLE_SCREEN );
			
			//Kick off the application start
			new InitApplicationSignal().dispatch();
		}
		
		private function _initLayout():void
		{
			var titleNavItem:ScreenNavigatorItem = new ScreenNavigatorItem(	TitleScreen,
																			{}, 
																			{} );
			navigator.addScreen( Screens.TITLE_SCREEN, titleNavItem );
			
			var itemListNavItem:ScreenNavigatorItem = new ScreenNavigatorItem(	ItemsListScreen,
																				{}, 
																				{} );
			navigator.addScreen( Screens.ITEMS_LIST, itemListNavItem );
			
			var addItemNavItem:ScreenNavigatorItem = new ScreenNavigatorItem(	AddItemScreen,
																		{}, 
																		{} );
			navigator.addScreen( Screens.ADD_ITEM, addItemNavItem );
																					
		}
		
		private function _initListeners():void
		{
			
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------

		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onAddedToStage( event:Event ):void
		{
			_init();
		}
		
		private function _onRemovedFromStage( event:Event ):void
		{
			presenter.cleanup();
		}
		
		
		//=== Presenter Listeners ===

		
		//=== UI Listeners ==
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}