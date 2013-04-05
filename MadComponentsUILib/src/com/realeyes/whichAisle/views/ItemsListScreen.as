////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UILabel;
	import com.realeyes.whichAisle.model.constants.Screens;
	
	import flash.display.Sprite;
	
	public class ItemsListScreen extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static var layoutXML:XML =	<vertical id={ Screens.ITEMS_LIST }>
												<label id="title_lbl">Items List</label>
											</vertical>;
		
		
		public var view:UIForm;
		public var title_lbl:UILabel;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function ItemsListScreen( view:UIForm=null )
		{
			super();
			
			this.view = view;
		}
		
		public function initialize():void
		{
			title_lbl = UILabel( view.getChildByName( "title_lbl" ) );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}