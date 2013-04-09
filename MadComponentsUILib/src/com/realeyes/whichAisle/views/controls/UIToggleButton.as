////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views.controls
{
	import com.danielfreeman.madcomponents.UIButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class UIToggleButton extends UIButton
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		private var _selected:Boolean;
		private var _unselectedColour:Number;
		private var _selectedColour:Number = 0xFF9900;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function UIToggleButton(screen:Sprite, xx:Number, yy:Number, text:String, colour:uint=10066346, colours:Vector.<uint>=null, tiny:Boolean=false)
		{
			super(screen, xx, yy, text, colour, colours, tiny);
			
			_unselectedColour = colour;
			
			addEventListener( MouseEvent.CLICK, _onClick );
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onClick( event:MouseEvent ):void
		{
			selected = !selected;
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected( value:Boolean ):void
		{
			_selected = value;
			
			if( value )
			{
				colour = selectedColour;
			}
			else
			{
				colour = unselectedColour;
			}
		}

		public function get selectedColour():Number
		{
			return _selectedColour;
		}
		public function set selectedColour( value:Number ):void
		{
			_selectedColour = value;
		}

		public function get unselectedColour():Number
		{
			return _unselectedColour;
		}
		public function set unselectedColour( value:Number ):void
		{
			_unselectedColour = value;
		}
	}
}