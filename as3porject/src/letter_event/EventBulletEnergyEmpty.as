package letter_event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EventBulletEnergyEmpty extends Event 
	{
		public static var EVENT_BULLET_ENERGY_EMPTY:String = "EVENT_BULLET_ENERGY_EMPTY";		
		public function EventBulletEnergyEmpty(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super( type, bubbles, cancelable );
		}
		
	}

}