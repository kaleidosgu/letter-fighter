package flight 
{
	import flight.BaseEnemyFlight;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class NormalEnemyFlight extends BaseEnemyFlight 
	{
		
		public function NormalEnemyFlight() 
		{
			
		}
		
		override public function exploded():void
		{
			super.exploded();
			_scoreManager.addScore( 5 );
		}
		
	}

}