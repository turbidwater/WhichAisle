////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.control.presenters
{
	import com.realeyes.whichAisle.control.navigation.NavigationManagerBase;
	import com.realeyes.whichAisle.model.ApplicationModel;
	import com.realeyes.whichAisle.model.constants.ScreenTitles;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	
	import org.osflash.signals.Signal;

	public class MainViewPresenter implements IPresenter
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var applicationModel:ApplicationModel;
		
		public var itemsChangedSignal:Signal;
		
		private var _items:Vector.<ItemVO>;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function MainViewPresenter()
		{
			_init();
		}
		
		private function _init():void
		{
			applicationModel = ApplicationModel.getInstance();
			itemsChangedSignal = new Signal();
			
			setup();
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function setup():void
		{
			applicationModel.currentScreenTitle = ScreenTitles.TITLE_SCREEN;
			applicationModel.itemsChanged.add( _onItemsChanged );
		}
		
		public function cleanup():void
		{
			applicationModel.itemsChanged.remove( _onItemsChanged );
		}
		
		public function registerNavigation( navigationManager:NavigationManagerBase ):void
		{
			applicationModel.navigationManager = navigationManager;
		}

		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onItemsChanged( value:Vector.<ItemVO> ):void
		{
			items = value;
			trace( 'I got my items and there are ' + value.length + ' of them' );
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------
		public function get items():Vector.<ItemVO>
		{
			return _items;
		}
		public function set items( value:Vector.<ItemVO> ):void
		{
			_items = value;
			itemsChangedSignal.dispatch( value );
		}
	}
}