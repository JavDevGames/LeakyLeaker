package game.ui.com 
{
	import game.ui.LeakObject;
	import starling.text.TextField;
	import utils.GlobalData;
	/**
	 * ...
	 * @author Javier
	 */
	public class TotalLeaks extends LeakObject
	{
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
			mLeaksText = new TextField(379, 35, mTotalLeaks + " total leaks");
			mLeaksText.x = 7;
			mLeaksText.y = 64;
			addChild(mLeaksText);
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
				mLeaksText.text = int(mTotalLeaks) + " total leaks";
				mDirty = false;
				
				GlobalData.GetInstance().pPlayerProfile.pTotalLeaks = mTotalLeaks;
			}
			
		}
		
	}

}