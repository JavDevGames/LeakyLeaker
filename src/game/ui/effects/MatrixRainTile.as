package game.ui.effects 
{
	import flash.display.Bitmap;
	import flash.display3D.textures.RectangleTexture;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.ui.LeakObject;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Javier
	 */
	public class MatrixRainTile extends LeakObject 
	{
		[Embed(source = "../../../../assets/matrix_rain.png")]
		private static var matrix_rain:Class;
		
		private var mTileImage:Image;
		
		private static var MATRIX_TEX:Texture;
		private static var HELPER_POINT:Point;
		
		private var mTexCoords:Rectangle;
		private var mSpeedY:Number;
		private var mTotalOffsetY:Number;
		public function MatrixRainTile(texCoord:Rectangle, speedY:Number) 
		{
			if (!MATRIX_TEX)
			{
				MATRIX_TEX = Texture.fromEmbeddedAsset(matrix_rain, false, false, 1, "bgra", true);
				HELPER_POINT = new Point();
			}
			
			mTileImage = new Image(MATRIX_TEX);
			mTileImage.width = (1 / 36) * mTileImage.width;
			
			HELPER_POINT.x = texCoord.x;
			HELPER_POINT.y = texCoord.y;
			
			mTileImage.setTexCoords(0, HELPER_POINT);
			
			HELPER_POINT.x = texCoord.width;
			HELPER_POINT.y = texCoord.y;
			
			mTileImage.setTexCoords(1, HELPER_POINT);
			
			HELPER_POINT.x = texCoord.x;
			HELPER_POINT.y = texCoord.height;
			
			mTileImage.setTexCoords(2, HELPER_POINT);
			
			HELPER_POINT.x = texCoord.width;
			HELPER_POINT.y = texCoord.height;
			
			mTileImage.setTexCoords(3, HELPER_POINT);
			
			mTexCoords = new Rectangle(texCoord.x, texCoord.y, texCoord.width, texCoord.height);
			
			mSpeedY = speedY;
			mTotalOffsetY = 0;
			addChild(mTileImage);
		}
		
		override public function Update(deltaTime:Number):void 
		{
			var offset:Number =  mSpeedY * deltaTime;
			
			mTotalOffsetY += offset;
			
			if (mTotalOffsetY < 0.01)
			{
				return;
			}
			
			mTexCoords.y -= mTotalOffsetY;			
			mTexCoords.height -= mTotalOffsetY;
			
			HELPER_POINT.x = mTexCoords.x;
			HELPER_POINT.y = mTexCoords.y;
			
			mTileImage.setTexCoords(0, HELPER_POINT);
			
			HELPER_POINT.x = mTexCoords.width;
			HELPER_POINT.y = mTexCoords.y;
			
			mTileImage.setTexCoords(1, HELPER_POINT);
			
			HELPER_POINT.x = mTexCoords.x;
			HELPER_POINT.y = mTexCoords.height;
			
			mTileImage.setTexCoords(2, HELPER_POINT);
			
			HELPER_POINT.x = mTexCoords.width;
			HELPER_POINT.y = mTexCoords.height;
			
			mTileImage.setTexCoords(3, HELPER_POINT);
			
			mTotalOffsetY = 0;
		}
	}

}