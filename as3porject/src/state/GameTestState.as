package state 
{
	import bullet.BaseBullet;
	import bullet.BaseWeapon;
	import bullet.WeaponInstance;
	import bullet.WeaponPackage;
	import flight.PlayerFlight;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
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
		private var _bullet:BaseBullet;	
		private var weaponPackage:WeaponPackage = null;
		private var MAX_TILE_BLOCK_NUM:int = 15;
		private var MIN_TILE_BLOCK_NUM:int = 10;
		public function GameTestState() 
		{
		}
		
		override public function update():void
		{
			super.update();
			player.updatePlayer();
			weaponPackage.update();
		}
		
		override public function create():void
		{
			super.create();
			_bullet = new BaseBullet();
			
			player = new PlayerFlight( this, 17, 17 );
			add( player );
			
			
			playerGroup = new FlxGroup();
			playerGroup.add( player );
			
			enemy = new FlxSprite(100, 100);
			enemy.loadGraphic(ImgFighter, true, true, 17,20);
			
			//bounding box tweaks
			enemy.width = 17;
			enemy.height = 20;
			enemy.offset.x = 1;
			enemy.offset.y = 1;
			
			enemy.drag.x = 640;
			enemy.drag.y = 640;
			
			enemy.maxVelocity.x = 200;
			enemy.maxVelocity.y = 200;
			
			//animations
			enemy.addAnimation("flying", [0, 1], 40);
			enemy.play("flying");
			add(enemy);
			enemyGroup = new FlxGroup();
			enemyGroup.add( enemy );
			
			weaponGroup = new FlxGroup();
			
			weaponPackage = new WeaponPackage(this, weaponGroup,playerGroup,fontallPicture,collideTrigged );
				
		}
		
		private function collideTrigged( flxobj1:FlxObject, flxobj2:FlxObject ):void
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