package flight 
{
	import dispatcher.GlobalDispatcher;
	import letter_event.EventEnemyExploded;
	import manager.ScoreManager;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BaseEnemyFlight extends FlxSprite implements BaseFlight 
	{
		[Embed(source = "../../res/image/fighter2.png")] private static var ImgFighter:Class;
		protected var _scoreManager:ScoreManager = null;
		protected var _state:FlxState = null;
		private var _playerFlight:PlayerFlight = null;
		
		private var _enemyScore:int = 0;
		protected var _velocityX:Number = 40;
		protected var _velocityY:Number = 40;
		public function BaseEnemyFlight( mgr:ScoreManager, state:FlxState,X:Number=0,Y:Number=0,SimpleGraphic:Class=null ) 
		{
			super(X, Y, SimpleGraphic );
			_scoreManager = mgr;
			_state = state;
			
			this.loadGraphic(ImgFighter, true, true, 17,20);
			
			//bounding box tweaks
			this.width = 17;
			this.height = 20;
			this.offset.x = 1;
			this.offset.y = 1;
			
			this.drag.x = 640;
			this.drag.y = 640;
			
			this.maxVelocity.x = 30;
			this.maxVelocity.y = 30;
			
			//animations
			this.addAnimation("flying", [0, 1], 40);
			this.play("flying");
			_state.add( this );
		}
		override public function destroy():void
		{
			super.destroy();
			
			_scoreManager = null;
			_state = null;
			_playerFlight = null;
		}
		public function gameStop():void
		{
			this.velocity.x = 0;
			this.velocity.y = 0;
			this.acceleration.x = 0;
			this.acceleration.y = 0;
		}
		public function exploded():void
		{
			var eventExploded:EventEnemyExploded= new EventEnemyExploded( EventEnemyExploded.EVENT_ENEMY_EXPLODED );
			eventExploded.enemyPosX = this.x;
			eventExploded.enemyPosY = this.y;
			eventExploded.enemyScore = _enemyScore;			
			if ( _scoreManager )
			{
				_scoreManager.addScore( _enemyScore );	
			}
			GlobalDispatcher.getIns().dispatchEvent( eventExploded ); 
			
			_state.remove( this );
		}
		
		public function get enemyScore():int 
		{
			return _enemyScore;
		}
		
		public function set enemyScore(value:int):void 
		{
			_enemyScore = value;
		}
		
		public function get playerFlight():PlayerFlight 
		{
			return _playerFlight;
		}
		
		public function set playerFlight(value:PlayerFlight):void 
		{
			_playerFlight = value;
		}
		public function updateFlight():void
		{
			
		}
	}

}