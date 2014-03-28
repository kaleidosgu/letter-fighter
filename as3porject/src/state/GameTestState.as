package state 
{
	import bullet.BaseBullet;
	import bullet.BaseWeapon;
	import bullet.WeaponInstance;
	import bullet.WeaponPackage;
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
		[Embed(source = "../../res/image/bullet3.png")] private static var bulletPicture:Class;
		[Embed(source = "../../res/image/fighter2.png")] private static var ImgFighter:Class;
		[Embed(source = "../../res/image/enemy/fontall.png")] private static var fontallPicture:Class;
		private var player:FlxSprite;
		private var enemy:FlxSprite;
		private var playerGroup:FlxGroup;
		private var enemyGroup:FlxGroup;
		private var weaponGroup:FlxGroup;
		private var _bullet:BaseBullet;
		
		private var _weapon:BaseWeapon;
		private var weaponPackage:WeaponPackage = null;
		public function GameTestState() 
		{
			
		}
		
		override public function update():void
		{
			super.update();
			
			if ( FlxG.keys.justReleased("SPACE" ) )
			{
				_weapon.fire( bulletPicture, 105, 105 );
				//generateBullet( FlxG.width / 2 , FlxG.height / 2, true );
				//generateBullet( FlxG.width / 2 , FlxG.height / 2, false );
			}
			updatePlayer();
			//FlxG.collide( enemyGroup, playerGroup , collide );
			weaponPackage.update();
		}
		
		override public function create():void
		{
			super.create();
			_weapon = new BaseWeapon();
			_weapon.addState = this;
			_weapon.weaponType = BaseWeapon.WEAPON_TYPE_X;
			_bullet = new BaseBullet();
			
			player = new FlxSprite(17, 17);
			player.loadGraphic(ImgFighter, true, true, 17,20);
			
			//bounding box tweaks
			player.width = 17;
			player.height = 20;
			player.offset.x = 1;
			player.offset.y = 1;
			
			//basic player physics
			player.drag.x = 640;
			player.drag.y = 640;
			//player.acceleration.y = 420;
			player.maxVelocity.x = 200;
			player.maxVelocity.y = 200;
			
			//animations
			player.addAnimation("flying", [0, 1], 40);
			player.play("flying");
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
			
			//basic player physics
			enemy.drag.x = 640;
			enemy.drag.y = 640;
			//player.acceleration.y = 420;
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
				if ( weaponIns1.weaponType == BaseWeapon.WEAPON_TYPE_I )
				{
					player.color = 0xff0000;
				}
				else if ( weaponIns1.weaponType == BaseWeapon.WEAPON_TYPE_X )
				{
					player.color = 0x00ff00;
				}
				else if ( weaponIns1.weaponType == BaseWeapon.WEAPON_TYPE_Y )
				{
					player.color = 0x0000ff;
				}
				remove( flxobj1 );
				weaponIns1 = null;
			}
			else if ( flxobj2 is WeaponInstance )
			{
				var weaponIns2:WeaponInstance = flxobj2 as WeaponInstance;
				remove( flxobj2 );
				weaponIns2 = null;
			}
		}
		private function collide( obj1:FlxObject, obj2:FlxObject ):void
		{
			var kaka:int = 0;
			trace("dfdfd");
		}
		private function updatePlayer():void
		{
			player.acceleration.x = 0;
			player.acceleration.y = 0;
			if(FlxG.keys.LEFT)
			{
				player.acceleration.x -= player.drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				player.acceleration.x += player.drag.x;
			}
			
			if (FlxG.keys.UP)
			{
				player.acceleration.y -= player.drag.y;
			}
			else if (FlxG.keys.DOWN)
			{
				player.acceleration.y += player.drag.y;
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		private function generateBullet( initX:Number, initY:Number, flip:Boolean ):void
		{
			var newBullet:FlxSprite = new FlxSprite( 0, 0 );
			newBullet.loadGraphic(bulletPicture, false, false, 4,10);
			
			newBullet.width = 4;
			newBullet.height = 10;
			newBullet.offset.x = 1;
			newBullet.offset.y = 1;
			
			if ( flip )
			{
				newBullet.velocity.y = -500;
				newBullet.velocity.x = -1000;	
			}
			else
			{
				newBullet.velocity.y = -500;
				newBullet.velocity.x = 1000;
			}
			newBullet.maxVelocity.x = 160;
			newBullet.maxVelocity.y = 160;
			newBullet.acceleration.y -= newBullet.drag.y;
			
			add(newBullet);
			newBullet.x = initX;
			newBullet.y = initY - newBullet.height / 2;
		}
		
	}

}