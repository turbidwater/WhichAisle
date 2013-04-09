////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.realeyes.whichAisle.ExtendedTheme;
	import com.realeyes.whichAisle.control.presenters.TitleScreenPresenter;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.events.FeathersEventType;
	
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class TitleScreen extends Screen
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		[Embed(source="/images/logo_realeyesmedia.png")]
		public var logo:Class;
		
		public var title_lbl:Label;
		public var logo_img:ImageLoader;
		
		public var presenter:TitleScreenPresenter;
		public var clickedSignal:Signal;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function TitleScreen()
		{
			super();
			
			presenter = new TitleScreenPresenter();
			clickedSignal = new Signal();
			_initLayout();
			_initListeners();
		}
		
		private function _initLayout():void
		{
			title_lbl = new Label();
			title_lbl.text = "Which Aisle?";
			title_lbl.nameList.add( ExtendedTheme.TITLE_SCREEN_LABEL );
			addChild( title_lbl );
			
			logo_img = new ImageLoader();
			logo_img.addEventListener( FeathersEventType.RESIZE, _onLogoResized );
			logo_img.source = Texture.fromBitmap( new logo() );
			addChild( logo_img );
			
		}
		
		private function _initListeners():void
		{
			addEventListener( TouchEvent.TOUCH, _onTouch );
			
			addEventListener( Event.REMOVED_FROM_STAGE, _onRemoved );
			if( stage )
			{
				_onAdded( null );
			}
			else
			{
				addEventListener( Event.ADDED_TO_STAGE, _onAdded );
			}
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		override protected function draw():void
		{
			super.draw();
			
			title_lbl.y = height/3;
			title_lbl.width = width;
			
			logo_img.y = (height/3) * 2;
			logo_img.x = width/2 - logo_img.width/2;
		}
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onAdded( event:Event ):void
		{
			presenter.setup();
			this.removeEventListener( Event.ADDED_TO_STAGE, _onAdded );
		}
		
		private function _onRemoved( event:Event ):void
		{
			presenter.cleanup();
			this.removeEventListener( Event.REMOVED_FROM_STAGE, _onRemoved );
		}
		
		private function _onTouch( event:TouchEvent ):void
		{
			event.stopImmediatePropagation();
			var touch:Touch = event.getTouch( this, TouchPhase.ENDED );
			if( touch )
			{
				presenter.goToItemsList();
			}
		}
		
		private function _onLogoResized( event:Event ):void
		{
			draw();
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}