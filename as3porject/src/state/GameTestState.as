package state 
{
	import bullet.BaseBullet;
	import bullet.BaseWeapon;
	import bullet.WeaponInstance;
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
		[Embed(source = "../../res/image/fighter2.png")] private static var ImgFighter:Class;
		[Embed(source = "../../res/image/enemy/fontall.png")] private static var fontallPicture:Class;
		private var enemy:FlxSprite;
		private var enemyGroup:FlxGroup;
		private var mgrScore:ScoreManager = new ScoreManager();
		private var enemyArray:Array = new Array();
		
		public function GameTestState() 
		{
		}
		
		override public function update():void
		{
			super.update();
			for each( var enemyFlight:BaseFlight in enemyArray )
			{
				enemyFlight.updateFlight();
			}
		}
		
		override public function create():void
		{
			super.create();
			
			
			enemy = new NormalEnemyFlight(mgrScore, this,30, 100);
			enemyGroup = new FlxGroup();
			enemyGroup.add( enemy );
			
			enemyArray.push ( enemy );
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
	}

}