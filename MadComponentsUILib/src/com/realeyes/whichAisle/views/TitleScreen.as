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
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class TitleScreen extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public var title_lbl:UILabel;
		
		public var clickedSignal:Signal;
		
		public static var layoutXML:XML =	<vertical id={ Screens.TITLE_SCREEN }>
												<label id="title_lbl" alignH="center">Which Aisle?</label>
											</vertical>;
		
		public var view:UIForm;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function TitleScreen( view:UIForm=null )
		{
			super();
			
			clickedSignal = new Signal();
			this.view = view;
		}
		
		public function initialize():void
		{
			//UI.create( this, layoutXML );
			
			title_lbl = UILabel( view.getChildByName( "title_lbl" ) );
			
			view.addEventListener( MouseEvent.CLICK, _onClicked );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onClicked( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			clickedSignal.dispatch();
		}
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}