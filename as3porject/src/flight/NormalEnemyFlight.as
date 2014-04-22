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
		private var _update:Boolean = false;
		public function NormalEnemyFlight(mgr:ScoreManager, state:FlxState,X:Number=0,Y:Number=0,SimpleGraphic:Class=null) 
		{
			super( mgr, state, X, Y, SimpleGraphic );
			enemyScore = 5;
			
			this.maxVelocity.x = 50;
			this.maxVelocity.y = 50;
		}
		
		override public function exploded():void
		{
			super.exploded();
		}

		override public function updateFlight():void
		{
			super.updateFlight();
			if ( _update == false && playerFlight != null )
			{
				_update = true;
				
				var posX:Number = playerFlight.x;
				var posY:Number = playerFlight.y;
				
				var diffX:Number = posX - this.x;
				var diffY:Number = posY - this.y;
				
				if ( diffX < 0 )
				{
					diffX = 0 - diffX;
				}
				if ( diffY < 0 )
				{
					diffY = 0 - diffY;
				}
				var allDiff:Number = diffX + diffY;
				if ( allDiff > 0 )
				{
					_velocityX = _velocityX * diffX / allDiff;
					_velocityY = _velocityY * diffY / allDiff;
					
					if ( this.x > playerFlight.x )
					{
						_velocityX = 0 - _velocityX;
					}
					if ( this.y > playerFlight.y )
					{
						_velocityY = 0 - _velocityY;
					}
					this.acceleration.x = _velocityX;
					this.acceleration.y = _velocityY;	
				}
			}
		}
	}

}