package game.ui.com 
{
	import flash.display.BitmapData;
	import game.ui.LeakObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import utils.GlobalData;
	/**
	 * ...
	 * @author Javier
	 */
	public class TotalLeaks extends LeakObject
	{
		private var mBg:Sprite;
		private var mTotalLeaks:Number;
		private var mLeaksText:TextField;
		private var mDirty:Boolean;
		
		public function TotalLeaks() 
		{
			mTotalLeaks = 0;
			mDirty = false;
			
			Init();
		}
		
		private function Init():void
		{
			var bmp:BitmapData = new BitmapData(16, 16, true, 0x99000000);
			var bgTex:Texture = Texture.fromBitmapData(bmp);
			
			var bgImage:Image = new Image(bgTex);
			bgImage.width = 386;
			bgImage.height = 80;
			mBg = new Sprite();
			mBg.y = 58;
			addChild(mBg);
			
			mLeaksText = new TextField(380, 35, mTotalLeaks + " total bytes hacked", "verdana", 22, 0xffffff);
			mLeaksText.x = 7;
			mLeaksText.y = 8;
			
			mBg.addChild(bgImage);
			mBg.addChild(mLeaksText);
		}
		
		public function UpdateLeaks(newLeaks:Number):void
		{
			if (isNaN(newLeaks))
			{
				newLeaks = 1;
			}
			
			mTotalLeaks += newLeaks;
			mTotalLeaks = (mTotalLeaks < 0) ? 0 : mTotalLeaks;
			
			mDirty = true;
		}
		
		
		override public function Update(deltaTime:Number):void
		{
			if (mDirty)
			{
				mLeaksText.text = int(mTotalLeaks) + " total bytes hacked";
				mDirty = false;
				
				GlobalData.GetInstance().pPlayerProfile.pTotalLeaks = mTotalLeaks;
			}
			
		}
		
	}

}