package letter_event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EventPlayerGetWeapon extends Event 
	{
		
		public static var EVENT_PLAYER_GET_WEAPON:String = "EVENT_PLAYER_GET_WEAPON";
		private var _weaponType:int = 0;
		private var _weaponTime:Number = 0;
		public function EventPlayerGetWeapon(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super( type, bubbles, cancelable );
		}
		
		public function get weaponType():int 
		{
			return _weaponType;
		}
		
		public function set weaponType(value:int):void 
		{
			_weaponType = value;
		}
		
		public function get weaponTime():Number 
		{
			return _weaponTime;
		}
		
		public function set weaponTime(value:Number):void 
		{
			_weaponTime = value;
		}
		
	}

}