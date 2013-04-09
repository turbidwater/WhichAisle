////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.presenters
{
	import com.realeyes.whichAisle.control.signals.NavigationSignal;
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.constants.ScreenTitles;
	import com.realeyes.whichAisle.model.constants.Screens;
	import com.realeyes.whichAisle.model.vos.requests.NavigationRequest;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class TitleScreenPresenter
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var applicationModel:ApplicationModel;
		
		private var _timer:Timer;
		private var _delay:int = 5000;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function TitleScreenPresenter()
		{
			applicationModel = ApplicationModel.getInstance();
		}
		
		public function setup():void
		{
			_timer = new Timer( _delay, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, _onDelayComplete );
			//_timer.start();
			
			applicationModel.currentScreenTitle = ScreenTitles.TITLE_SCREEN;
		}
		
		public function cleanup():void
		{
			_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, _onDelayComplete );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function goToItemsList():void
		{
			if( applicationModel.items )
			{
				new NavigationSignal().dispatch( new NavigationRequest( Screens.ITEMS_LIST, ScreenTitles.ITEMS_LIST, false ) );
				cleanup();
			}
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onDelayComplete( event:TimerEvent ):void
		{
			goToItemsList();
		}
	}
}