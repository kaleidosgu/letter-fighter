package bullet 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	import org.flixel.FlxSprite;
	public class BaseBullet 
	{
		private var _velocityX:Number = 0;
		private var _velocityY:Number = 0;
		public function BaseBullet() 
		{
			
		}
		
		public function generateBullet( graphic:Class, initX:Number, initY:Number ):FlxSprite
		{
			var newBullet:FlxSprite = new FlxSprite( 0, 0 );
			newBullet.loadGraphic( graphic, false, false, 4,10);
			
			newBullet.width = 4;
			newBullet.height = 10;
			newBullet.offset.x = 1;
			newBullet.offset.y = 1;
			
			newBullet.velocity.y = _velocityY;
			newBullet.velocity.x = _velocityX;
			newBullet.maxVelocity.x = 80;
			newBullet.maxVelocity.y = 160;
			newBullet.acceleration.y -= newBullet.drag.y;
			
			newBullet.x = initX;
			newBullet.y = initY - newBullet.height / 2;
			return newBullet;
		}
		
		public function get velocityX():Number 
		{
			return _velocityX;
		}
		
		public function set velocityX(value:Number):void 
		{
			_velocityX = value;
		}
		
		public function get velocityY():Number 
		{
			return _velocityY;
		}
		
		public function set velocityY(value:Number):void 
		{
			_velocityY = value;
		}
	}

}