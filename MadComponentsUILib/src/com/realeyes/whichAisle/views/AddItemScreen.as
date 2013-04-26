////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UIGroupedList;
	import com.danielfreeman.madcomponents.UIList;
	import com.danielfreeman.madcomponents.UINavigation;
	import com.danielfreeman.madcomponents.UINavigationBar;
	import com.realeyes.whichAisle.control.presenters.AddItemScreenPresenter;
	import com.realeyes.whichAisle.events.MadPresenterEvent;
	import com.realeyes.whichAisle.model.constants.Screens;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class AddItemScreen extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static var layoutXML:XML =	<vertical id={ Screens.ADD_ITEM }>
												<groupedList id="options_list" alignH="fill" alignV="top"></groupedList>
											</vertical>;
		
		public var presenter:AddItemScreenPresenter;
		public var view:UIForm;
		public var navBar:UINavigationBar;
		
		public var options_list:UIGroupedList;
		
		private var _initialized:Boolean;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function AddItemScreen( view:UIForm=null )
		{
			super();
			
			this.view = view;
			view.addEventListener( UIForm.LOADED, _onLoaded );
			view.addEventListener( MadPresenterEvent.SETUP, _onSetup );
			view.addEventListener( MadPresenterEvent.CLEANUP, _onCleanup );
			
			presenter = new AddItemScreenPresenter();
		}
		
		public function initialize():void
		{
			if( !_initialized )
			{
				options_list = UIGroupedList( view.findViewById( "options_list" ) );
				options_list.longClickEnabled = false;
				options_list.xmlData = _generateListXML( presenter.dataProvider );
				
				navBar = UINavigation( UI.findViewById( 'nav' ) ).navigationBar;
				
				_initListeners();
				
				_initialized = true;
			}
		}
		
		private function _initListeners():void
		{
			options_list.addEventListener( UIList.CLICKED, _onOptionClicked );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		private function _generateListXML( value:Vector.<String> ):XML
		{
			var string:String = '<data><group>';
			var len:int = value.length;
			for( var i:int = 0; i < len; i++ )
			{
				string += '<item label="' + value[i] + '" />';
			}
			string += '</group></data>';
			
			var xml:XML = new XML( string );
			return xml;
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		//=== Nav Events ===
		private function _onLoaded( event:Event ):void
		{
			_initialized = false;
			_onSetup( null );
		}
		
		private function _onSetup( event:Event ):void
		{
			initialize();
			
			navBar.backButton.text = 'Cancel';
			navBar.backButton.visible = true;
			navBar.backButton.addEventListener( MouseEvent.CLICK, _onBackClicked );
		}
		
		private function _onCleanup( event:MadPresenterEvent ):void
		{
			navBar.backButton.text = '';
			navBar.backButton.visible = false;
			navBar.backButton.removeEventListener( MouseEvent.CLICK, _onBackClicked );
		}
		
		//=== UI Events ===
		private function _onBackClicked( event:MouseEvent ):void
		{
			presenter.goToItemsList();
		}
		
		private function _onOptionClicked( event:Event ):void
		{
			var key:String = presenter.dataProvider[ options_list.index ];
			if( key == AddItemScreenPresenter.ADD_STAPLE )
			{
				presenter.goToStaplesList();
			}
			else if( key == AddItemScreenPresenter.NEW_ITEM )
			{
				presenter.goToItemDetails();
			}
		}
	}
}