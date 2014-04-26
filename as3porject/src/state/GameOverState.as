package state 
{
	import component.GameOverScoreItem;
	import flash.events.KeyboardEvent;
	import kale.fileUtil.KaleResourceDataRead;
	import kale.fileUtil.KaleTxtResourcePath;
	import manager.UserData;
	import manager.UserDataManager;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameOverState extends FlxState 
	{
		private var _arrayItem:Array = new Array();
		public function GameOverState() 
		{
			
		}
		override public function create():void
		{
			super.create();
			
			var kaleResPath:KaleTxtResourcePath = new KaleTxtResourcePath("score");
			kaleResPath.setSubPathString("");
			var filePathString:String = kaleResPath.resourcePath;
			
			var dataRead:KaleResourceDataRead = new KaleResourceDataRead( filePathString );
			var dataString:Object = dataRead.getData();
			var scoreString:String = dataString as String;
			initScore( scoreString );
			
			FlxG.stage.addEventListener( KeyboardEvent.KEY_UP, keyBoardUP );
		}
		
		private function keyBoardUP( event:KeyboardEvent ):void
		{
			FlxG.stage.removeEventListener( KeyboardEvent.KEY_UP, keyBoardUP );
			FlxG.switchState( new GameStartState() );
		}
		
		private function addScoreForPlayer( indexRank:int, name:String, score:Number, current:Boolean ):void
		{
			var nameLine:GameOverScoreItem = new GameOverScoreItem();
			nameLine.setPos ( 0, 10 + 20 * indexRank );
			nameLine.setScore( score );
			nameLine.setNameText( indexRank, name );
			nameLine.setCurrentUser( current );
			_arrayItem.push( nameLine );
			add( nameLine );
		}
		
		private function initScore( scoreString:String ):void
		{
			var userDataArray:Array = UserDataManager.getIns().userDataArray;
			var rowIndex:int = 1;
			for each( var userData:UserData in userDataArray )
			{
				var playerName:String = userData.userName;
				var scoreString:String = userData.userScore.toString();
				var score:Number = Number(scoreString);
				var isCurrentUser:Boolean = userData.currentUser;
				addScoreForPlayer( rowIndex, playerName, score, isCurrentUser );
				rowIndex++;
				if ( rowIndex >= 10 )
				{
					break;
				}
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			var arrayLength:uint = _arrayItem.length;
			for ( var itemIndex:uint = 0; itemIndex < arrayLength; itemIndex++ )
			{
				_arrayItem[itemIndex] = null;
			}
			_arrayItem.length = 0;
			FlxG.stage.removeEventListener( KeyboardEvent.KEY_UP, keyBoardUP );
		}
	}

}