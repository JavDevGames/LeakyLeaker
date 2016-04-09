package game.ui.com 
{
	import flash.display.Bitmap;
	import game.definitions.LeakWorker;
	import game.definitions.WorkerDefinitions;
	import mx.utils.NameUtil;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Javier
	 */
	public class WorkerHolder extends LeakObject
	{
		[Embed(source = "../../../../assets/worker_panel_01.png")]
		private static var worker_panel_01:Class;
		
		[Embed(source = "../../../../assets/worker_panel_02.png")]
		private static var worker_panel_02:Class;
		
		[Embed(source = "../../../../assets/worker_panel_03.png")]
		private static var worker_panel_03:Class;
		
		[Embed(source = "../../../../assets/worker_panel_04.png")]
		private static var worker_panel_04:Class;
		
		[Embed(source = "../../../../assets/worker_panel_05.png")]
		private static var worker_panel_05:Class;
		
		[Embed(source = "../../../../assets/worker_panel_06.png")]
		private static var worker_panel_06:Class;
		
		[Embed(source = "../../../../assets/worker_panel_07.png")]
		private static var worker_panel_07:Class;
		
		public var pType:int;
		private var mWorkers:Vector.<VisualLeakWorker>;
		private var mBg:Image;
		private var mTotalWorkers:int;
		private var mUpdateFunc:Function;
		private var mProductionRate:Number;
		
		public function WorkerHolder(type:int, totalWorkers:int, updateFunc:Function) 
		{
			pType = type;
			mTotalWorkers = totalWorkers;
			mUpdateFunc = updateFunc;
			
			var definition:LeakWorker = WorkerDefinitions.GetInstance().GetFromType(type);
			mProductionRate = definition.pOutput;
			
			var bmp:Bitmap;
			
			switch(type)
			{
				case 1: 
					bmp = new worker_panel_01();
					break;
				case 2: 
					bmp = new worker_panel_02();
					break;
				case 3: 
					bmp = new worker_panel_03();
					break;
				case 4: 
					bmp = new worker_panel_04();
					break;
				case 5: 
					bmp = new worker_panel_05();
					break;
				case 6: 
					bmp = new worker_panel_06();
					break;
				case 7: 
					bmp = new worker_panel_07();
					break;
			}
			
			var tex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			mBg = new Image(tex);
			addChild(mBg);
			
			mWorkers = new Vector.<VisualLeakWorker>();
			
			UpdateWorkers();
		}
		
		public function AddWorkers(numWorkers:int):void
		{
			//do something here
			mTotalWorkers += numWorkers;
			UpdateWorkers();			
		}
		
		private function UpdateWorkers():void
		{
			var i:int;
			var workerDiff:int = mTotalWorkers - mWorkers.length;
			
			var curWorker:VisualLeakWorker;
			var posX:Number;
			var posY:Number;
			
			for (i = 0 ; i < workerDiff; ++i)
			{
				curWorker = new VisualLeakWorker(pType);
				
				posX = 20 + (mWorkers.length * 20);
				posY = 30 + int(mWorkers.length % 2) * 20;
				
				mWorkers.push(curWorker);
				
				curWorker.x = posX;
				curWorker.y = posY;
				
				addChild(curWorker);
			}
		}
		
		override public function Update(deltaTime:Number):void
		{
			var newAmount:Number = ((mProductionRate/1000) * deltaTime) * mTotalWorkers;
			mUpdateFunc(newAmount);
		}
	}

}