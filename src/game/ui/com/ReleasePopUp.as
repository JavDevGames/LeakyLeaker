package game.ui.com 
{
	import flash.display.Bitmap;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import utils.GlobalData;
	/**
	 * ...
	 * @author Javier
	 */
	public class ReleasePopUp extends LeakPopUp 
	{
		[Embed(source = "../../../../assets/release_popup_bg.png")]
		private var popup_bg:Class;
		
		[Embed(source = "../../../../assets/popup_button.png")]
		private var popup_button:Class;
		
		private var mBackground:Sprite;
		private var mCloseButton:Button;
		private var mLeakTitle:TextField;
		private var mLeakBody:TextField;
		
		public function ReleasePopUp() 
		{

		}
		
		override public function Init(params:Object):void
		{
			var bmp:Bitmap = new popup_bg();
			var bgTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			mBackground = new Sprite();
			
			var bgImage:Image = new Image(bgTex);
			mBackground.addChild(bgImage);
			
			bmp = new popup_button();
			var upTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			mCloseButton = new Button(upTex, "Close");
			
			mLeakTitle = new TextField(300, 80, params.title, "Verdana", 25);
			mLeakBody = new TextField(300, 120, params.body, "Verdana", 20);
			
			mLeakTitle.x = mBackground.width / 2 - mLeakTitle.width / 2;
			
			mLeakBody.x = mBackground.width / 2 - mLeakBody.width / 2;
			mLeakBody.y = mLeakTitle.y + mLeakTitle.height + 10;
			
			mCloseButton.x = mBackground.width / 2 - mCloseButton.width / 2;
			mCloseButton.y = mLeakBody.y + mLeakBody.height + 10;
			
			addChild(mBackground);
			
			mBackground.addChild(mLeakTitle);
			mBackground.addChild(mLeakBody);			
			mBackground.addChild(mCloseButton);
			
			mBackground.x = Starling.current.viewPort.width / 2 - mBackground.width / 2;
			mBackground.y = Starling.current.viewPort.height / 2 - mBackground.height / 2;
			
			mCloseButton.addEventListener(Event.TRIGGERED, HandleCloseButton);
		}
		
		private function HandleCloseButton(e:Event):void 
		{
			GlobalData.GetInstance().pPopUpManager.RemovePopUp(this);
		}
	}

}