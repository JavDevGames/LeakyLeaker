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
		
		private var mStartArrow:Function;
		private var mTriggerNotification:Boolean;
		private var mEndArrow:Function;
		
		public function Clicker() 
		{
			InitAssets();
		}
		
		private function InitAssets():void
		{
			var bmp:Bitmap = new mButtonAsset();
			var upTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			var effect:GlowFilter = new GlowFilter(0xa0a0a0, 1, 6, 6, 8, 1, true);
			bmp.bitmapData.applyFilter(bmp.bitmapData, new Rectangle(0,0, bmp.bitmapData.width, bmp.bitmapData.height), new Point(0,0), effect);
			var downTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			mButton = new Button(upTex, "");
			mButton.x = 115;
			mButton.y = 188;
			addChild(mButton);
			mButton.addEventListener(Event.TRIGGERED, HandleTriggered);
			
			mTriggerNotification = true;
		}
		
		public function RegisterClickCallback(func:Function, startArrow:Function, endArrow:Function):void
		{
			mClickFunc = func;
			mStartArrow = startArrow;
			mEndArrow = endArrow;
			
			mStartArrow(mButton.x + 250, mButton.y + 250, mButton.x + 200, mButton.y + 200);
		}
		
		private function HandleTriggered(e:Event):void 
		{
			var newLeaks:int = 1;
			
			if (mTriggerNotification)
			{
				mEndArrow();
				mTriggerNotification = false;
			}
			
			
			mClickFunc(newLeaks);
		}
	}

}