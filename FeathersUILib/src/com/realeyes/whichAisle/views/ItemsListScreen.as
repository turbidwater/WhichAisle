////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.realeyes.whichAisle.ExtendedTheme;
	import com.realeyes.whichAisle.control.presenters.ItemsListScreenPresenter;
	import com.realeyes.whichAisle.events.LongPressListEvent;
	import com.realeyes.whichAisle.model.vos.ItemListItemVO;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	import com.realeyes.whichAisle.utils.LongPressListener;
	import com.realeyes.whichAisle.views.itemRenderers.ItemsListItemRenderer;
	
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.HierarchicalCollection;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flashx.textLayout.formats.TextAlign;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class ItemsListScreen extends Screen
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var presenter:ItemsListScreenPresenter;
		
		public var header:Header;
		public var item_list:GroupedList;
		public var empty_lbl:Label;
		public var delete_btn:Button;
		
		[Embed(source="/images/strikethrough.png", mimeType="image/png")]
		public var strikethrough:Class;
		
		private var _dataProvider:Vector.<ItemVO>;
		private var _longPressDetected:Boolean;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemsListScreen()
		{
			super();
			
			presenter = new ItemsListScreenPresenter();
			
			_initLayout();
			_initListeners();
		}
		
		private function _initLayout():void
		{
			header = new Header();
			header.title = presenter.screenTitle;
			addChild( header );
			
			empty_lbl = new Label();
			empty_lbl.nameList.add( ExtendedTheme.NO_RESULTS_LABEL );
			empty_lbl.text = "There are no items.";
			addChild( empty_lbl );
			
			delete_btn = new Button();
			delete_btn.label = "Delete Crossed Out Items";
			addChild( delete_btn );

			item_list = new GroupedList();
			item_list.typicalItem = { itemName:'Item Name' };
			item_list.typicalHeader = 'Header';
			item_list.itemRendererProperties.labelField = 'itemName';
			item_list.itemRendererType = ItemsListItemRenderer;
			item_list.isSelectable = true;
		}
		
		private function _initListeners():void
		{
			presenter.dataProviderChanged.add( _onDataProviderChanged );
			presenter.screenTitleChanged.add( _onScreenTitleChanged );
			dataProvider = presenter.dataProvider;
			
			addEventListener( Event.ADDED_TO_STAGE, _onAddedToStage );
			
			delete_btn.addEventListener( TouchEvent.TOUCH, _onDeleteTouch );
			item_list.addEventListener( Event.CHANGE, _onListChange );
			item_list.addEventListener( LongPressListEvent.LONG_PRESS_LIST_ITEM, _onListLongPress );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		override protected function draw():void
		{
			super.draw();
			
			header.width = this.actualWidth;
			header.validate();
			
			delete_btn.width = stage.stageWidth;
			delete_btn.y = this.height - delete_btn.height;
			
			empty_lbl.width = stage.stageWidth;
			empty_lbl.y = this.height / 3;
			
			item_list.width = stage.stageWidth;
			item_list.height = stage.stageHeight - delete_btn.height - header.height;
			item_list.y = header.height;
		}
		
		private function _generateCollection( vector:Vector.<ItemVO> ):HierarchicalCollection
		{
			var len:int = dataProvider.length;
			var genericCollection:Array = [];
			var currentStore:String;
			var currentNode:Object;
			for( var i:int = 0; i < len; i++ )
			{
				var item:ItemVO = dataProvider[ i ];
				if( item.store.name != currentStore )
				{
					if( currentNode ) genericCollection.push( currentNode );
					currentStore = item.store.name;
					currentNode = { header:currentStore, children:[] };
				}
				
				var data:ItemListItemVO = new ItemListItemVO( item );
				data.accessory = _generateAisleLabelAccessory( data.aisleName );
				currentNode.children.push( data );
			}
			
			if( currentNode ) genericCollection.push( currentNode );
			
			return new HierarchicalCollection( genericCollection );
		}
		
		private function _generateAisleLabelAccessory( aisleName:String ):Label
		{
			var aisle_lbl:Label = new Label();
			aisle_lbl.nameList.add( ExtendedTheme.ITEM_LIST_AISLE_LABEL );
			aisle_lbl.text = aisleName;
			
			return aisle_lbl;
		}
		
		private function _generateStrikethrough():Image
		{
			var texture:Texture = Texture.fromBitmap( new strikethrough() );
			var strikethrough:Image = new Image( texture );
			strikethrough.width = item_list.width - 10;
			strikethrough.x = 5;
			
			return strikethrough;
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
		
		private function _onScreenTitleChanged( value:String ):void
		{
			header.title = value;
		}
		
		private function _onDeleteTouch( event:TouchEvent ):void
		{
			var touch:Touch = event.touches[0];
			if( touch.phase == TouchPhase.ENDED )
			{
				trace( delete_btn.width );
			}
		}
		
		private function _onListChange( event:Event ):void
		{
			if( _longPressDetected )
			{
				_longPressDetected = false;
			}
			else
			{
				var item:ItemVO = ItemListItemVO( item_list.selectedItem ).itemVO;
				presenter.toggleItem( item );
			}
		}
		
		private function _onListLongPress( event:LongPressListEvent ):void
		{
			_longPressDetected = true;
			event.stopImmediatePropagation();
			presenter.getDetailsForItem( event.item );
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
			
			if( value ) item_list.dataProvider = _generateCollection( _dataProvider );
			_toggleEmptyState( !( value && value.length ) );
		}
	}
}