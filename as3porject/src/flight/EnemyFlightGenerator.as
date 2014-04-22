package flight 
{
	import manager.ScoreManager;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EnemyFlightGenerator 
	{
		
		private var _enemyArray:Array = null;
		private var _enemyGroup:FlxGroup = null;
		private var _scoreMgr:ScoreManager = null;
		private var _weaponGroup:FlxGroup = null;
		private var _generateEnemyTime:Number = 1;
		private var _currentEnemyTime:Number = _generateEnemyTime;
		private var _playerFlight:PlayerFlight = null;
		private var _gameState:FlxState = null;
		public function EnemyFlightGenerator( enemyArray:Array, enemyGroup:FlxGroup, scoreMgr:ScoreManager, playerFlight:PlayerFlight,
			gameState:FlxState ) 
		{
			_enemyArray = enemyArray;
			_enemyGroup = enemyGroup;
			_scoreMgr = scoreMgr;
			_playerFlight = playerFlight;
			_gameState = gameState;
		}
		
		public function update():void
		{
			_currentEnemyTime -= FlxG.elapsed;
			if ( _currentEnemyTime <= 0 )
			{
				var enemyType:int = int(Math.random() * EnemyFlightType.EnemyMaxType ) + 1;
				
				trace( "" + enemyType );
				var randomX:Number = Math.random() * FlxG.width;
				var randomY:Number = Math.random() * FlxG.height;
				generateEnemy( enemyType, randomX, randomY );
				_currentEnemyTime = _generateEnemyTime;
			}
		}
		
		private function generateEnemy( enemyType:int, posX:Number, posY:Number ):void
		{
			var enemyAdded:BaseEnemyFlight = null;
			
			switch( enemyType )
			{
				case EnemyFlightType.EnemyNormalType:
					{
						enemyAdded = new EnemyWeakFollowFlight(_scoreMgr, _gameState, posX, posY);
						break;
					}
				case EnemyFlightType.EnemyWeakFollowType:
					{
						enemyAdded = new NormalEnemyFlight(_scoreMgr, _gameState, posX, posY);
						break;
					}
				default:
					{
						var dd:int = 0;
						break;
					}
			}
			if ( enemyAdded )
			{
				enemyAdded.playerFlight = _playerFlight;
				_gameState.add( enemyAdded );
				_enemyArray.push ( enemyAdded );	
			}
		}
	}
}