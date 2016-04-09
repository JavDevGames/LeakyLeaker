package game.ui.com 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import game.ui.LeakObject;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Javier
	 */
	public class VisualLeakWorker extends LeakObject 
	{
		[Embed(source = "../../../../assets/worker_01.png")]
		private static var worker_01:Class;
		
		[Embed(source = "../../../../assets/worker_02.png")]
		private static var worker_02:Class;
		
		[Embed(source = "../../../../assets/worker_03.png")]
		private static var worker_03:Class;
		
		[Embed(source = "../../../../assets/worker_04.png")]
		private static var worker_04:Class;
		
		[Embed(source = "../../../../assets/worker_05.png")]
		private static var worker_05:Class;
		
		[Embed(source = "../../../../assets/worker_06.png")]
		private static var worker_06:Class;
		
		[Embed(source = "../../../../assets/worker_07.png")]
		private static var worker_07:Class;
		
		private static var mWorkerTex:Dictionary;
		
		private var mType:int;
		private var mImage:Image;
		
		public function VisualLeakWorker(type:int) 
		{
			mType = type;
			mWorkerTex = new Dictionary;
			
			var bmp:Bitmap;
			switch(type)
			{
				case 1: 
					bmp = new worker_01();
					break;
				case 2: 
					bmp = new worker_02();
					break;
				case 3: 
					bmp = new worker_03();
					break;
				case 4: 
					bmp = new worker_04();
					break;
				case 5: 
					bmp = new worker_05();
					break;
				case 6: 
					bmp = new worker_06();
					break;
				case 7: 
					bmp = new worker_07();
					break;
			}
			
			var tex:Texture;
			
			if (!mWorkerTex[type])
			{
				mWorkerTex[type] = Texture.fromBitmapData(bmp.bitmapData);
				tex = mWorkerTex[type];
			}
			
			mImage = new Image(tex);
			addChild(mImage);
		}
		
	}

}