package state 
{
	import bullet.PlayerBulletCheck;
	import bullet.WeaponInstance;
	import bullet.WeaponPackage;
	import dispatcher.GlobalDispatcher;
	import flight.BaseFlight;
	import flight.EnemyFlightGenerator;
	import flight.NormalEnemyFlight;
	import flight.PlayerFlight;
	import kale.KaleiTextFormatConst;
	import letter_event.EventEnemyExploded;
	import letter_event.EventEnemyScoreOver;
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
		[Embed(source = "../../res/sound/Hit_Hurt15.mp3")] private var SoundEffect:Class;
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
			
			player = new PlayerFlight( this, _bulletGroup, 17, 17 );
			
			weaponPackage = new WeaponPackage(this, weaponGroup, playerGroup, fontallPicture, player);
			
			_playerCheck = new PlayerBulletCheck( _bulletGroup, enemyGroup, this );
			
			add( player );
			playerGroup.add( player );
			
			_scoreBill = new ScoreBillBoard( 0, 0, 100, "" );
			add( _scoreBill );
			
			_enemyGenerator = new EnemyFlightGenerator( enemyArray, enemyGroup, mgrScore, player, this );
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
		
		override public function update():void
		{
			super.update();
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