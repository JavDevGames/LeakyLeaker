package game 
{
	import game.ui.LeakHolder;
	import starling.core.Starling;
	import starling.display.Sprite;
	import utils.GlobalData;
	/**
	 * ...
	 * @author Javier
	 */
	public class LeakInitializer
	{
		protected var mStarling:Starling;
		private var mSuccess:Function;
		
		public function LeakInitializer(success:Function) 
		{
			mSuccess = success;
		}
		
		public function Init():void
		{
			mStarling = new Starling(LeakHolder, GlobalData.GetInstance().pStage, null, GlobalData.GetInstance().pStage.stage3Ds[0], "auto", "auto");
			mStarling.start();
			GlobalData.GetInstance().PostInit(mStarling, CreationComplete);	
		}
		
		private function CreationComplete():void
		{
			mSuccess(mStarling);
		}
		
	}

}