package flight 
{
	import bullet.BaseWeapon;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerFlight extends FlxSprite implements BaseFlight 
	{
		[Embed(source = "../../res/image/fighter2.png")] private static var ImgFighter:Class;
		[Embed(source = "../../res/image/bullet3.png")] private static var bulletPicture:Class;
		
		private var _weapon:BaseWeapon = null;
		private var _state:FlxState = null;
		public function PlayerFlight( state:FlxState, X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			
			loadGraphic(ImgFighter, true, true, 17, 20);
			
			width = 17;
			height = 20;
			offset.x = 1;
			offset.y = 1;
			
			drag.x = 640;
			drag.y = 640;
			
			maxVelocity.x = 200;
			maxVelocity.y = 200;
			
			addAnimation("flying", [0, 1], 40);
			play("flying");
			_state = state;
			_state.add( this );
			_weapon = new BaseWeapon();
			_weapon.addState = _state;
			_weapon.weaponType = BaseWeapon.WEAPON_TYPE_I;
		}
		public function exploded():void
		{
		}
		
		public function flightGetWeapon ( weaponType:int ):void
		{
			_weapon.weaponType = weaponType ;
			if ( weaponType == BaseWeapon.WEAPON_TYPE_I )
			{
				color = 0xff0000;
			}
			else if ( weaponType == BaseWeapon.WEAPON_TYPE_X )
			{
				color = 0x00ff00;
			}
			else if ( weaponType == BaseWeapon.WEAPON_TYPE_Y )
			{
				color = 0x0000ff;
			}
			
		}
		
		public function updatePlayer():void
		{
			acceleration.x = 0;
			acceleration.y = 0;
			if(FlxG.keys.LEFT)
			{
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				acceleration.x += drag.x;
			}
			
			if (FlxG.keys.UP)
			{
				acceleration.y -= drag.y;
			}
			else if (FlxG.keys.DOWN)
			{
				acceleration.y += drag.y;
			}
			if ( FlxG.keys.justReleased("SPACE" ) )
			{
				_weapon.fire( bulletPicture, x + width / 2, y + height + 2 );
			}
		}		
	}

}