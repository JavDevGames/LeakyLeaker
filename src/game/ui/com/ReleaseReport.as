package game.ui.com 
{
	import flash.display.Bitmap;
	import flash.system.ImageDecodingPolicy;
	import game.definitions.Releases;
	import game.ui.LeakObject;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import utils.GlobalData;
	import utils.PopUpManager;
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
		
		private var mReleaseIdx:int;
		private var mReportCallback:Function;
		private var mTriggerNotification:Boolean;
		private var mStartArrowCallback:Function;
		private var mEndArrowCallback:Function;
		
		public function ReleaseReport() 
		{
			mCurReportMax = 500;
			mCurLeakVal = 0;
			mReleaseIdx = 0;
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
			
			mTriggerNotification = false;
		}
		
		private function ReleaseClicked(e:Event):void 
		{
			mReportCallback(-mCurReportMax);
			
			mCurReportMax = Math.round(Math.pow(mCurReportMax, 1.15));
			mCurLeakVal = 0;
			mLeakBar.UpdateBounds(mCurReportMax, 0);
			
			//and trigger a release!
			var modIdx:int = mReleaseIdx % Releases.pRumorList.length;
			var messageTitle:String = Releases.pRumorList[modIdx][0];
			var messageBody:String = Releases.pRumorList[modIdx][1];
			
			messageBody += "\n(http://bit.ly/25SgIU2)";
			
			mReleaseIdx++;
			
			mEndArrowCallback();
			
			GlobalData.GetInstance().pPopUpManager.AddPopUp(ReleasePopUp, { title:messageTitle, body:messageBody} );
		}
		
		override public function Update(deltaTime:Number):void
		{
			var curVal:Number = GlobalData.GetInstance().pPlayerProfile.pTotalLeaks;
			
			//disable/enable it
			var enable:Boolean = curVal >= mCurReportMax;
			mReleaseButton.enabled = enable;
			
			if (mTriggerNotification && enable)
			{
				mStartArrowCallback(mReleaseButton.x + mReleaseButton.width + 100,
									mReleaseButton.y + 25,
									mReleaseButton.x + mReleaseButton.width + 50,
									mReleaseButton.y + 25);
									
				mTriggerNotification = false;
			}
			
			
			if (curVal != mCurLeakVal)
			{
				var diff:Number = curVal - mCurLeakVal;
				mLeakBar.Add(diff);
				
				mCurLeakVal = curVal;
			}
		}
		
		public function RegisterCallbacks(reportCallback:Function, startArrowCallback:Function, endArrowCallback:Function):void
		{
			mReportCallback = reportCallback;
			mStartArrowCallback = startArrowCallback;
			mEndArrowCallback = endArrowCallback;
			mTriggerNotification = true;
		}
		
	}

}