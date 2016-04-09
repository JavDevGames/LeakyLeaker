package game.ui.com 
{
	import flash.geom.Point;
	import flash.system.ImageDecodingPolicy;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Javier
	 */
	public class ProgressBar extends LeakObject 
	{
		private var mFront:Image;
		private var mBack:Image;
		private var mProgress:Image;
		private var mMax:Number;
		private var mCurValue:Number;
		private var HELPER_POINT:Point;
		
		public function ProgressBar(frontTex:Texture, backTex:Texture, progressTex:Texture, max:Number, curValue:Number) 
		{
			mFront = new Image(frontTex);
			mBack = new Image(backTex);
			mProgress = new Image(progressTex);
			mMax = max;
			mCurValue = curValue;
			HELPER_POINT = new Point();
			
			addChild(mBack);
			addChild(mProgress);
			addChild(mFront);
		}
		
		public function Add(val:Number):void
		{
			SetProgress(mCurValue + val);
		}
		
		public function SetProgress(val:Number):void
		{
			var percent:Number = (val / mMax);
			percent = (percent < 0) ? 0 : percent;
			percent = (percent > 1) ? 1 : percent;
			
			HELPER_POINT.x = percent;
			HELPER_POINT.y = 0;
			
			mProgress.setTexCoords(1, HELPER_POINT);
			
			HELPER_POINT.x = percent;
			HELPER_POINT.y = 1;
			
			mProgress.setTexCoords(3, HELPER_POINT);
			
			HELPER_POINT.x = mBack.width * percent;
			HELPER_POINT.y = 0;
			mProgress.setVertexPosition(1, HELPER_POINT);
			
			HELPER_POINT.x = mBack.width * percent;
			HELPER_POINT.y = mBack.height;
			mProgress.setVertexPosition(3, HELPER_POINT);
			
			mCurValue = val;
		}
		
		public function UpdateBounds(max:Number, cur:Number):void
		{
			mMax = max;
			mCurValue = cur;
			Add(0);
		}
	}

}