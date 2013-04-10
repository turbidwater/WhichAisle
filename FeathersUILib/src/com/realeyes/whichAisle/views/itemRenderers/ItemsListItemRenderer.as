////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views.itemRenderers
{
	import com.realeyes.whichAisle.ExtendedTheme;
	import com.realeyes.whichAisle.events.LongPressListEvent;
	import com.realeyes.whichAisle.model.vos.ItemListItemVO;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	import com.realeyes.whichAisle.utils.LongPressListener;
	
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.IGroupedListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class ItemsListItemRenderer extends DefaultGroupedListItemRenderer implements IGroupedListItemRenderer
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var itemVO:ItemVO;
		public var strikethrough:Image;
		
		[Embed(source="/images/strikethrough.png")]
		public var strikethrough_bmp:Class;
		
		private var _longPress:LongPressListener;
		private var _longPressDetected:Boolean;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemsListItemRenderer()
		{
			super();
			
			_initLongPressListener();
			_initStrikethrough();
		}
		
		private function _initLongPressListener():void
		{
			_longPress = new LongPressListener( this );
			_longPress.addEventListener( LongPressListener.LONG_PRESS, _onLongPress );
		}
		
		private function _initStrikethrough():void
		{
			var texture:Texture = Texture.fromBitmap( new strikethrough_bmp() );
			strikethrough = new Image( texture );
			strikethrough.visible = false;
			addChild( strikethrough );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		override protected function draw():void
		{
			super.draw();
			
			strikethrough.width = width - 30;
			strikethrough.x = 20;
			strikethrough.y = height / 2 - strikethrough.height / 2;
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		override protected function owner_scrollHandler( event:Event ):void
		{
			super.owner_scrollHandler( event );
			_longPress.cancel();
		}
		
		private function _onCrossedOutChanged( value:Boolean ):void
		{
			strikethrough.visible = value;
		}
		
		private function _onLongPress( event:Event ):void
		{
			dispatchEvent( new LongPressListEvent( LongPressListEvent.LONG_PRESS_LIST_ITEM, itemVO, true ) );
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------
		override public function set data( value:Object ):void
		{
			if( itemVO ) itemVO.crossedOutChanged.remove( _onCrossedOutChanged );
			
			super.data = value;
			
			var itemListItemVO:ItemListItemVO = value as ItemListItemVO;
			if( itemListItemVO )
			{
				itemVO = itemListItemVO.itemVO;
				itemVO.crossedOutChanged.add( _onCrossedOutChanged );
				_onCrossedOutChanged( itemVO.crossedOut );
			}
		}
	}
}