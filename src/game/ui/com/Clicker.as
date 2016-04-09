package game.ui.com 
{
	import flash.display.Bitmap;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.ui.LeakObject;
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Javier
	 */
	public class Clicker extends LeakObject
	{
		[Embed(source = "../../../../assets/hack_button.png")]
		private var mButtonAsset:Class
		private var mButton:Button;
		
		private var mClickFunc:Function;
		
		public function Clicker() 
		{
			InitAssets();
		}
		
		private function InitAssets():void
		{
			var bmp:Bitmap = new mButtonAsset();
			var upTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			var effect:GlowFilter = new GlowFilter(0xff0000, 1, 6, 6, 8, 1, true);
			bmp.bitmapData.applyFilter(bmp.bitmapData, new Rectangle(0,0, bmp.bitmapData.width, bmp.bitmapData.height), new Point(0,0), effect);
			var downTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			mButton = new Button(upTex, "", downTex);
			mButton.x = 115;
			mButton.y = 188;
			addChild(mButton);
			mButton.addEventListener(Event.TRIGGERED, HandleTriggered);
		}
		
		public function RegisterClickCallback(func:Function):void
		{
			mClickFunc = func;
		}
		
		private function HandleTriggered(e:Event):void 
		{
			trace("click");
			var newLeaks:int = 1;
			
			mClickFunc(newLeaks);
		}
		
	}

}