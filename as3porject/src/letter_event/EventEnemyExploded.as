package letter_event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EventEnemyExploded extends Event 
	{
		
		public static var EVENT_ENEMY_EXPLODED:String = "EVENT_ENEMY_EXPLODED";
		private var _enemyPosX:Number = 0;
		private var _enemyPosY:Number = 0;
		private var _enemyScore:int = 0;
		public function EventEnemyExploded(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super( type, bubbles, cancelable );
		}
		
		public function get enemyPosX():Number 
		{
			return _enemyPosX;
		}
		
		public function set enemyPosX(value:Number):void 
		{
			_enemyPosX = value;
		}
		
		public function get enemyPosY():Number 
		{
			return _enemyPosY;
		}
		
		public function set enemyPosY(value:Number):void 
		{
			_enemyPosY = value;
		}
		
		public function get enemyScore():int 
		{
			return _enemyScore;
		}
		
		public function set enemyScore(value:int):void 
		{
			_enemyScore = value;
		}
		
	}

}