package letter_event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class PlayerGetScoreEvent extends Event 
	{

		public static var PLAYER_GET_SCORE:String = "PLAYER_GET_SCORE";
		private var _scoreValue:int = 0;
		public function PlayerGetScoreEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super( type, bubbles, cancelable );
		}
		
		public function get scoreValue():int 
		{
			return _scoreValue;
		}
		
		public function set scoreValue(value:int):void 
		{
			_scoreValue = value;
		}
		
	}

}