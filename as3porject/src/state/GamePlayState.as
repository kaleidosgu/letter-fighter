package state 
{
	import bullet.BaseWeapon;
	import bullet.PlayerBulletCheck;
	import bullet.WeaponInstance;
	import bullet.WeaponPackage;
	import component.BulletEnergyComponent;
	import component.ScoreInputItem;
	import dispatcher.GlobalDispatcher;
	import flash.events.Event;
	import flight.BaseFlight;
	import flight.EnemyFlightGenerator;
	import flight.NormalEnemyFlight;
	import flight.PlayerFlight;
	import gameConst.GameStatusConst;
	import kale.KaleiTextFormatConst;
	import letter_event.EventBulletEnergyEmpty;
	import letter_event.EventEnemyExploded;
	import letter_event.EventEnemyScoreOver;
	import letter_event.EventPlayerGetWeapon;
	import manager.ScoreManager;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import sceneobj.ScoreBillBoard;
	import sceneobj.ScoreSprite;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GamePlayState extends FlxState 
	{
		
		[Embed(source = "../../res/image/enemy/fontall.png")] private static var fontallPicture:Class;
		[Embed(source = "../../res/music/kraftwerk_aerodynamik.mp3")] private var BackgroundMusic:Class;
		[Embed(source = "../../res/image/startcloud3.png")] private static var backgroundPicture:Class;
		private var weaponPackage:WeaponPackage = null;
		private var _playerCheck:PlayerBulletCheck = null;
		private var player:PlayerFlight;
		private var playerGroup:FlxGroup = null;
		private var _scoreBill:ScoreBillBoard = null;
		private var weaponGroup:FlxGroup;
		private var _bulletGroup:FlxGroup;	
		private var enemyArray:Array = new Array();
		private var mgrScore:ScoreManager = new ScoreManager();
		private var enemyGroup:FlxGroup;
				
		private var _backgroundSprite:FlxSprite;
		private var _speedBackGround:Number = 0;
		
		private var _enemyGenerator:EnemyFlightGenerator = null;
		private var _gameStatus:uint = GameStatusConst.GAME_STATUS_RUN;
		
		private var scoreItem:ScoreInputItem = null;
		private var _bullet:BulletEnergyComponent = null;
		public function GamePlayState() 
		{
			
		}

		override public function create():void
		{
			super.create();
			
			CreateBackground();
			
			_bulletGroup = new FlxGroup();
			weaponGroup = new FlxGroup();
			enemyGroup = new FlxGroup();
			playerGroup = new FlxGroup();
			
			GlobalDispatcher.getIns().addEventListener( EventEnemyExploded.EVENT_ENEMY_EXPLODED, enemyExploded );
			GlobalDispatcher.getIns().addEventListener( EventEnemyScoreOver.EVENT_ENEMY_SCORE_OVER, enemyScoreOver );
			GlobalDispatcher.getIns().addEventListener( EventPlayerGetWeapon.EVENT_PLAYER_GET_WEAPON, playerGetWeapon );
			GlobalDispatcher.getIns().addEventListener( EventBulletEnergyEmpty.EVENT_BULLET_ENERGY_EMPTY, weaponEmpty );
			
			
			player = new PlayerFlight( this, _bulletGroup, 17, 17 );
			
			weaponPackage = new WeaponPackage(this, weaponGroup, playerGroup, fontallPicture, player);
			
			_playerCheck = new PlayerBulletCheck( _bulletGroup, enemyGroup, this );
			
			add( player );
			playerGroup.add( player );
			
			_scoreBill = new ScoreBillBoard( 0, 0, 100, "" );
			add( _scoreBill );
			
			_enemyGenerator = new EnemyFlightGenerator( enemyArray, enemyGroup, mgrScore, player, this );
			FlxG.play( BackgroundMusic );
			
			_bullet = new BulletEnergyComponent( this );
			_bullet.create( 30, 5, 60, 15 );
		}
		private function weaponEmpty( event:Event ):void
		{
			player.flightGetWeapon( BaseWeapon.WEAPON_TYPE_DEFAULT );
		}
		private function playerGetWeapon( event:EventPlayerGetWeapon ):void
		{
			var weaponType:int = event.weaponType;
			_bullet.updateBullet = true;
			_bullet.maxTime = event.weaponTime;
		}
		private function CreateBackground():void
		{
			_backgroundSprite = new FlxSprite( 0, 0 );
			_backgroundSprite.loadGraphic( backgroundPicture, true, true, 600, 600 );
			
			_backgroundSprite.drag.x = 2;
			_backgroundSprite.drag.y = 1;
			_speedBackGround = _backgroundSprite.drag.x;
			
			_backgroundSprite.maxVelocity.x = 100;
			_backgroundSprite.maxVelocity.y = 100;
			add( _backgroundSprite );
		}
		private function enemyCollidePlayer( flxobj1:FlxObject, flxobj2:FlxObject ):void
		{
			if ( flxobj1 is PlayerFlight )
			{
				_gameStatus = GameStatusConst.GAME_STATUS_OVER;
			}
		}
		override public function update():void
		{
			super.update();
			if ( _gameStatus == GameStatusConst.GAME_STATUS_RUN )
			{
				FlxG.collide( playerGroup, enemyGroup , enemyCollidePlayer );
				weaponPackage.update();
				player.updateFlight();
				_playerCheck.update();
				for each( var enemyFlight:BaseFlight in enemyArray )
				{
					enemyFlight.updateFlight();
				}
				if ( _backgroundSprite.y < -330 )
				{
					_backgroundSprite.y = 0;
				}
				_backgroundSprite.y -= _speedBackGround;
				
				_enemyGenerator.update();
			}
			else if( _gameStatus == GameStatusConst.GAME_STATUS_OVER )
			{
				for each( var enemyFlightStop:BaseFlight in enemyArray )
				{
					enemyFlightStop.gameStop();
				}
				player.gameStop();
				scoreItem = new ScoreInputItem( this, int(_scoreBill.text) );
				_gameStatus = GameStatusConst.GAME_STATUS_INPUT_NAME;
			}
			
			
			_bullet.update();
		}
		
		private function enemyExploded( event:EventEnemyExploded ):void
		{
			var enemyScore:ScoreSprite = new ScoreSprite(this, event.enemyPosX, event.enemyPosY, 50, event.enemyScore );
		}
		private function enemyScoreOver( event:EventEnemyScoreOver ):void
		{
			this.remove( event.scoreText );
			event.scoreText = null; 
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		private function getWeaponTrig( flxobj1:FlxObject, flxobj2:FlxObject ):void
		{
			if ( flxobj1 is WeaponInstance )
			{
				var weaponIns1:WeaponInstance = flxobj1 as WeaponInstance;
				player.flightGetWeapon( weaponIns1.weaponType );
				remove( flxobj1 );
				weaponIns1 = null;
			}
		}
	}

}