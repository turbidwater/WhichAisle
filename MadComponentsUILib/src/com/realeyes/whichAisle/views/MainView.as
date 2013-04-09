////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIButton;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UILabel;
	import com.danielfreeman.madcomponents.UINavigation;
	import com.realeyes.whichAisle.control.navigation.NavigationManager;
	import com.realeyes.whichAisle.control.presenters.MainViewPresenter;
	import com.realeyes.whichAisle.control.signals.InitApplicationSignal;
	import com.realeyes.whichAisle.control.signals.NavigationSignal;
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.constants.Screens;
	import com.realeyes.whichAisle.model.vos.requests.NavigationRequest;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	[SWF( width="480", height="800")]
	public class MainView extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var presenter:MainViewPresenter;
		
		public const layoutXML:XML = 	<navigation id="nav" title="Title">
											{TitleScreen.layoutXML}
											{ItemsListScreen.layoutXML}
										</navigation>;
		
		public var titleScreen:TitleScreen;
		public var itemsListScreen:ItemsListScreen;
		public var uiNavigation:UINavigation;
									
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MainView()
		{
			super();
			
			presenter = new MainViewPresenter();
			
			addEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
		}
		
		private function _init():void
		{
			_initLayout();
			_initListeners();
			
			//Kick off the application start
			new InitApplicationSignal().dispatch();
		}
		
		private function _onAddedToStage( event:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
			_init();
		}
		
		private function _initLayout():void
		{
			
			UI.create( this, layoutXML );
			
			titleScreen = new TitleScreen( UIForm( UI.findViewById( Screens.TITLE_SCREEN ) ) );
			itemsListScreen = new ItemsListScreen( UIForm( UI.findViewById( Screens.ITEMS_LIST ) ) );
			
			uiNavigation = UINavigation( UI.findViewById( "nav" ) );
			uiNavigation.autoBack = uiNavigation.autoForward = false;
			
			presenter.registerNavigation( new NavigationManager( uiNavigation ) );
			
			titleScreen.initialize();
			itemsListScreen.initialize();
			
		}
		
		private function _initListeners():void
		{
			//Presenter listeners
			
			//UI Listeners
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		//=== Presenter Listeners ===
		
		//=== UI Listeners ==

		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}