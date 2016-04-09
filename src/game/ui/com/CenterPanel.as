package game.ui.com 
{
	import flash.display.Bitmap;
	import game.ui.LeakObject;
	/**
	 * ...
	 * @author Javier
	 */
	public class CenterPanel extends LeakObject
	{
		
		
		private var mTotalPurchases:int;
		private var mPurchases:Vector.<WorkerHolder>;
		private var mPendingUpdates:Number;
		private var mUpdateLeaks:Function;
		
		public function CenterPanel() 
		{
			mTotalPurchases = 0;
			mPendingUpdates = 0;
			mPurchases = new Vector.<WorkerHolder>;
		}
		
		private function Init():void
		{
			
		}
		
		public function AddPurchase(type:int, cost:Number):void
		{
			var i:int;
			
			var purchase:WorkerHolder;
			for (i = 0; i < mPurchases.length; ++i)
			{
				if (mPurchases[i].pType == type)
				{
					purchase = mPurchases[i];
					break;
				}
			}
			
			if (purchase)
			{
				purchase.AddWorkers(1);
			}
			else
			{			
				var newHolder:WorkerHolder = new WorkerHolder(type, 1, HandleUpdate);
				mPurchases.push(newHolder);
				
				var posX:Number = 392
				var posY:Number = 66+(mTotalPurchases * 108);
				
				newHolder.x = posX;
				newHolder.y = posY;
				
				addChild(newHolder);
				
				mTotalPurchases++;
			}
			
			//update the leaks left
			mUpdateLeaks(-cost);
		}
		
		private function HandleUpdate(newLeaks:Number):void 
		{
			mPendingUpdates += newLeaks;
		}
		
		override public function Update(deltaTime:Number):void
		{
			var i:int;
			
			if (!mTotalPurchases)
			{
				return;
			}
			
			for (i = 0; i < mPurchases.length; ++i)
			{
				mPurchases[i].Update(deltaTime);
			}
			
			ExecuteNewLeaks();
		}
		
		public function RegisterUpdateCallback(updateFunc:Function):void 
		{
			mUpdateLeaks = updateFunc;
		}
		
		private function ExecuteNewLeaks():void
		{
			mUpdateLeaks(mPendingUpdates);
			mPendingUpdates = 0;
		}
	}

}