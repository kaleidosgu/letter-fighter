package bullet 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	public class WeaponPackage 
	{
		private var _state:FlxState = null;
		private var _sameTypeGroup:FlxGroup = null;
		private var _collideGroup:FlxGroup = null;
		private var _class:Class = null;
		private var _constTickTime:Number = 2;
		private var _tickCounts:Number = _constTickTime;
		private var _functionCollid:Function = null;
		public function WeaponPackage( state:FlxState, group:FlxGroup, collideGroup:FlxGroup, className:Class, collidFunc:Function ) 
		{
			_state = state;
			_sameTypeGroup = group;
			_collideGroup = collideGroup;
			_class = className;
			_functionCollid = collidFunc;
		}
		public function generateWeapon():void
		{
			var randomX:Number = Math.random() * FlxG.width;
			var randomY:Number = Math.random() * FlxG.height;
			generateWeaponPackage( randomX, randomY );
		}
		private function generateWeaponPackage( posX:Number, posY:Number ):FlxSprite
		{
			var _weapon:WeaponInstance = new WeaponInstance( posX, posY );
			_weapon.loadGraphic( _class, true, true, 12 );
			_weapon.width 	= 12;
			_weapon.height	= 12;
			_weapon.addAnimation( "abc", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25], 3 );
			var randomWeapon:int = int(Math.random() * ( 4 - 1 ) + 1 )
			_weapon.weaponType = randomWeapon;
			_state.add( _weapon );
			_sameTypeGroup.add( _weapon );
			return _weapon;
		}
		public function update():void
		{
			_tickCounts = _tickCounts - FlxG.elapsed;
			if ( _tickCounts < 0 )
			{
				_tickCounts = _constTickTime;
				generateWeapon();
			}
			FlxG.collide( _sameTypeGroup, _collideGroup , _functionCollid );
		}
		
		private function collideTrigged( flxobj1:FlxObject, flxobj2:FlxObject ):void
		{
			if ( flxobj1 is WeaponInstance )
			{
				var weaponIns1:WeaponInstance = flxobj1 as WeaponInstance;
				_state.remove( flxobj1 );
				weaponIns1 = null;
			}
			else if ( flxobj2 is WeaponInstance )
			{
				var weaponIns2:WeaponInstance = flxobj2 as WeaponInstance;
				_state.remove( flxobj2 );
				weaponIns2 = null;
			}
		}
		
	}

}