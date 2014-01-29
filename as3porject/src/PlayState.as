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
			
			//setupPlayer();
			setupText();
		}

		override public function update():void
		{	
			var hightLightPoint:FlxPoint = getHightLightBoxPoint();
			highlightBox.x = hightLightPoint.x;
			highlightBox.y = hightLightPoint.y;
			
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
		
		private function wrap(obj:FlxObject):void
		{
			obj.x = (obj.x + obj.width / 2 + FlxG.width) % FlxG.width - obj.width / 2;
			obj.y = (obj.y + obj.height / 2) % FlxG.height - obj.height / 2;
		}
	}
}
