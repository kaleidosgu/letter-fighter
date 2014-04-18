package state 
{
	import bullet.BaseBullet;
	import bullet.BaseWeapon;
	import bullet.PlayerBulletCheck;
	import bullet.WeaponInstance;
	import bullet.WeaponPackage;
	import dispatcher.GlobalDispatcher;
	import flight.BaseEnemyFlight;
	import flight.BaseFlight;
	import flight.NormalEnemyFlight;
	import kale.fileUtil.KaleResourceDataRead;
	import kale.fileUtil.KaleTxtResourcePath;
	import letter_event.EventEnemyExploded;
	import letter_event.EventEnemyScoreOver;
	import flight.PlayerFlight;
	import manager.ScoreManager;
	import manager.UserDataManager;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import sceneobj.ScoreBillBoard;
	import sceneobj.ScoreSprite;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameTestState extends FlxState 
	{
		[Embed(source = "../../res/image/fighter2.png")] private static var ImgFighter:Class;
		[Embed(source = "../../res/image/enemy/fontall.png")] private static var fontallPicture:Class;
		private var player:PlayerFlight;
		private var enemy:FlxSprite;
		private var playerGroup:FlxGroup;
		private var enemyGroup:FlxGroup;
		private var weaponGroup:FlxGroup;
		private var _bulletGroup:FlxGroup;	
		private var weaponPackage:WeaponPackage = null;
		private var MAX_TILE_BLOCK_NUM:int = 15;
		private var MIN_TILE_BLOCK_NUM:int = 10;
		private var mgrScore:ScoreManager = new ScoreManager();
		private var enemyArray:Array = new Array();
		private var _playerCheck:PlayerBulletCheck = null;
		
		private var _scoreBill:ScoreBillBoard = null;
				
		public function GameTestState() 
		{
		}
		
		override public function update():void
		{
			super.update();
			player.updateFlight();
			weaponPackage.update();
			
			if ( FlxG.keys.justReleased("T" ) )
			{
				var eventExploded:EventEnemyExploded = new EventEnemyExploded( EventEnemyExploded.EVENT_ENEMY_EXPLODED );
				
				eventExploded.enemyPosX = Math.random() * FlxG.width;
				eventExploded.enemyPosY = Math.random() * FlxG.height;
				eventExploded.enemyScore = Math.random() * 100;
				GlobalDispatcher.getIns().dispatchEvent( eventExploded ); 
			}
			
			for each( var enemyFlight:BaseFlight in enemyArray )
			{
				enemyFlight.updateFlight();
			}
			
			_playerCheck.update();
		}
		
		override public function create():void
		{
			super.create();
			
			_bulletGroup = new FlxGroup();
			
			player = new PlayerFlight( this, _bulletGroup, 17, 17 );
			add( player );
			
			
			playerGroup = new FlxGroup();
			playerGroup.add( player );
			
			enemy = new NormalEnemyFlight(mgrScore, this,30, 100);
			enemyGroup = new FlxGroup();
			enemyGroup.add( enemy );
			
			enemyArray.push ( enemy );
			
			weaponGroup = new FlxGroup();
			
			weaponPackage = new WeaponPackage(this, weaponGroup, playerGroup, fontallPicture, getWeaponTrig );
						
			GlobalDispatcher.getIns().addEventListener( EventEnemyExploded.EVENT_ENEMY_EXPLODED, enemyExploded );
			GlobalDispatcher.getIns().addEventListener( EventEnemyScoreOver.EVENT_ENEMY_SCORE_OVER, enemyScoreOver );
				
			_playerCheck = new PlayerBulletCheck( _bulletGroup, enemyGroup, enemyCollideBullet);
			
			_scoreBill = new ScoreBillBoard( 0, 0, 100, "" );
			add( _scoreBill );
			
			
			UserDataManager.getIns().generateUserData( );
			UserDataManager.getIns().scoreProcess( 300000, "fafafa" );
		}
		
		private function enemyCollideBullet( flxobj1:FlxObject, flxobj2:FlxObject ):void
		{
			if ( flxobj2 is BaseFlight )
			{
				var baseFlight:BaseFlight = flxobj2 as BaseFlight;
				baseFlight.exploded();
			}
			this.remove( flxobj1 );
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
		private function collide( obj1:FlxObject, obj2:FlxObject ):void
		{
			var kaka:int = 0;
			trace("dfdfd");
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
	}

}