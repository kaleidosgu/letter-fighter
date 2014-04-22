package state 
{
	import bullet.BaseBullet;
	import bullet.BaseWeapon;
	import bullet.WeaponInstance;
	import dispatcher.GlobalDispatcher;
	import flight.BaseEnemyFlight;
	import flight.BaseFlight;
	import flight.EnemyFlightGenerator;
	import flight.EnemyWeakFollowFlight;
	import flight.NormalEnemyFlight;
	import kale.fileUtil.KaleResourceDataRead;
	import kale.fileUtil.KaleTxtResourcePath;
	import letter_event.EventEnemyExploded;
	import letter_event.EventEnemyScoreOver;
	import flight.PlayerFlight;
	import manager.ScoreManager;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	import sceneobj.ScoreSprite;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameTestState extends FlxState 
	{
		private var enemy:FlxSprite;
		private var mgrScore:ScoreManager = new ScoreManager();
		private var enemyArray:Array = new Array();
		
		private var player:PlayerFlight;
		
		private var enemyGenerator:EnemyFlightGenerator = null;
		private var _enemyGroup:FlxGroup = new FlxGroup();
		public function GameTestState() 
		{
		}
		
		override public function update():void
		{
			super.update();
			player.updateFlight();
			for each( var enemyFlight:BaseFlight in enemyArray )
			{
				enemyFlight.updateFlight();
			}
			
			
			if ( FlxG.keys.justReleased("T" ) )
			{
				var enemyAdded:EnemyWeakFollowFlight = new EnemyWeakFollowFlight(mgrScore, this, 30, 100);			
				enemyAdded.playerFlight = player;
				add( enemyAdded );
				enemyArray.push ( enemyAdded );
			}
			
			enemyGenerator.update();
		}
		
		override public function create():void
		{
			super.create();
			
			player = new PlayerFlight( this, null, 17, 17 );
			add( player );
			
			enemyGenerator = new EnemyFlightGenerator( enemyArray, _enemyGroup, mgrScore, player, this );
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
	}

}