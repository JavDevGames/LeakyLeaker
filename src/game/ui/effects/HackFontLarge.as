package game.ui.effects 
{
	import game.ui.LeakObject;
	import starling.text.TextField;
	import utils.Constants;
	/**
	 * ...
	 * @author Javier
	 */
	public class HackFontLarge extends LeakObject
	{
		private var mSpeedY:Number;
		private var mLimit:Number;
		private var mTextField:TextField;
		private var mTotalDist:Number;
		
		private static const LIM_X:Number = 300;
		
		public function HackFontLarge(speedY:Number, limit:Number) 
		{
			mSpeedY = speedY;
			mLimit = limit;
			
			var text:String = "0";			
			var val:Number = Math.random();
			
			if (val > 0.5)
			{
				text = "1";
			}
			
			mTextField = new TextField(90, 80, text, Constants.MATRIX_FONT_LARGE, 72, 0x20F200);
			
			mTextField.x = 6 + Math.random() * LIM_X;
			mTextField.y = -100 + (Math.random() * -80);
			
			addChild(mTextField);
			
			mTotalDist = mLimit - mTextField.y;
		}
		
		override public function Update(deltaTime:Number):void 
		{
			var offsetY:Number = deltaTime * mSpeedY;
			
			if (mTextField.y + offsetY > mLimit)
			{
				var text:String = "0";			
				var val:Number = Math.random();
				
				if (val > 0.5)
				{
					text = "1";
				}
				
				mTextField.text = text;
				mTextField.y = -100 + (Math.random() * -80);
				mTextField.x = 6 + Math.random() * LIM_X;
				
				mTotalDist = mLimit - mTextField.y;
			}
			
			mTextField.y += offsetY;
			
			var distY:Number = mLimit - mTextField.y;
			var percent:Number = distY / mTotalDist;			
			
			mTextField.alpha = percent;
		}
	}

}