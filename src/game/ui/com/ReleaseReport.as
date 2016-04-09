package game.ui.com 
{
	import flash.display.Bitmap;
	import flash.system.ImageDecodingPolicy;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import utils.GlobalData;
	/**
	 * ...
	 * @author Javier
	 */
	public class ReleaseReport extends LeakObject
	{
		[Embed(source = "../../../../assets/release_up.png")]
		private var release_up:Class;
		
		[Embed(source = "../../../../assets/release_down.png")]
		private var release_down:Class;
		
		[Embed(source = "../../../../assets/release_disabled.png")]
		private var release_disabled:Class;
		
		[Embed(source = "../../../../assets/progress_back.png")]
		private var progress_back:Class;
		
		
		[Embed(source = "../../../../assets/progress_fill.png")]
		private var progress_fill:Class;
		
		[Embed(source = "../../../../assets/progress_front.png")]
		private var progress_front:Class;
		
		private var mReleaseButton:Button;
		private var mLeakBar:ProgressBar;
		private var mCurReportMax:Number;
		private var mCurLeakVal:Number;
		
		public function ReleaseReport() 
		{
			mCurReportMax = 1000;
			mCurLeakVal = 0;
			Init();
		}
		
		private function Init():void
		{
			var bmp:Bitmap = new release_up();
			var upTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			bmp = new release_down();
			var downTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			bmp = new release_disabled();
			var disableTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			mReleaseButton = new Button(upTex, "Release", downTex, null, disableTex);
			mReleaseButton.x = 96;
			mReleaseButton.y = 607;
			mReleaseButton.addEventListener(Event.TRIGGERED, ReleaseClicked);
			
			addChild(mReleaseButton);
			
			
			bmp = new progress_front();
			var frontTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			bmp = new progress_back();
			var backTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			bmp = new progress_fill();
			var fillTex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			mLeakBar = new ProgressBar(frontTex, backTex, fillTex, mCurReportMax, 0);
			mLeakBar.x = 121;
			mLeakBar.y = 563;
			addChild(mLeakBar);
		}
		
		private function ReleaseClicked(e:Event):void 
		{
			mCurReportMax = Math.round(mCurReportMax * 1.10);
			mCurLeakVal = 0;
			mLeakBar.UpdateBounds(mCurReportMax, 0);
		}
		
		override public function Update(deltaTime:Number):void
		{
			var curVal:Number = GlobalData.GetInstance().pPlayerProfile.pTotalLeaks;
			
			if (curVal != mCurLeakVal)
			{
				var diff:Number = curVal - mCurLeakVal;
				mLeakBar.Add(diff);
				
				mCurLeakVal = curVal;
			}
		}
		
	}

}