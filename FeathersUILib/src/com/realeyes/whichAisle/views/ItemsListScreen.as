////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.realeyes.whichAisle.control.presenters.ItemListScreenPresenter;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	
	import starling.events.Event;
	
	public class ItemsListScreen extends Screen
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var presenter:ItemListScreenPresenter;
		
		public var item_list:List;
		public var empty_lbl:Label;
		public var delete_btn:Button;
		
		private var _dataProvider:Vector.<ItemVO>;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemsListScreen()
		{
			super();
			
			presenter = new ItemListScreenPresenter();
			
			_initLayout();
			_initListeners();
		}
		
		private function _initLayout():void
		{
			empty_lbl = new Label();
			empty_lbl.text = "There are no items.";
			addChild( empty_lbl );
			
			delete_btn = new Button();
			delete_btn.label = "Delete Crossed Out Items";
			delete_btn.width = width;
			delete_btn.y = height - delete_btn.height;
			addChild( delete_btn );
		}
		
		private function _initListeners():void
		{
			presenter.dataProviderChanged.add( _onDataProviderChanged );
			dataProvider = presenter.dataProvider;
			
			addEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		private function _toggleEmptyState( on:Boolean ):void
		{
			if( on )
			{
				if( !contains( empty_lbl ) ) addChild( empty_lbl );
				if( contains( item_list ) ) removeChild( item_list );
			}
			else
			{
				if( contains( empty_lbl ) ) removeChild( empty_lbl );
				if( !contains( item_list ) ) addChild( item_list );
			}
			
			delete_btn.isEnabled = !on;
			
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onAddedToStage( event:Event ):void
		{
			addEventListener( Event.REMOVED_FROM_STAGE, _onRemovedFromStage );
			presenter.setup();
		}
		
		private function _onRemovedFromStage( event:Event ):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, _onRemovedFromStage );
			presenter.cleanup();
		}
		
		private function _onDataProviderChanged( value:Vector.<ItemVO> ):void
		{
			dataProvider = value;
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get dataProvider():Vector.<ItemVO>
		{
			return _dataProvider;
		}
		public function set dataProvider( value:Vector.<ItemVO> ):void
		{
			_dataProvider = value;
			
			_toggleEmptyState( !( value && value.length ) );
		}
	}
}