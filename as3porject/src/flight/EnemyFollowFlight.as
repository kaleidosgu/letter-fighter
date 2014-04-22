package flight 
{
	import manager.ScoreManager;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EnemyFollowFlight extends BaseEnemyFlight 
	{
		
		public function EnemyFollowFlight(mgr:ScoreManager, state:FlxState,X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super( mgr, state, X, Y, SimpleGraphic );
		}
		
	}

}