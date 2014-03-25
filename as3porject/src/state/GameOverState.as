package state 
{
	import component.GameOverScoreItem;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameOverState extends FlxState 
	{
		private var _systemNotify:FlxText = null;
		//private var _systemText:String = "Game Over";
		private var _systemText:String = "1.      tsaoyi			10000";
		public function GameOverState() 
		{
			
		}
		override public function create():void
		{
			super.create();
			
			for ( var indexName:int = 1; indexName < 6; indexName++ )
			{
				var nameLine:GameOverScoreItem = new GameOverScoreItem();
				nameLine.setPos ( 0, 10 + 20 * indexName );
				nameLine.setScore( 100 * indexName );
				nameLine.setNameText( indexName, "bla" );
				add( nameLine );
			}
		}
		
		override public function update():void
		{
			super.update();
			if ( FlxG.keys.justReleased("SPACE" ) )
			{
				//FlxG.switchState(new PlayState());
			}
		}
		override public function destroy():void
		{
			super.destroy();
			
			_systemNotify = null;
		}
	}

}