////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2013 RealEyes Media LLC.
//
////////////////////////////////////////////////////////////////////////////////
package com.realeyes.whichAisle.views
{
	import com.danielfreeman.madcomponents.UI;
	import com.danielfreeman.madcomponents.UIForm;
	import com.danielfreeman.madcomponents.UIImage;
	import com.danielfreeman.madcomponents.UILabel;
	import com.realeyes.whichAisle.control.presenters.TitleScreenPresenter;
	import com.realeyes.whichAisle.events.MadPresenterEvent;
	import com.realeyes.whichAisle.model.constants.Screens;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;
	
	public class TitleScreen extends Sprite
	{
		//-----------------------------------------------------------
		//  DECLARATIONS
		//-----------------------------------------------------------
		public static var layoutXML:XML =	<vertical id={ Screens.TITLE_SCREEN }>
												<image>100,100</image>
												<rows>
													<vertical height="30%">
														<label id="title_lbl" alignH="centre" ><font color="#FFFFFF" size="30">Which Aisle?</font></label>
													</vertical>
													<vertical height="50%">
														<image id="logo_img" alignH="centre"></image>
													</vertical>
												</rows>
											</vertical>;
		
		public var presenter:TitleScreenPresenter;
		public var view:UIForm;
		
		public var title_lbl:UILabel;
		public var logo_img:UIImage;
		
		[Embed(source="images/logo_realeyesmedia.png")]
		public var logo:Class;
		
		private var _initialized:Boolean;
		
		
		//-----------------------------------------------------------
		//  INIT
		//-----------------------------------------------------------
		public function TitleScreen( view:UIForm=null )
		{
			super();
			
			presenter = new TitleScreenPresenter();

			this.view = view;
			view.addEventListener( UIForm.LOADED, _onLoaded );
			view.addEventListener( MadPresenterEvent.SETUP, _onSetup );
			view.addEventListener( MadPresenterEvent.CLEANUP, _onCleanup );
		}
		
		public function initialize():void
		{
			if( !_initialized )
			{
				presenter.setup();
				
				title_lbl = UILabel( view.findViewById( "title_lbl" ) );
				title_lbl.defaultTextFormat = new TextFormat( null, 30, 0xFFFFFF );
				logo_img = UIImage( view.findViewById( 'logo_img' ) );
				logo_img.imageClass = logo;
				
				view.addEventListener( MouseEvent.CLICK, _onClicked );
				
				_initialized = true;
			}
		}
		
		
		//-----------------------------------------------------------
		//  CONTROL
		//-----------------------------------------------------------
		
		
		//-----------------------------------------------------------
		//  EVENT LISTENERS
		//-----------------------------------------------------------
		private function _onLoaded( event:Event ):void
		{
			_initialized = false;
			_onSetup( null );
		}
		
		private function _onSetup( event:MadPresenterEvent ):void
		{
			initialize();
		}
		
		private function _onCleanup( event:MadPresenterEvent ):void
		{
			presenter.cleanup();
		}
		
		private function _onClicked( event:MouseEvent ):void
		{
			event.stopImmediatePropagation();
			presenter.goToItemsList();
			presenter.cleanup();
		}
		
		
		//-----------------------------------------------------------
		//  GETTERS/SETTERS
		//-----------------------------------------------------------	
	}
}