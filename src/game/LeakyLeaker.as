package game 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;
	import game.ui.LeakHolder;
	import starling.core.Starling;
	import utils.GlobalData;
	/**
	 * ...
	 * @author Javier
	 */
	public class LeakyLeaker extends Sprite
	{
		private var mInitializer:LeakInitializer;
		private var mStarling:Starling;
		private var mLastTime:Number;
		private var mLeakHolder:LeakHolder;
		
		public function LeakyLeaker(stage:Stage) 
		{
			GlobalData.GetInstance().pStage = stage;
			
			mInitializer = new LeakInitializer(HandleStarlingInitialized);
			mLastTime = getTimer();
			
			mInitializer.Init();		
			
		}
		
		private function HandleStarlingInitialized(starling:Starling):void
		{
			mStarling = starling;
			//init the game scene
			
			mLeakHolder = mStarling.root as LeakHolder;
			mLeakHolder.Init();
			
			trace("starling initialized");
			
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function Update(e:Event):void
		{
			var curTime:Number = getTimer();
			var delta:Number = curTime - mLastTime;
			mLastTime = curTime;
			
			mStarling.nextFrame();
			
			//update the scene
		}
		
	}

}