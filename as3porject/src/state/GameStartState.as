package state 
{
	import kale.KaleiTextFormatConst;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameStartState extends FlxState 
	{
		
		private var _gameTitle:FlxText = null;
		private var _gameStartNotify:FlxText = null;
		private var _textAuthor:FlxText = null;
		private var _keyStringStartGame:String = "G";
		private var _numberTickCounts:Number = 2;
		private var _tickStart:Boolean = false;
		private var _arrayTickKey:Array = new Array();
		public function GameStartState() 
		{
			
		}

		override public function create():void
		{
			super.create();
			
			_gameTitle = new FlxText( 0, 15, FlxG.width, "Letter Fight" );
			_gameTitle.alignment = KaleiTextFormatConst.ALIGH_CENTER;
			_gameTitle.size = 20;
			
			_gameStartNotify = new FlxText( 0, 160, FlxG.width, "'" + _keyStringStartGame + "'" + " key start game" );
			_gameStartNotify.alignment = KaleiTextFormatConst.ALIGH_CENTER;
			_gameStartNotify.size = 12;
			
			_textAuthor = new FlxText( 0, 200, 300, "kaleidos gjcaoyi@163.com" );
			_textAuthor.alignment = KaleiTextFormatConst.ALIGH_RIGHT;
			_textAuthor.size = 16;
			
			add( _gameTitle );
			add( _gameStartNotify );
			add( _textAuthor );
			
			for ( var tickKey:Number = _numberTickCounts; tickKey >= 0; )
			{
				_arrayTickKey.push( tickKey );
				tickKey = tickKey - 0.3; 
			}
		}
		
		override public function update():void
		{
			super.update();
			if ( FlxG.keys.justReleased(_keyStringStartGame) )
			{
				_tickStart = true;
			}
			if ( _tickStart )
			{
				_numberTickCounts -= FlxG.elapsed;
				
				if ( _arrayTickKey.length > 0 )
				{
					var currentKey:Number = _arrayTickKey[0];
					if ( currentKey > _numberTickCounts )
					{
						_arrayTickKey.splice(0, 1);
						_gameStartNotify.visible = !_gameStartNotify.visible;
					}
				}
				if ( _numberTickCounts < 0 )
				{
					FlxG.switchState(new PlayState());
				}
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			_gameTitle = null;
			_gameStartNotify = null;
			_textAuthor = null;
		}
	}

}