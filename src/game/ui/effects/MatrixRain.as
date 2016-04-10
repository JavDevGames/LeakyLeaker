package game.ui.effects 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	import game.ui.LeakObject;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Javier
	 */
	public class MatrixRain extends LeakObject 
	{
		
		private var mRainTiles:Vector.<MatrixRainTile>;
		private var mRainBg:Image;
		
		public function MatrixRain() 
		{
			var bmp:BitmapData = new BitmapData(16, 16, false, 0);
			var rainBgTex:Texture = Texture.fromBitmapData(bmp);
			mRainBg = new Image(rainBgTex);
			mRainBg.width = 386;
			mRainBg.height = 720;
			//addChild(mRainBg);
			
			mRainTiles = new Vector.<MatrixRainTile>(36);
			Init();
		}
		
		private function Init():void
		{
			var i:int;
			
			var texCoords:Rectangle = new Rectangle();
			for (i = 0; i < mRainTiles.length; ++i)
			{
				texCoords.x = i / 36;
				texCoords.y = 0;
				texCoords.width = (i + 1) / 36;
				texCoords.height = 1;
				
				mRainTiles[i] = new MatrixRainTile(texCoords, 0.002 * Math.random() * 0.04);
				mRainTiles[i].x = (i / 36) * 386;
				addChild(mRainTiles[i]);
			}
		}
		
		override public function Update(deltaTime:Number):void 
		{
			var i:int;
			
			for (i = 0; i < mRainTiles.length; ++i)
			{
				mRainTiles[i].Update(deltaTime);
			}
		}
		
	}

}