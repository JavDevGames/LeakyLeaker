package game.ui.com 
{
	/**
	 * ...
	 * @author Javier
	 */
	public class Store extends LeakObject
	{
		private var mList:Vector.<ShopRenderers>;
		private var mPurchaseCallback:Function;
		
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
		}
		
		public function RegisterPurchaseCallback(func:Function):void
		{
			mPurchaseCallback = func;
		}
		
		private function PurchaseClick(type:int):void 
		{
			mPurchaseCallback(type);
		}
	}

}