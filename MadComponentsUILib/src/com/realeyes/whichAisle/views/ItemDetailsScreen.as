////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIButton;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UIInput;
	import com.danielfreeman.madcomponents.UINavigation;
	import com.danielfreeman.madcomponents.UINavigationBar;
	import com.danielfreeman.madcomponents.UIPicker;
	import com.danielfreeman.madcomponents.UISwitch;
	import com.realeyes.whichAisle.control.presenters.ItemDetailsScreenPresenter;
	import com.realeyes.whichAisle.events.MadPresenterEvent;
	import com.realeyes.whichAisle.model.constants.Screens;
	import com.realeyes.whichAisle.model.vos.ItemVO;
	import com.realeyes.whichAisle.model.vos.StoreVO;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ItemDetailsScreen extends BaseMadScreen
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static var layoutXML:XML =	<vertical id={ Screens.ADD_ITEM }>
												<label id="name_lbl">Name</label>
												<input id="name_ti" halign="fill"></input>
												<label id="store_lbl">Store</label>
												<picker id="store_pr">
													<data>
														<item label="Sprouts"/>
														<item label="King Soopers"/>
														<item label="Safeway"/>
													</data>
												</picker>
												<label id="aisle_lbl">Aisle</label>
												<input id="aisle_ti" halign="fill"></input>
												<label id="notes_lbl">Notes</label>
												<input id="notes_ti" halign="fill"></input>
												<horizontal id="staple_h">
													<label id="staple_lbl">Staple?</label>
													<switch id="staple_sw">YES,NO</switch>
												</horizontal>
												<button id="add_btn" halign="fill">Add</button>
											</vertical>;
		
		public var name_ti:UIInput;
		public var store_pr:UIPicker;
		public var aisle_ti:UIInput;
		public var notes_ti:UIInput;
		public var staple_sw:UISwitch;
		public var add_btn:UIButton;
		
		private var _dataProvider:ItemVO;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemDetailsScreen( view:UIForm=null )
		{
			super( view );
		}
		
		override public function initialize():void
		{
			if( !initialized )
			{
				name_ti = UIInput( view.findViewById( "name_ti" ) );
				
				navBar = UINavigation( UI.findViewById( 'nav' ) ).navigationBar;
				
				_initListeners();
				
			}
		}
		
		private function _initListeners():void
		{
			add_btn.addEventListener( UIButton.CLICKED, _onAddClicked );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		//=== Navigation Events ===
		override protected function onSetup( event:MadPresenterEvent ):void
		{
			super.onSetup( event );
			
			navBar.backButton.text = 'Cancel';
			navBar.backButton.visible = true;
			navBar.backButton.addEventListener( MouseEvent.CLICK, _onBackClicked );
		}
		
		override protected function onCleanup( event:MadPresenterEvent ):void
		{
			super.onCleanup( event );
			
			navBar.backButton.text = '';
			navBar.backButton.visible = false;
			navBar.backButton.removeEventListener( MouseEvent.CLICK, _onBackClicked );
		}
		
		private function _onAddClicked( event:Event ):void
		{
			var itemVO:ItemVO;
			if( dataProvider )
			{
				itemVO = dataProvider;
				itemVO.name = name_ti.text;
				itemVO.notes = notes_ti.text;
			}
			else
			{
				itemVO = new ItemVO( 0, name_ti.text, notes_ti.text );
			}
			
			itemVO.aisle = aisle_ti.text;
			itemVO.staple = staple_sw.state;
			itemVO.store = new StoreVO( 0, store_pr.data[ store_pr.index ] );
			
			presenter.submitItem( itemVO );
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get presenter():ItemDetailsScreenPresenter
		{
			return _presenter as ItemDetailsScreenPresenter;
		}
		public function set presenter( value:ItemDetailsScreenPresenter ):void
		{
			_presenter = value;
		}

		public function get dataProvider():ItemVO
		{
			return _dataProvider;
		}

		public function set dataProvider( value:ItemVO ):void
		{
			_dataProvider = value;
		}

	}
}