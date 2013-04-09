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
	import com.danielfreeman.madcomponents.UIPages;
	import com.realeyes.whichAisle.control.presenters.ItemsListScreenPresenter;
	import com.realeyes.whichAisle.events.MadPresenterEvent;
	import com.realeyes.whichAisle.model.constants.Screens;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ItemsListScreen extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static const EMPTY_STATE:int = 0;
		public static const LIST_STATE:int = 1;
		
		public static var layoutXML:XML =	<vertical id={ Screens.ITEMS_LIST }>
												<pages id="pageStates">
													<vertical id="emptyState">
														<label id="empty_lbl" alignH="centre" alignV="top"><font color="#FFFFFF">There are no items.</font></label>
													</vertical>
													<vertical id="listState">
														<list id="item_list"></list>
													</vertical>
												</pages>
												<button id="delete_btn" alignH="fill" alignV="bottom" >Delete Crossed Out Items</button>
											</vertical>;
		
		
		public var presenter:ItemsListScreenPresenter;
		public var view:UIForm;
		
		public var pageStates:UIPages;
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
			presenter = new ItemsListScreenPresenter();
		}
		
		public function initialize():void
		{
			pageStates = UIPages( view.findViewById( "pageStates" ) );
			item_list = UIList( view.findViewById( "item_list" ) );
			empty_lbl = UILabel( view.findViewById( "empty_lbl" ) );
			delete_btn = UIButton( view.findViewById( "delete_btn" ) );
			
			_initListeners();
		}
		
		private function _initListeners():void
		{
			presenter.dataProviderChanged.add( _onDataProviderChanged );
			dataProvider = presenter.dataProvider;
			
			view.addEventListener( MadPresenterEvent.SETUP, _onSetup );
			view.addEventListener( MadPresenterEvent.CLEANUP, _onCleanup );
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
			if( pageStates )
			{
				if( on )
				{
					pageStates.goToPage( EMPTY_STATE );
				}
				else
				{
					pageStates.goToPage( LIST_STATE );
				}
				
				delete_btn.mouseEnabled = delete_btn.clickable = !on;
				
				view.doLayout();
			}
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onSetup( event:MadPresenterEvent ):void
		{
			presenter.setup();
		}
		
		private function _onCleanup( event:MadPresenterEvent ):void
		{
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