package game.ui 
{
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Javier
	 */
	public class LeakHolder extends Sprite
	{
		[Embed(source = "../../../assets/game_layout.png")]
		private var debug_layout:Class;
		
		public function LeakHolder() 
		{
			
		}
		
		public function Init():void
		{
			var bmp:Bitmap = new debug_layout();
			var tex:Texture = Texture.fromBitmapData(bmp.bitmapData);
			var img:Image = new Image(tex);
			
			addChild(img);
		}
		
	}

}