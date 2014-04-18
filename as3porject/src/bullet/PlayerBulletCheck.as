package bullet 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerBulletCheck 
	{
		private var _collideFunction:Function = null;
		private var _group:FlxGroup = null;
		private var _collideGroup:FlxGroup = null;
		public function PlayerBulletCheck( group:FlxGroup, collideGroup:FlxGroup, collideFun:Function ) 
		{
			_group = group;
			_collideGroup = collideGroup;
			_collideFunction = collideFun;
		}
		
		public function update():void
		{
			FlxG.collide( _group, _collideGroup , _collideFunction );
		}
		
		public function get collideGroup():FlxGroup 
		{
			return _collideGroup;
		}
		
		public function set collideGroup(value:FlxGroup):void 
		{
			_collideGroup = value;
		}
		
	}

}