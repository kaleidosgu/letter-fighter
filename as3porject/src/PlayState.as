package
{
	import flash.display.BlendMode;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import org.flixel.*;
	import flash.filesystem.File;

	public class PlayState extends FlxState
	{	
		[Embed(source = "../res/image/spaceman.png")] private static var ImgSpaceman:Class;
		[Embed(source = "../res/sound/Hit_Hurt15.mp3")] private var SoundEffect:Class;
		[Embed(source = "../res/image/bullet.png")] private static var bulletPicture:Class;
		
		// Some static constants for the size of the tilemap tiles
		private const TILE_WIDTH:uint = 8;
		private const TILE_HEIGHT:uint = 8;
		
		private var _showWidth:uint = 0;
		private var _showHeight:uint = 0;
		private var _showScale:uint = 2;
		
		private var _textNotify:FlxText = null;
		private var _systemNotify:FlxText = null;
		
		private var _systemText:String = "System:"
		private var highlightBox:FlxObject;
		
		private var player:FlxSprite;
		
		private var _bulletArray:Array = new Array();
		public function PlayState()
		{
			
		}
		
		override public function create():void
		{
			_showWidth 	= TILE_WIDTH * _showScale ;
			_showHeight	= TILE_HEIGHT * _showScale;
			FlxG.framerate = 50;
			FlxG.flashFramerate = 50;
			
			highlightBox = new FlxObject(0, 0, _showWidth, _showHeight);
			
			setupPlayer();
			setupText();
		}

		override public function update():void
		{	
			var hightLightPoint:FlxPoint = getHightLightBoxPoint();
			highlightBox.x = hightLightPoint.x;
			highlightBox.y = hightLightPoint.y;
			
			updatePlayer();
			destroyBulletIfOutOfBound();
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
			var newBullet:FlxSprite = new FlxSprite( initX, initY );
			newBullet.loadGraphic(bulletPicture, true, true, 8);
			
			newBullet.width = 8;
			newBullet.height = 8;
			newBullet.offset.x = 1;
			newBullet.offset.y = 1;
			
			//basic player physics
			newBullet.drag.x = 640;
			newBullet.drag.y = 640;
			//player.acceleration.y = 420;
			newBullet.maxVelocity.x = 80;
			newBullet.maxVelocity.y = 160;
			newBullet.acceleration.y -= newBullet.drag.y;
			
			add(newBullet);
			_bulletArray.push ( newBullet );
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
		private function setupPlayer():void
		{
			player = new FlxSprite(128, 128);
			player.loadGraphic(ImgSpaceman, true, true, 16);
			
			//bounding box tweaks
			player.width = 14;
			player.height = 14;
			player.offset.x = 1;
			player.offset.y = 1;
			
			//basic player physics
			player.drag.x = 640;
			player.drag.y = 640;
			//player.acceleration.y = 420;
			player.maxVelocity.x = 240;
			player.maxVelocity.y = 240;
			
			//animations
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [1, 2, 3, 0], 12);
			player.addAnimation("jump", [4]);
			
			add(player);
		}
		private function updatePlayer():void
		{
			playerBoundMap();
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
				generateBullet( player.x + player.width / 2, player.y );
			}
		}
		
		private function playerBoundMap():void
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
