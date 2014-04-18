package flight 
{
	import flight.BaseEnemyFlight;
	import manager.ScoreManager;
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class NormalEnemyFlight extends BaseEnemyFlight 
	{
		
		public function NormalEnemyFlight(mgr:ScoreManager, state:FlxState,X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super( mgr, state, X, Y, SimpleGraphic );
			enemyScore = 5;
		}
		
		override public function exploded():void
		{
			super.exploded();
		}

		override public function updateFlight():void
		{
			super.updateFlight();
			acceleration.x = 0;
			acceleration.y = 0;
			//acceleration.x -= drag.x;
		}
	}

}