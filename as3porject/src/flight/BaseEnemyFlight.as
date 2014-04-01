package flight 
{
	import dispatcher.GlobalDispatcher;
	import event.EventEnemyExploded;
	import manager.ScoreManager;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseEnemyFlight extends FlxSprite implements BaseFlight 
	{
		protected var _scoreManager:ScoreManager = null;
		protected var _state:FlxState = null;
		public function BaseEnemyFlight( mgr:ScoreManager, state:FlxState ) 
		{
			_scoreManager = mgr;
			_state = state;
			_state.add( this );
		}
		public function exploded():void
		{
			var eventExploded:EventEnemyExploded( EventEnemyExploded.EVENT_ENEMY_EXPLODED );
			eventExploded.enemyPosX = this.x;
			eventExploded.enemyPosY = this.y;
			GlobalDispatcher.getIns().dispatchEvent( eventExploded );
			_state.remove( this );
		}
		
	}

}