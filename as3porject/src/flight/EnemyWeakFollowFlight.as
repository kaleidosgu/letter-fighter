package flight 
{
	import manager.ScoreManager;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class EnemyWeakFollowFlight extends EnemyFollowFlight 
	{
		
		public function EnemyWeakFollowFlight(mgr:ScoreManager, state:FlxState,X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super( mgr, state, X, Y, SimpleGraphic );
		}
		
		override public function updateFlight():void
		{
			super.updateFlight();
			if ( playerFlight != null )
			{				
				var posX:Number = playerFlight.x;
				var posY:Number = playerFlight.y;
				var acceX:Number = 0;
				var acceY:Number = 0;
				if ( posX > this.x )
				{
					acceX = _velocityX;
				}
				else if ( posX < this.x )
				{
					acceX = -_velocityX;
				}
				
				if ( posY > this.y )
				{
					acceY = _velocityY;
				}
				else if ( posY < this.y )
				{
					acceY = -_velocityY;
				}
				
				this.acceleration.x = acceX;
				this.acceleration.y = acceY;
			}
		}
	}

}