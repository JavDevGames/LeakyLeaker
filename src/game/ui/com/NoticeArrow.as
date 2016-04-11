package game.ui.com 
{
	import flash.geom.Point;
	import flash.system.ImageDecodingPolicy;
	import game.ui.LeakObject;
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Javier
	 */
	public class NoticeArrow extends LeakObject 
	{
		[Embed(source = "../../../../assets/arrow.png")]
		private var arrow:Class;
		
		private var mArrow:Image;
		
		private static const STATE_HIDDEN:int = 0;
		private static const STATE_ANIMATING_IN:int = 1;
		private static const STATE_ANIMATING_OUT:int = 2;
		private var mState:int;
		
		private var mStart:Point;
		private var mEnd:Point;
		
		private const STATE_TIME_DELAY:Number = 0.750;
		private var mStateTime:Number;
		
		private var mTween:Tween;
		
		public function NoticeArrow() 
		{
			Init()
		}
		
		private function Init():void
		{
			var tex:Texture = Texture.fromEmbeddedAsset(arrow);
			mArrow = new Image(tex);
			mArrow.touchable = false;
			
			mState = STATE_HIDDEN;
			
			addChild(mArrow);
			
			mStart = new Point();
			mEnd = new Point();
		}
		
		public function BeginAnimation(startX:Number, startY:Number, endX:Number, endY:Number):void
		{
			mStart.x = startX;
			mStart.y = startY;
			
			mEnd.x = endX;
			mEnd.y = endY;
			
			var dx:Number = mStart.x - mEnd.x;
			var dy:Number = mStart.y - mEnd.y;
			var angle:Number = Math.atan2(dy, dx);
			
			mArrow.alignPivot();
			
			mArrow.x = startX;
			mArrow.y = startY;
			mArrow.rotation = angle - (Math.PI/2);
			
			if (!mTween)
			{
				mTween = new Tween(mArrow, STATE_TIME_DELAY, Transitions.EASE_IN_OUT);
			}
			else
			{
				mTween.reset(mArrow, STATE_TIME_DELAY, Transitions.EASE_IN_OUT);
			}
			
			mTween.repeatCount = 0;
			mTween.reverse = true;
			mTween.moveTo(mEnd.x, mEnd.y);
			Starling.juggler.add(mTween);
			
			mArrow.visible = true;
			mStateTime = STATE_TIME_DELAY;
		}
		
		public function EndAnimation():void
		{
			mArrow.visible = false;
		}
		
		
	}

}