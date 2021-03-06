package game.definitions 
{
	/**
	 * ...
	 * @author Javier
	 */
	public class LeakWorker 
	{
		public var pType:int;
		public var pName:String;
		public var pCost:Number;
		public var pOwned:Number;
		public var pOutput:Number;
		public var pFreeUnits:int;
		
		public function LeakWorker(type:int, name:String, cost:Number, owned:Number, output:Number) 
		{
			pType = type;
			pName = name;
			pCost = cost;
			pOwned = owned;
			pOutput = output;
		}
		
		public function Clone():LeakWorker
		{
			var clone:LeakWorker = new LeakWorker(pType, pName, pCost, pOwned, pFreeUnits);
			return clone;
		}
		
	}

}