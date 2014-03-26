package state 
{
	import component.GameOverScoreItem;
	import kale.fileUtil.KaleResourceDataRead;
	import kale.fileUtil.KaleTxtResourcePath;
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
			var mapString:String = dataString as String;
			initScore( mapString );
		}
		
		private function addScoreForPlayer( indexRank:int, name:String, score:Number ):void
		{
			var nameLine:GameOverScoreItem = new GameOverScoreItem();
			nameLine.setPos ( 0, 10 + 20 * indexRank );
			nameLine.setScore( score );
			nameLine.setNameText( indexRank, name );
			_arrayItem.push( nameLine );
			add( nameLine );
		}
		
		private function initScore( scoreString:String ):void
		{
			var rowsArray:Array = scoreString.split("\n");
			var rowIndex:int = 1;
			for each( var rowData:String in rowsArray )
			{
				var colIndex:int = 0;
				var colArray:Array = rowData.split(",");
				
				if ( colArray.length == 2 )
				{
					var playerName:String = colArray[0] as String;
					var scoreString:String = colArray[1];
					var score:Number = Number(scoreString);
					addScoreForPlayer( rowIndex, playerName, score );
				}
				rowIndex++;
			}
		}
		
		override public function update():void
		{
			super.update();
			if ( FlxG.keys.justReleased("SPACE" ) )
			{
				//FlxG.switchState(new PlayState());
			}
		}
		override public function destroy():void
		{
			super.destroy();
			
			for each( var item:GameOverScoreItem in _arrayItem )
			{
				item = null;
			}
		}
	}

}