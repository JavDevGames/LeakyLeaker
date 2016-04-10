package game.definitions 
{
	import flash.display.GraphicsGradientFill;
	/**
	 * ...
	 * @author Javier
	 */
	public class WorkerDefinitions 
	{
		public var pWorkerDefs:Vector.<LeakWorker>;
		
		private static var mInstance:WorkerDefinitions;
		
		public static function GetInstance():WorkerDefinitions
		{
			if (!mInstance)
			{
				mInstance = new WorkerDefinitions();
				mInstance.Init();
			}
			
			return mInstance;
		}
		
		
		public function Init():void
		{
			pWorkerDefs = new Vector.<LeakWorker>();
			pWorkerDefs.push(new LeakWorker(1, "Google Searches", 15, 0, 0.1));
			pWorkerDefs.push(new LeakWorker(2, "Script Kiddie", 110, 0, 0.5));
			pWorkerDefs.push(new LeakWorker(3, "Programmer", 1100, 0, 10));
			pWorkerDefs.push(new LeakWorker(4, "EC2 Instance", 11000, 0, 100));
			pWorkerDefs.push(new LeakWorker(5, "Blackhat", 110000, 0, 1000));
			pWorkerDefs.push(new LeakWorker(6, "NSA", 1100000, 0, 10000));
		}
		
		public function GetFromType(type:int):LeakWorker
		{
			var i:int;
			
			for (i = 0; i < pWorkerDefs.length; ++i)
			{
				if (pWorkerDefs[i].pType == type)
				{
					return pWorkerDefs[i];
				}
			}
			
			return null;
		}
		
	}

}