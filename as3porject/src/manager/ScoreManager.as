package manager 
{
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
		}
		
	}

}