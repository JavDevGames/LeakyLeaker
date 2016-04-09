package utils 
{
	import flash.display.BitmapData;
	import flash.system.ImageDecodingPolicy;
	import game.ui.com.LeakPopUp;
	import game.ui.LeakHolder;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Javier
	 */
	public class PopUpManager 
	{
		private var mCurPopUp:LeakPopUp;
		private var mLeakHolder:LeakHolder;
		private var mBlockerImage:Image;
		
		public function PopUpManager() 
		{
			
		}
		
		public function SetLeakHolder(holder:LeakHolder):void
		{
			mLeakHolder = holder;
			
			var bmpData:BitmapData = new BitmapData(16, 16, true, 0x99000000);
			var blockerTex:Texture = Texture.fromBitmapData(bmpData);
			mBlockerImage = new Image(blockerTex);
			mBlockerImage.width = Starling.current.viewPort.width;
			mBlockerImage.height = Starling.current.viewPort.height;
		}
		
		public function AddPopUp(popUpClass:Class, params:Object):void
		{
			mCurPopUp = new popUpClass();
			mCurPopUp.Init(params);
			
			mLeakHolder.addChild(mBlockerImage);
			mLeakHolder.addChild(mCurPopUp);
		}
		
		public function RemovePopUp(popUp:LeakPopUp):void
		{
			mLeakHolder.removeChild(mBlockerImage);
			mLeakHolder.removeChild(popUp);
			mCurPopUp = null;
		}
		
	}

}