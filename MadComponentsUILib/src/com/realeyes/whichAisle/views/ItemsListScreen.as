////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIButton;
	import com.danielfreeman.madcomponents.UIDividedList;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UILabel;
	import com.danielfreeman.madcomponents.UIList;
	import com.realeyes.whichAisle.control.presenters.ItemListScreenPresenter;
	import com.realeyes.whichAisle.model.constants.Screens;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ItemsListScreen extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static var layoutXML:XML =	<vertical id={ Screens.ITEMS_LIST }>
												<list id="item_list"></list>
												<label id="empty_lbl" alignH="centre" alignV="top">There are no items.</label>
												<button id="delete_btn" alignH="fill" alignV="bottom" >Delete Crossed Out Items</button>
											</vertical>;
		
		public var presenter:ItemListScreenPresenter;
		public var view:UIForm;
		
		public var item_list:UIList;
		public var empty_lbl:UILabel;
		public var delete_btn:UIButton;
		
		private var _dataProvider:Vector.<ItemVO>;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemsListScreen( view:UIForm=null )
		{
			super();
			
			this.view = view;
			presenter = new ItemListScreenPresenter();
		}
		
		public function initialize():void
		{
			item_list = UIList( view.getChildByName( "item_list" ) );
			empty_lbl = UILabel( view.getChildByName( "empty_lbl" ) );
			delete_btn = UIButton( view.getChildByName( "delete_btn" ) );
		}
		
		private function _initListeners():void
		{
			presenter.dataProviderChanged.add( _onDataProviderChanged );
			dataProvider = presenter.dataProvider;
			
			view.addEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
		}
				
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		private function _generateListXML( dp:Vector.<ItemVO> ):XML
		{
			var xmlString:String = '<data>';
			
			var currentStore:String = '';
			var len:int = dp.length;
			for( var i:int = 0; i < len; i++ )
			{
				var item:ItemVO = dp[ i ];
				
				//If a different store, start a new group block
				if( item.store.name != currentStore )
				{
					if( currentStore != '' ) xmlString += '</group>';
					currentStore = item.store.name;
					xmlString += '<group label="' + currentStore + '">'; 
				}
				
				//Add in the item
				xmlString += '<item label="' + item.name + '" />';
			}
			
			//Close any open group
			if( currentStore != '' ) xmlString += '</group>';
			
			//Close the data block
			xmlString += '</data>';
			
			//Return the xml
			var listXML:XML = new XML( xmlString );
			return listXML;
		}
		
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
			
			delete_btn.clickable = !on;
			
			view.doLayout();
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onAddedToStage( event:Event ):void
		{
			view.addEventListener( Event.REMOVED_FROM_STAGE, _onRemovedFromStage );
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
			
			if( value && value.length )
			{
				item_list.xmlData = _generateListXML( value );
				_toggleEmptyState( false );
			}
			else
			{
				_toggleEmptyState( true );
			}
		}
	}
}