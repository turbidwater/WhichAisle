////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UINavigation;
	import com.danielfreeman.madcomponents.UINavigationBar;
	import com.realeyes.whichAisle.control.presenters.IPresenter;
	import com.realeyes.whichAisle.events.MadPresenterEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class BaseMadScreen extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var navBar:UINavigationBar;
		
		protected var initialized:Boolean;
		protected var _presenter:IPresenter;
		
		private var _view:UIForm;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function BaseMadScreen( view:UIForm=null )
		{
			super();
			
			this.view = view;
		}
		
		public function initialize():void
		{
			if( !initialized )
			{
				navBar = UINavigation( UI.findViewById( 'nav' ) ).navigationBar;
				
				initialized = true;
			}
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		protected function onLoaded( event:Event ):void
		{
			initialized = false;
			onSetup( null );
		}
		
		protected function onSetup( event:MadPresenterEvent ):void
		{
			_presenter.setup();
			initialize();
		}
		
		protected function onCleanup( event:MadPresenterEvent ):void
		{
			_presenter.cleanup();
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get view():UIForm
		{
			return _view;
		}
		public function set view( value:UIForm ):void
		{
			if( _view )
			{
				_view.removeEventListener( UIForm.LOADED, onLoaded );
				_view.removeEventListener( MadPresenterEvent.SETUP, onSetup );
				_view.removeEventListener( MadPresenterEvent.CLEANUP, onCleanup );
			}
			
			_view = value;
			
			if( _view )
			{
				_view.addEventListener( UIForm.LOADED, onLoaded );
				_view.addEventListener( MadPresenterEvent.SETUP, onSetup );
				_view.addEventListener( MadPresenterEvent.CLEANUP, onCleanup );
			}
		}

	}
}