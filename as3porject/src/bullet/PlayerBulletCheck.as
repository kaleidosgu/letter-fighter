package bullet 
{
	import flight.BaseFlight;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerBulletCheck 
	{
		[Embed(source = "../../res/sound/explosion.mp3")] private var explosion:Class;
		private var _bulletGroup:FlxGroup = null;
		private var _enemyGroup:FlxGroup = null;
		private var _state:FlxState = null;
		public function PlayerBulletCheck( group:FlxGroup, enemyGroupExternal:FlxGroup, state:FlxState ) 
		{
			_bulletGroup = group;
			_enemyGroup = enemyGroupExternal;
			_state = state;
		}
		
		public function update():void
		{
			FlxG.collide( _bulletGroup, _enemyGroup , enemyCollideBullet );
		}
		
		public function get enemyGroup():FlxGroup 
		{
			return _enemyGroup;
		}
		
		public function set enemyGroup(value:FlxGroup):void 
		{
			_enemyGroup = value;
		}
		
		private function enemyCollideBullet( flxobj1:FlxObject, flxobj2:FlxObject ):void
		{
			if ( flxobj2 is BaseFlight )
			{
				var baseFlight:BaseFlight = flxobj2 as BaseFlight;
				baseFlight.exploded();
				_enemyGroup.remove( flxobj2 );
				
				FlxG.play( explosion );
				_state.remove( flxobj1 );
				_bulletGroup.remove( flxobj1 );
			}
		}
	}

}