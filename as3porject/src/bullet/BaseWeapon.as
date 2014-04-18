package bullet 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseWeapon 
	{
		public static var WEAPON_TYPE_I:int = 1;
		public static var WEAPON_TYPE_Y:int = 2;
		public static var WEAPON_TYPE_X:int = 3;
		private var _addState:FlxState;
		private var _weaponType:int = 0;
		private var _bulletGroup:FlxGroup = null;
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
			_bulletGroup.add ( _bulletSprite );
		}
		
		public function fire( graphic:Class, initX:Number, initY:Number ):void
		{
			switch ( _weaponType )
			{
				case WEAPON_TYPE_I:
				{
					generateBullet( graphic, initX, initY, 0, -500 );
					break;
				}
				case WEAPON_TYPE_X:
				{
					generateBullet( graphic, initX, initY, -500, -500 );
					generateBullet( graphic, initX, initY, -500, 500 );
					generateBullet( graphic, initX, initY, 500, -500 );
					generateBullet( graphic, initX, initY, 500, 500 );
					break;
				}
				case WEAPON_TYPE_Y:
				{
					generateBullet( graphic, initX, initY, -500, -500 );
					generateBullet( graphic, initX, initY, 500, -500 );
					generateBullet( graphic, initX, initY, 0, 500 );
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		public function get addState():FlxState 
		{
			return _addState;
		}
		
		public function set addState(value:FlxState):void 
		{
			_addState = value;
		}
		
		public function get weaponType():int 
		{
			return _weaponType;
		}
		
		public function set weaponType(value:int):void 
		{
			_weaponType = value;
		}
		
		public function get bulletGroup():FlxGroup 
		{
			return _bulletGroup;
		}
		
		public function set bulletGroup(value:FlxGroup):void 
		{
			_bulletGroup = value;
		}
		
	}

}