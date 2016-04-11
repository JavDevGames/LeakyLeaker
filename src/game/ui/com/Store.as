package game.ui.com 
{
	import game.ui.LeakObject;
	/**
	 * ...
	 * @author Javier
	 */
	public class Store extends LeakObject
	{
		private var mList:Vector.<ShopRenderers>;
		private var mPurchaseCallback:Function;
		private var mEndArrowCallback:Function;
		private var mStartArrowCallback:Function;
		private var mTriggerNotification:Boolean;
		
		public function Store() 
		{
			mList = new Vector.<ShopRenderers>;
			Init();
		}
		
		
		
		private function Init():void
		{
			var i:int;
			
			var posX:Number = 0;
			var posY:Number = 0;
			for (i = 0; i < 6; ++i)
			{
				mList[i] = new ShopRenderers();
				mList[i].Init(i + 1, PurchaseClick);
				
				posX = 1070;
				posY = 115 + i * 60;
				
				mList[i].x = posX;
				mList[i].y = posY;
				
				addChild(mList[i]);
			}
			
			mTriggerNotification = false;
		}
		
		public function RegisterCallbacks(func:Function, startArrowCallback:Function, endArrowCallback:Function):void
		{
			mPurchaseCallback = func;
			mStartArrowCallback = startArrowCallback;
			mEndArrowCallback = endArrowCallback;
			
			mList[0].SetAsNotificationTrigger(mStartArrowCallback);
		}
		
		private function PurchaseClick(type:int, cost:Number):void 
		{
			mEndArrowCallback();
			
			mPurchaseCallback(type, cost);
		}
		
		override public function Update(deltaTime:Number):void 
		{
			var i:int;
			
			for (i = 0; i < mList.length; ++i)
			{
				mList[i].Update(deltaTime);
			}
		}
	}

}