package sceneobj 
{
	import dispatcher.GlobalDispatcher;
	import letter_event.EventEnemyExploded;
	import letter_event.EventEnemyScoreOver;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class ScoreSprite extends FlxText 
	{
		private var _tickConstCount:Number = 0.03;
		private var _tickCount:Number = _tickConstCount;
		private var _arrayColor:Array = new Array();
		private var _indexColor:int = 0;
		private var _state:FlxState = null;
		private var _loopCounts:int = 0;
		public function ScoreSprite( state:FlxState, X:Number, Y:Number, Width:uint, scoreValue:int , EmbeddedFont:Boolean=true)
		{
			super( X, Y, 50, scoreValue.toString(), EmbeddedFont );
			this.size = 10;
			_state = state;
			_state.add( this );
			_arrayColor.push ( 0xff0000 );
			_arrayColor.push ( 0x0000ff );
			_arrayColor.push ( 0xffffff );
			_arrayColor.push ( 0x00ff00 );
		}
		
		override public function update():void
		{
			super.update();
			_tickCount -= FlxG.elapsed;
			if ( _tickCount <  0)
			{
				_tickCount = _tickConstCount;
				_indexColor++;
				if ( _indexColor >= _arrayColor.length )
				{
					_indexColor = 0;
				}
				var colorValue:Number = _arrayColor[_indexColor];
				this.color = colorValue;
				_loopCounts ++;
				if ( _loopCounts > 12 )
				{
					var event:EventEnemyScoreOver = new EventEnemyScoreOver( EventEnemyScoreOver.EVENT_ENEMY_SCORE_OVER );
					event.scoreText;
					event.scoreText = this;
					GlobalDispatcher.getIns().dispatchEvent( event );
				}
			}
		}
		override public function destroy():void
		{
			super.destroy();
		}
	}

}