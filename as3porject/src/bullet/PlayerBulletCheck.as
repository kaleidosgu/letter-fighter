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
		private var _group:FlxGroup = null;
		private var _collideGroup:FlxGroup = null;
		private var _state:FlxState = null;
		public function PlayerBulletCheck( group:FlxGroup, collideGroup:FlxGroup, state:FlxState ) 
		{
			_group = group;
			_collideGroup = collideGroup;
			_state = state;
		}
		
		public function update():void
		{
			FlxG.collide( _group, _collideGroup , enemyCollideBullet );
		}
		
		public function get collideGroup():FlxGroup 
		{
			return _collideGroup;
		}
		
		public function set collideGroup(value:FlxGroup):void 
		{
			_collideGroup = value;
		}
		
		private function enemyCollideBullet( flxobj1:FlxObject, flxobj2:FlxObject ):void
		{
			if ( flxobj2 is BaseFlight )
			{
				var baseFlight:BaseFlight = flxobj2 as BaseFlight;
				baseFlight.exploded();
				_collideGroup.remove( flxobj2 );
			}
			_state.remove( flxobj1 );
		}
	}

}