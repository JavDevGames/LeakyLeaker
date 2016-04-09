package game.ui.com 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.DataEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ImageDecodingPolicy;
	import game.definitions.LeakWorker;
	import game.definitions.WorkerDefinitions;
	import game.ui.LeakObject;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import utils.GlobalData;
	import utils.PlayerProfile;
	/**
	 * ...
	 * @author Javier
	 */
	public class ShopRenderers extends LeakObject 
	{
		[Embed(source = "../../../../assets/worker_icon_01.png")]
		private static var worker_icon_01:Class;
		
		[Embed(source = "../../../../assets/worker_icon_02.png")]
		private static var worker_icon_02:Class;
		
		[Embed(source = "../../../../assets/worker_icon_03.png")]
		private static var worker_icon_03:Class;
		
		[Embed(source = "../../../../assets/worker_icon_04.png")]
		private static var worker_icon_04:Class;
		
		[Embed(source = "../../../../assets/worker_icon_05.png")]
		private static var worker_icon_05:Class;
		
		[Embed(source = "../../../../assets/worker_icon_06.png")]
		private static var worker_icon_06:Class;
		
		[Embed(source = "../../../../assets/worker_bg.png")]
		private static var worker_bg:Class;
		
		[Embed(source = "../../../../assets/worker_bg_down.png")]
		private static var worker_bg_down:Class;
		
		private var mIcon:Image;
		private var mTitle:TextField;
		private var mCost:TextField;
		private var mOwnCount:TextField;
		private var mDefinitionClone:LeakWorker;
		public var pType:int;
		private var mBgButton:Button;
		
		private var mBgTexUp:Texture;
		private var mBgTexDown:Texture;
		
		private var mClickCallback:Function;
		private var mPlayerProfile:PlayerProfile;
		private var mBlocker:Image;
		  
		public function ShopRenderers() 
		{
			if (!mBgTexUp)
			{
				var bmp:Bitmap = new worker_bg();
				mBgTexUp = Texture.fromBitmapData(bmp.bitmapData);
				
				bmp = new worker_bg_down();
				mBgTexDown = Texture.fromBitmapData(bmp.bitmapData);
			}
		}
		
		public function Init(type:int, clickCallback:Function):void
		{
			pType = type;
			mClickCallback = clickCallback;
			
			var bmp:Bitmap;
			
			switch(type)
			{
				case 1:
						bmp = new worker_icon_01;
						break;
				case 2:
						bmp = new worker_icon_02;
						break;
				case 3:
						bmp = new worker_icon_03;
						break;
				case 4:
						bmp = new worker_icon_04;
						break;
				case 5:
						bmp = new worker_icon_05;
						break;
				case 6:
						bmp = new worker_icon_06
						break
			}
			
			var tex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			
			mIcon = new Image(tex);
			mIcon.x = 5;
			mIcon.y = 5;
			
			var i:int;
			
			var defs:Vector.<LeakWorker> = WorkerDefinitions.GetInstance().pWorkerDefs;
			var cur:LeakWorker = null;
			for (i = 0; i < defs.length; ++i)
			{
				if (defs[i].pType == pType)
				{
					cur = defs[i];
					break;
				}
			}
			
			if (!cur)
			{
				throw new Error("Worker type not found: " + pType);
			}
			
			mTitle = new TextField(280, 22, cur.pName, "Verdana", 12, 0xffffff);
			mTitle.hAlign = HAlign.LEFT;
			mTitle.x = 45;
			mTitle.y = 3;
			
			mCost = new TextField(90, 12, cur.pCost + "", "Verdana", 8, 0xffffff);
			mCost.hAlign = HAlign.LEFT;
			mCost.y = mTitle.height;
			
			mOwnCount = new TextField(150, 33, cur.pOwned + "", "Verdana", 25, 0xffffff);
			mOwnCount.hAlign = HAlign.LEFT;
			mOwnCount.x = 160;
			mOwnCount.y = 4;
			
			mBgButton = new Button(mBgTexUp, "", mBgTexDown);
			addChild(mBgButton);
			
			mBgButton.addChild(mIcon);
			mBgButton.addChild(mTitle);
			mTitle.addChild(mCost);
			mBgButton.addChild(mOwnCount);
			
			mBgButton.addEventListener(Event.TRIGGERED, HandlePurchase);
			
			mDefinitionClone = cur.Clone();
			mPlayerProfile = GlobalData.GetInstance().pPlayerProfile;
			
			var bmpData:BitmapData = new BitmapData(mBgButton.width, mBgButton.height, true, 0x99000000);
			var blockerTex:Texture = Texture.fromBitmapData(bmpData);
			
			mBlocker = new Image(blockerTex);
			addChild(mBlocker);
		}
		
		private function HandlePurchase(e:Event):void 
		{
			mClickCallback(pType, mDefinitionClone.pCost);
			
			mDefinitionClone.pOwned += 1; //amount?
			mDefinitionClone.pCost = Math.round(mDefinitionClone.pCost * 1.15);
			UpdateOwned();
		}
		
		private function UpdateOwned():void
		{
			mOwnCount.text = mDefinitionClone.pOwned + "";
			mCost.text = mDefinitionClone.pCost + "";
		}
		
		override public function Update(deltaTime:Number):void
		{
			var enabled:Boolean = !(mPlayerProfile.pTotalLeaks >= mDefinitionClone.pCost);
			
			mBlocker.visible = enabled;
			
		}
	}

}