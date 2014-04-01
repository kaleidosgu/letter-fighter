package letter_event 
{
	import flash.events.Event;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EventEnemyScoreOver extends Event 
	{
		public static var EVENT_ENEMY_SCORE_OVER:String = "EVENT_ENEMY_SCORE_OVER";
		private var _scoreText:FlxText = null;
		public function EventEnemyScoreOver(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super( type, bubbles, cancelable );
		}
		
		public function get scoreText():FlxText 
		{
			return _scoreText;
		}
		
		public function set scoreText(value:FlxText):void 
		{
			_scoreText = value;
		}
		
	}

}