package game.ui 
{
	import flash.display.Bitmap;
	import game.ui.com.CenterPanel;
	import game.ui.com.Clicker;
	import game.ui.com.LeakObject;
	import game.ui.com.Store;
	import game.ui.com.TotalLeaks;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Javier
	 */
	public class LeakHolder extends Sprite
	{
		[Embed(source = "../../../assets/game_layout.png")]
		private var debug_layout:Class;
		
		private var mComponents:Vector.<LeakObject>;
		
		private var mClicker:Clicker;
		private var mCenterPanel:CenterPanel;
		private var mStore:Store;
		private var mTotalLeaks:TotalLeaks;
		
		public function LeakHolder() 
		{
			mComponents = new Vector.<LeakObject>();
		}
		
		public function Init():void
		{
			var bmp:Bitmap = new debug_layout();
			var tex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			var img:Image = new Image(tex);
			
			addChild(img);
			
			InitComponents();
		}
		
		private function InitComponents():void
		{
			var i:int;
			
			mClicker = new Clicker();
			mCenterPanel = new CenterPanel();
			mStore = new Store();
			mTotalLeaks = new TotalLeaks();
			
			mComponents.push(mClicker);
			mComponents.push(mCenterPanel);
			mComponents.push(mStore);
			mComponents.push(mTotalLeaks);
			
			for (i = 0; i < mComponents.length; ++i)
			{
				addChild(mComponents[i]);
			}
			
			mClicker.RegisterClickCallback(HandleClickerClick);
			mStore.RegisterPurchaseCallback(HandlePurchase);
			mCenterPanel.RegisterUpdateCallback(HandleWorkerUpdate);
		}
		
		private function HandleWorkerUpdate(newLeaks:Number):void 
		{
			mTotalLeaks.UpdateLeaks(newLeaks);
		}
		
		private function HandlePurchase(type:int, cost:Number):void
		{
			mCenterPanel.AddPurchase(type, cost);
		}
		
		private function HandleClickerClick(newLeaks:int):void 
		{
			mTotalLeaks.UpdateLeaks(newLeaks);
		}
		
		public function Update(deltaTime:Number):void
		{
			var i:int;
			
			for (i = 0; i < mComponents.length; ++i)
			{
				mComponents[i].Update(deltaTime);
			}
		}
		
	}

}