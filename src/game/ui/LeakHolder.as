package game.ui 
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import game.ui.com.CenterPanel;
	import game.ui.com.Clicker;
	import game.ui.com.NoticeArrow;
	import game.ui.effects.HackNumberSpawner;
	import game.ui.effects.MatrixRain;
	import game.ui.LeakObject;
	import game.ui.com.ReleaseReport;
	import game.ui.com.Store;
	import game.ui.com.TotalLeaks;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import utils.GlobalData;
	/**
	 * ...
	 * @author Javier
	 */
	public class LeakHolder extends Sprite
	{
		private var mComponents:Vector.<LeakObject>;
		
		private var mClicker:Clicker;
		private var mCenterPanel:CenterPanel;
		private var mStore:Store;
		private var mTotalLeaks:TotalLeaks;
		private var mReleaseReport:ReleaseReport;
		private var mNumberSpawner:HackNumberSpawner;
		private var mMatrixRain:MatrixRain;
		private var mArrow:NoticeArrow;
		
		public function LeakHolder() 
		{
			mComponents = new Vector.<LeakObject>();
		}
		
		public function Init():void
		{
			InitEffects();
			InitUI();
			InitComponents();
		}
		
		private function InitComponents():void 
		{
			var i:int;
			
			for (i = 0; i < mComponents.length; ++i)
			{
				addChild(mComponents[i]);
			}
		}
		
		private function InitEffects():void
		{
			mNumberSpawner = new HackNumberSpawner();
			mMatrixRain = new MatrixRain();
			
			mComponents.push(mMatrixRain);
			mComponents.push(mNumberSpawner);
		}
		
		private function InitUI():void
		{
			var i:int;
			
			mClicker = new Clicker();
			mCenterPanel = new CenterPanel();
			mStore = new Store();
			mTotalLeaks = new TotalLeaks();
			mReleaseReport = new ReleaseReport();
			mArrow = new NoticeArrow();
			
			
			mComponents.push(mClicker);
			mComponents.push(mCenterPanel);
			mComponents.push(mStore);
			mComponents.push(mTotalLeaks);
			mComponents.push(mReleaseReport);
			mComponents.push(mArrow);
			
			mClicker.RegisterClickCallback(HandleClickerClick, SetArrowAnimation, EndArrowAnimation);
			mStore.RegisterCallbacks(HandlePurchase, SetArrowAnimation, EndArrowAnimation);
			mCenterPanel.RegisterUpdateCallback(HandleWorkerUpdate);
			mReleaseReport.RegisterCallbacks(HandleReportRelease, SetArrowAnimation, EndArrowAnimation);
			
			GlobalData.GetInstance().pPopUpManager.SetLeakHolder(this);
		}
		
		public function SetArrowAnimation(startX:Number, startY:Number, endX:Number, endY:Number):void
		{
			mArrow.BeginAnimation(startX, startY, endX, endY);
		}
		
		public function EndArrowAnimation():void
		{
			mArrow.EndAnimation();
		}
		
		private function HandleReportRelease(reportCost:Number):void		
		{
			mTotalLeaks.UpdateLeaks(reportCost);
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