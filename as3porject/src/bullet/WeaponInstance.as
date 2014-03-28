package bullet 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class WeaponInstance extends FlxSprite 
	{
		private var _weaponType:int = 0;
		public function WeaponInstance( X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic );
		}
		
		public function get weaponType():int 
		{
			return _weaponType;
		}
		
		public function set weaponType(value:int):void 
		{
			_weaponType = value;
			switch ( _weaponType )
			{
				case BaseWeapon.WEAPON_TYPE_I:
				{
					this.frame = 8;
					break;
				}
				case BaseWeapon.WEAPON_TYPE_X:
				{
					this.frame = 23;
					break;
				}
				case BaseWeapon.WEAPON_TYPE_Y:
				{
					this.frame = 24;
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
	}

}