////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.realeyes.whichAisle.ExtendedTheme;
	import com.realeyes.whichAisle.control.presenters.AddItemScreenPresenter;
	
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class AddItemScreen extends Screen
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public const OPTIONS_MARGIN:Number = 20;
		
		public var presenter:AddItemScreenPresenter;
		
		public var header:Header;
		public var cancel_btn:Button;
		public var options_bg:ButtonGroup;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function AddItemScreen()
		{
			super();
			
			presenter = new AddItemScreenPresenter();
			
			_initLayout();
			_initListeners();
		}
		
		private function _initLayout():void
		{
			header = new Header();
			header.title = presenter.screenTitle;
			addChild( header );
			
			cancel_btn = new Button();
			cancel_btn.nameList.add( Button.ALTERNATE_NAME_BACK_BUTTON );
			cancel_btn.label = 'Cancel';
			header.leftItems = new <DisplayObject>[ cancel_btn ];
			
			options_bg = new ButtonGroup();
			options_bg.dataProvider = _generateCollection( presenter.dataProvider );
			addChild( options_bg );
		}
		
		private function _initListeners():void
		{
			options_bg.addEventListener( Event.CHANGE, _onOptionSelect );
			cancel_btn.addEventListener( Event.TRIGGERED, _onCancelClicked );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		override protected function draw():void
		{
			header.width = this.actualWidth;
			header.validate();
			
			options_bg.width = width - OPTIONS_MARGIN * 2;
			options_bg.x = OPTIONS_MARGIN;
			options_bg.y = header.y + header.height + OPTIONS_MARGIN;
		}
		
		private function _generateCollection( value:Vector.<String> ):ListCollection
		{
			var lc:ListCollection = new ListCollection();
			var len:int = value.length;
			for( var i:int = 0; i < len; i++ )
			{
				lc.push( { label:value[i], triggered:_onOptionSelect } );
			}
			
			return lc;
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onOptionSelect( event:Event ):void
		{
			var button:Button = Button( event.target );
			if( button.label == AddItemScreenPresenter.ADD_STAPLE )
			{
				presenter.goToStaplesList();
			}
			else if( button.label == AddItemScreenPresenter.NEW_ITEM )
			{
				presenter.goToItemDetails();
			}
		}
		
		private function _onCancelClicked( event:Event ):void
		{
			presenter.goToItemList();
		}
	}
}