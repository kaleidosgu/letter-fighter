package state 
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameOverState extends FlxState 
	{
		private var _systemNotify:FlxText = null;
		private var _systemText:String = "Game Over";
		public function GameOverState() 
		{
			
		}
		override public function create():void
		{
			super.create();
			
			_systemNotify = new FlxText( 0, 220, 200, _systemText );
			add( _systemNotify );
		}
	}

}