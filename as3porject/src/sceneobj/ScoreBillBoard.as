package sceneobj 
{
	import dispatcher.GlobalDispatcher;
	import kale.KaleiTextFormatConst;
	import letter_event.PlayerGetScoreEvent;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class ScoreBillBoard extends FlxText
	{
		
		public function ScoreBillBoard(X:Number, Y:Number, Width:uint, Text:String=null, EmbeddedFont:Boolean=true)
		{
			super( 0, 0, FlxG.width, Text, EmbeddedFont );
			this.alignment = KaleiTextFormatConst.ALIGH_CENTER;
			this.size = 16;
			this.text = "0";
			GlobalDispatcher.getIns().addEventListener( PlayerGetScoreEvent.PLAYER_GET_SCORE, getScoreEvent );
		}
		
		private function getScoreEvent( event:PlayerGetScoreEvent ):void
		{
			this.text = event.scoreValue.toString();
		}
		
		override public function destroy():void
		{
			super.destroy();
			GlobalDispatcher.getIns().removeEventListener( PlayerGetScoreEvent.PLAYER_GET_SCORE, getScoreEvent );
		}
		
		
	}

}