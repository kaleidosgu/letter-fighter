package component 
{
	import dispatcher.GlobalDispatcher;
	import letter_event.EventBulletEnergyEmpty;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class BulletEnergyComponent 
	{
		private var _state:FlxState = null;
		
		private var whiteFrame:FlxSprite = null;
		private var blackInterior:FlxSprite = null;
		private var redBar:FlxSprite = null;
		private var _originalWidth:uint = 0;
		
		private var _maxTime:Number = 1;
		
		private var _tickCount:Number = 0.05;
		private var _currentTick:Number = 0;
		private var _currentAllTick:Number = 0;
		private var _updateBullet:Boolean = false;
		public function BulletEnergyComponent( gameState:FlxState ) 
		{
			_state = gameState;
		}
		public function create( posX:Number, posY:Number, width:uint, height:uint ):void
		{
			whiteFrame = new FlxSprite(posX,posY );
			whiteFrame.makeGraphic(width + 2,height + 2); //White frame for the health bar
			whiteFrame.scrollFactor.x = whiteFrame.scrollFactor.y = 0;
			_state.add(whiteFrame);
			 
			blackInterior = new FlxSprite( posX + 1,posY + 1 );
			blackInterior.makeGraphic(width,height,0xff000000); //Black interior, 48 pixels wide
			blackInterior.scrollFactor.x = blackInterior.scrollFactor.y = 0;
			_state.add(blackInterior);
			 
			redBar = new FlxSprite(posX + 1,posY + 1 );
			redBar.makeGraphic(1,height,0xffff0000); //The red bar itself
			redBar.scrollFactor.x = redBar.scrollFactor.y = 0;
			redBar.origin.x = redBar.origin.y = 0; //Zero out the origin
			_state.add(redBar);
			_originalWidth = width;
			redBar.scale.x = _originalWidth;
		}
		
		private function updateBulletEnergy( current:Number, max:Number ):void
		{
			if ( max > 0 )
			{
				current = current > max ? max : current;
				var percent:Number = current / max;
				redBar.scale.x = _originalWidth - percent * _originalWidth;
			}
		}
		public function destroy():void
		{
			_state.remove( whiteFrame );
			_state.remove( blackInterior );
			_state.remove( redBar );
			whiteFrame = null;
			blackInterior = null;
			redBar = null;
			_state = null;
		}
		
		public function update():void
		{
			if ( updateBullet )
			{
				_currentTick += FlxG.elapsed;
				if ( _currentTick >= _tickCount )
				{
					_currentAllTick += _currentTick;
					_currentTick -= _tickCount;
					updateBulletEnergy( _currentAllTick, _maxTime );
					if ( _currentAllTick >= _maxTime )
					{
						bulletEnergyFinish();	
					}
				}	
			}
		}
		
		private function bulletEnergyFinish():void
		{
			_currentAllTick = 0;
			_currentTick = 0;
			updateBullet = false;
			var eventEmpty:EventBulletEnergyEmpty = new EventBulletEnergyEmpty(EventBulletEnergyEmpty.EVENT_BULLET_ENERGY_EMPTY );
			GlobalDispatcher.getIns().dispatchEvent( eventEmpty ); 
		}
		
		public function get updateBullet():Boolean 
		{
			return _updateBullet;
		}
		
		public function set updateBullet(value:Boolean):void 
		{
			_currentTick = 0;
			_currentAllTick = 0;
			if ( value == false )
			{
			}
			_updateBullet = value;
		}
		
		public function get maxTime():Number 
		{
			return _maxTime;
		}
		
		public function set maxTime(value:Number):void 
		{
			_maxTime = value;
		}
	}

}