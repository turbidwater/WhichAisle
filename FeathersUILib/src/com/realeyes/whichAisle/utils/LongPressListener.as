////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class LongPressListener extends EventDispatcher
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static const LONG_PRESS:String = 'longPress';
		public static const LONG_PRESS_DURATION:int = 2000;
		
		private var _target:Sprite;
		private var _touchTimer:Timer;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function LongPressListener( target:Sprite )
		{
			super();
			
			_touchTimer = new Timer( LONG_PRESS_DURATION, 1 );
			_touchTimer.addEventListener( TimerEvent.TIMER_COMPLETE, _onTouchTimerComplete );
			
			_target = target;
			_target.addEventListener( TouchEvent.TOUCH, _onTouch );
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		public function cancel():void
		{
			_touchTimer.stop();
			_touchTimer.reset();
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onTouch( event:TouchEvent ):void
		{
			//Only handle single presses
			if( event.touches.length == 1 )
			{
				var touch:Touch = event.touches[0];
				if( touch.phase == TouchPhase.BEGAN )
				{
					_touchTimer.start();
				}
				else if( touch.phase == TouchPhase.ENDED && _touchTimer.running )
				{
					cancel();
				}
			}
		}
		
		private function _onTouchTimerComplete( event:TimerEvent ):void
		{
			dispatchEvent( new Event( LONG_PRESS ) );
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}