package bullet 
{
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseWeapon 
	{
		
		private var _addState:FlxState;
		public function BaseWeapon() 
		{
			
		}
		
		private function generateBullet( graphic:Class, initX:Number, initY:Number, vx:Number, vy:Number ):void
		{
			var _bullet:BaseBullet = new BaseBullet();
			_bullet.velocityX = vx;
			_bullet.velocityY = vy;
			var _bulletSprite:FlxSprite = _bullet.generateBullet( graphic, initX, initY );
			_addState.add( _bulletSprite );
		}
		
		public function fire( graphic:Class, initX:Number, initY:Number ):void
		{
			//bullet Y
			/*generateBullet( graphic, initX, initY, -500, -500 );
			generateBullet( graphic, initX, initY, 500, -500 );
			generateBullet( graphic, initX, initY, 0, 500 );*/
			
			//bullet X
			/*generateBullet( graphic, initX, initY, -500, -500 );
			generateBullet( graphic, initX, initY, -500, 500 );
			generateBullet( graphic, initX, initY, 500, -500 );
			generateBullet( graphic, initX, initY, 500, 500 );*/
			
			//bullet I
			generateBullet( graphic, initX, initY, 0, -500 );
			
		}
		
		public function get addState():FlxState 
		{
			return _addState;
		}
		
		public function set addState(value:FlxState):void 
		{
			_addState = value;
		}
		
	}

}