package 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.external.ExternalInterface;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	public class Preloader extends MovieClip
	{
		public function Preloader() 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stop();
			addEventListener(Event.ENTER_FRAME,HandleEnterFrame);
		}
		
		public function HandleEnterFrame(event:Event):void 
		{
			if (!stage)
			{
				return;
			}
			
			var percent:Number = (stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal);
			
			if(percent >= 1 && getTimer() > 1) 
			{
				nextFrame();
				Init();
				removeEventListener(Event.ENTER_FRAME, HandleEnterFrame);
			}
		}
		
		private function Init():void 
		{
			var leakerClass:Class = getDefinitionByName("game.LeakyLeaker") as Class;
			if(leakerClass) 
			{
				var leakyLeaker:Object = new leakerClass(stage);				
				addChild(leakyLeaker as DisplayObject);
			}
			
		}
	}
}