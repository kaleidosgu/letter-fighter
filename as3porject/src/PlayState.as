package
{
	import flash.display.BlendMode;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import org.flixel.*;
	import flash.filesystem.File;
	import state.GameOverState;

	public class PlayState extends FlxState
	{	
		[Embed(source = "../res/image/fighter2.png")] private static var ImgFighter:Class;
		[Embed(source = "../res/sound/Hit_Hurt15.mp3")] private var SoundEffect:Class;
		[Embed(source = "../res/music/kraftwerk_aerodynamik.mp3")] private var BackgroundMusic:Class;
		[Embed(source = "../res/image/bullet3.png")] private static var bulletPicture:Class;
		[Embed(source = "../res/image/startcloud3.png")] private static var backgroundPicture:Class;
		//[Embed(source = "../res/image/enemy/enemyA.png")] private static var enemyPicture:Class;
		[Embed(source = "../res/image/enemy/fontall.png")] private static var fontallPicture:Class;
		
		
		// Some static constants for the size of the tilemap tiles
		private const TILE_WIDTH:uint = 8;
		private const TILE_HEIGHT:uint = 8;
		
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _showScale:uint = 2;
		
		private var _textNotify:FlxText = null;
		private var _systemNotify:FlxText = null;
		
		private var _systemText:String = "Music by Kraftwerk Aerodynamik";
		private var highlightBox:FlxObject;
		
		private var player:FlxSprite;
		
		private var _bulletArray:Array = new Array();
		private var _objectKeyString:Object = new Object();
		private var _backgroundSprite:FlxSprite;
		private var _speedBackGround:Number = 0;
		private var enemy:FlxSprite;
		public function PlayState()
		{
			
		}
		
		override public function create():void
		{
			_objectKeyString["H"] = "H";
			_objectKeyString["L"] = "L";
			_objectKeyString["O"] = "O";
			_objectKeyString["V"] = "V";
			_objectKeyString["X"] = "X";
			_objectKeyString["Y"] = "Y";
			_objectKeyString["Z"] = "Z";
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
			FlxG.framerate = 50;
			FlxG.flashFramerate = 50;
			
			highlightBox = new FlxObject(0, 0, _showWidth, _showHeight);

			_backgroundSprite = new FlxSprite( 0, 0 );
			_backgroundSprite.loadGraphic( backgroundPicture, true, true, 600, 600 );
			
			_backgroundSprite.drag.x = 2;
			_backgroundSprite.drag.y = 1;
			_speedBackGround = _backgroundSprite.drag.x;
			
			_backgroundSprite.maxVelocity.x = 100;
			_backgroundSprite.maxVelocity.y = 100;
			add( _backgroundSprite );
			
			
			enemy = new FlxSprite( 0, 0 );
			enemy.loadGraphic( fontallPicture, true, true, 12 );
			enemy.width 	= 12;
			enemy.height	= 12;
			enemy.addAnimation( "abc", [0,1, 2, 3, 4, 5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 3 );
			//enemy.frame = 3;
			
			add( enemy );
			
			setupPlayer();
			setupText();
			
			//FlxG.play( BackgroundMusic );
		}

		override public function update():void
		{	
			var hightLightPoint:FlxPoint = getHightLightBoxPoint();
			highlightBox.x = hightLightPoint.x;
			highlightBox.y = hightLightPoint.y;
			
			updatePlayer();
			destroyBulletIfOutOfBound();
			bulletTypeChangeCheck();
			if ( _backgroundSprite.y < -330 )
			{
				_backgroundSprite.y = 0;
			}
			_backgroundSprite.y -= _speedBackGround;
			enemy.play("abc");
			super.update();
		}
		private function getHightLightBoxPoint():FlxPoint
		{
			var flxPoint:FlxPoint = new FlxPoint();
			flxPoint.x = Math.floor(FlxG.mouse.x / _showWidth) * _showWidth;
			flxPoint.y = Math.floor(FlxG.mouse.y / _showHeight) * _showHeight;
			return flxPoint;
		}
		public override function draw():void
		{
			super.draw();
			highlightBox.drawDebug();
		}
		private function setupText():void
		{
			_textNotify = new FlxText( 0, 200, 200, "Press J to save data." );
			add( _textNotify );
			_systemNotify = new FlxText( 0, 220, 200, _systemText );
			add( _systemNotify );
		}
		
		private function generateBullet( initX:Number, initY:Number ):void
		{
			var newBullet:FlxSprite = new FlxSprite( 0, 0 );
			newBullet.loadGraphic(bulletPicture, false, false, 4,10);
			
			newBullet.width = 4;
			newBullet.height = 10;
			newBullet.offset.x = 1;
			newBullet.offset.y = 1;
			
			//basic player physics
			newBullet.drag.x = 640;
			newBullet.drag.y = 640;
			newBullet.maxVelocity.x = 80;
			newBullet.maxVelocity.y = 160;
			newBullet.acceleration.y -= newBullet.drag.y;
			
			add(newBullet);
			_bulletArray.push ( newBullet );
			newBullet.x = initX;
			newBullet.y = initY - newBullet.height / 2;
		}
		private function checkBulletBound( bullet:FlxSprite ):Boolean
		{
			var bResult:Boolean = false;
			if ( bullet.y < 0 )
			{
				bResult = true;
			}
			if ( bullet.x < 0 )
			{
				bResult = true;
			}
			if ( bullet.y > FlxG.height )
			{
				bResult = true;
			}
			if ( bullet.x > FlxG.width )
			{
				bResult = true;
			}
			return bResult;
		}
		
		private function destroyBulletIfOutOfBound( ):void
		{
			var bulletIndex:int = 0;
			for each( var bullet:FlxSprite in _bulletArray )
			{
				var bResult:Boolean = checkBulletBound ( bullet );
				if ( bResult == true )
				{
					_bulletArray.splice( bulletIndex, bulletIndex + 1 );
					break;
				}
				bulletIndex++;
			}
		}
		private function bulletTypeChangeCheck():void
		{
			var typeString:String = "";
			for ( var strKey:String in _objectKeyString )
			{
				var strValue:String = _objectKeyString[strKey];
				
				if ( FlxG.keys.justReleased( strValue ) )
				{
					typeString = strValue;
					break;
				}
			}
			if ( typeString.length > 0 )
			{
				_textNotify.text = "[" + typeString + "] key has equiped!";	
			}
		}
		private function setupPlayer():void
		{
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
			
			add(player);
		}
		private function updatePlayer():void
		{
			playerBoundRest();
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
			
			if ( FlxG.keys.justReleased("SPACE" ) )
			{
				FlxG.play( SoundEffect );	
				//generateBullet( player.x + player.width / 2 - 1, player.y );
				FlxG.switchState(new GameOverState());
			}
		}
		
		private function playerBoundRest():void
		{
			var playerX:Number = player.x;
			var playerY:Number = player.y;
			var screenWidth:uint = FlxG.width;
			var screenHeight:uint = FlxG.height;
			if ( playerX < 0 )
			{
				player.x = screenWidth;
			}
			if ( playerX > screenWidth )
			{
				player.x = 0;
			}
			if ( playerY < 0 )
			{
				player.y = screenHeight;
			}
			if ( playerY > screenWidth )
			{
				player.y = 0;
			}
		}
	}
}
