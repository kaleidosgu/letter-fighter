package manager 
{
	import dispatcher.GlobalDispatcher;
	import letter_event.PlayerGetScoreEvent;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class ScoreManager 
	{
		private var _totalScore:int = 0;
		public function ScoreManager() 
		{
			
		}
		
		public function addScore( scoreValue:int ):void
		{
			_totalScore += scoreValue;
			
			var eventGetScore:PlayerGetScoreEvent = new PlayerGetScoreEvent( PlayerGetScoreEvent.PLAYER_GET_SCORE );
			eventGetScore.scoreValue = _totalScore;
			GlobalDispatcher.getIns().dispatchEvent( eventGetScore ); 
		}
		
	}

}