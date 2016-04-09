package game.ui.effects 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import game.ui.LeakObject;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import utils.Constants;
	import utils.GlobalData;
	/**
	 * ...
	 * @author Javier
	 */
	public class HackNumberSpawner extends LeakObject
	{
		
		//[Embed(source="../../../../asset/white_font/font.fnt", mimeType="application/octet-stream")]
		[Embed(source="../../../../assets/font/matrix_font_large/font.fnt", mimeType="application/octet-stream")]
		public static var matrixFontXML:Class;
		
		[Embed(source="../../../../assets/font/matrix_font_large/font.png")]
		public static var matrixFontImage:Class;
		
		private var mImages:Vector.<HackFontLarge>;
		
		public function HackNumberSpawner() 
		{
			mImages = new Vector.<HackFontLarge>;
			GlobalData.GetInstance().RegisterFont(matrixFontImage, matrixFontXML, Constants.MATRIX_FONT_LARGE);
			Init();
		}
		
		private function Init():void
		{
			var i:int;
			for (i = 0; i < 20; ++i)
			{
				mImages[i] = new HackFontLarge(0.02 + Math.random() * 0.1, 184);
				addChild(mImages[i]);
			}
		}
		
		override public function Update(deltaTime:Number):void
		{
			var i:int;
			
			for (i = 0; i < mImages.length; ++i)
			{
				mImages[i].Update(deltaTime);
			}
		}
		
	}

}