package state 
{
	import bullet.BaseBullet;
	import bullet.BaseWeapon;
	import bullet.WeaponInstance;
	import component.BulletEnergyComponent;
	import component.ScoreInputItem;
	import dispatcher.GlobalDispatcher;
	import flash.events.KeyboardEvent;
	import flight.BaseEnemyFlight;
	import flight.BaseFlight;
	import flight.EnemyFlightGenerator;
	import flight.EnemyWeakFollowFlight;
	import flight.NormalEnemyFlight;
	import kale.fileUtil.KaleResourceDataRead;
	import kale.fileUtil.KaleTxtResourcePath;
	import kale.KaleiTextFormatConst;
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
		[Embed(source = "../../res/image/bulletSlot.png")] private static var slotPicture:Class;
		private var enemy:FlxSprite;
		private var mgrScore:ScoreManager = new ScoreManager();
		private var enemyArray:Array = new Array();
		
		private var player:PlayerFlight;
		
		private var enemyGenerator:EnemyFlightGenerator = null;
		private var _enemyGroup:FlxGroup = new FlxGroup();
		private var _timeTick:Number = 5;
		private var _nameTextField:FlxText;
		
		private var _lastCharCode:uint = 0;
		
		private var scoreItem:ScoreInputItem = null;
		
		private var _slot:FlxSprite = null;
		
		private var _bullet:BulletEnergyComponent = null;
		
		
		public function GameTestState() 
		{
		}
		
		override public function update():void
		{
			super.update();
			_timeTick -= FlxG.elapsed;
			//if ( _timeTick > 0 )
			if( true )
			{
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
			else
			{
				for each( var enemyStop:BaseFlight in enemyArray )
				{
					enemyStop.gameStop();
				}
			}
			
			_bullet.update();
			
		}
		
		override public function create():void
		{
			super.create();

			player = new PlayerFlight( this, null, 17, 17 );
			add( player );
			
			enemyGenerator = new EnemyFlightGenerator( enemyArray, _enemyGroup, mgrScore, player, this );
			
			scoreItem = new ScoreInputItem( this, 100 );
			
		}
		override public function destroy():void
		{
			super.destroy();
		}
	}

}