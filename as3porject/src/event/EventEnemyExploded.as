package event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EventEnemyExploded extends Event 
	{
		
		public static var EVENT_ENEMY_EXPLODED:String = "EVENT_ENEMY_EXPLODED";
		public function EventEnemyExploded(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super( type, bubbles, cancelable );
		}
		
	}

}