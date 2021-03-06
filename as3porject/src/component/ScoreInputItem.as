package component 
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import manager.UserDataManager;
	import state.GameOverState;
	import kale.KaleiTextFormatConst;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class ScoreInputItem 
	{
		
		private var scoreText:FlxText;
		private var notifyText:FlxText;
		private var _lastCharCode:uint = 0;
		private var _currentScore:int = 30;
		public function ScoreInputItem( stateFlx:FlxState, currentScore:int ) 
		{
			scoreText = new FlxText( 0, 100, FlxG.width, "" );
			scoreText.alignment = KaleiTextFormatConst.ALIGH_CENTER;
			scoreText.size = 14;
			
			notifyText = new FlxText( 0, 80, FlxG.width, "Game is over. Enter your name..." );
			notifyText.alignment = KaleiTextFormatConst.ALIGH_CENTER;
			notifyText.size = 14;
			
			stateFlx.add( scoreText );
			stateFlx.add( notifyText );
			
			FlxG.stage.addEventListener( KeyboardEvent.KEY_DOWN, keyBoardDown );
			FlxG.stage.addEventListener( KeyboardEvent.KEY_UP, keyBoardUP );
			_currentScore = currentScore;
		}
		private function keyBoardDown( event:KeyboardEvent ):void
		{
			_lastCharCode = event.charCode;	
		}
		
		private function enterName( stringName:String ):void
		{
			UserDataManager.getIns().generateUserData();
			UserDataManager.getIns().scoreProcess( _currentScore, stringName );
			FlxG.switchState ( new GameOverState() );
		}
		
		private function keyBoardUP( event:KeyboardEvent ):void
		{
			if ( _lastCharCode > 0 && _lastCharCode == event.charCode )
			{
				var charString:String = String.fromCharCode(_lastCharCode);
				scoreText.text = scoreText.text + charString;
				_lastCharCode = 0;
			}
			
			if ( event.keyCode == Keyboard.ENTER )
			{
				FlxG.stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyBoardDown );
				FlxG.stage.removeEventListener( KeyboardEvent.KEY_UP, keyBoardUP );
				enterName( scoreText.text );
			}
		}
		public function destroy():void
		{
			FlxG.stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyBoardDown );
			FlxG.stage.removeEventListener( KeyboardEvent.KEY_UP, keyBoardUP );
		}
		
	}

}