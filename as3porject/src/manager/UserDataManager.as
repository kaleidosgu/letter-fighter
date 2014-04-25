package manager 
{
	import kale.fileUtil.KaleResourceDataRead;
	import kale.fileUtil.KaleResourceDataWrite;
	import kale.fileUtil.KaleTxtResourcePath;
	/**
	 * ...
	 * @author kaleidos
	 */
	public class UserDataManager 
	{
		private static var _userData:UserDataManager = null;
		private var _scoreLimitCounts:int = 10;
		private var _scoreArray:Array = new Array();
		private var _userDataArray:Array = new Array();
		public function UserDataManager() 
		{
			
		}
		public static function getIns():UserDataManager
		{
			if ( _userData == null )
			{
				_userData = new UserDataManager();
			}
			return _userData;
		}
		
		public function generateUserData():void
		{
			var kaleResPath:KaleTxtResourcePath = new KaleTxtResourcePath("score");
			kaleResPath.setSubPathString("");
			var filePathString:String = kaleResPath.resourcePath;
			
			var dataRead:KaleResourceDataRead = new KaleResourceDataRead( filePathString );
			var dataString:Object = dataRead.getData();
			var scoreString:String = dataString as String;
			generateUserDataByString( scoreString );
		}
		private function generateUserDataByString( scoreString:String ):void
		{
			var rowsArray:Array = scoreString.split("\n");
			for each( var rowData:String in rowsArray )
			{
				var colIndex:int = 0;
				var colArray:Array = rowData.split(",");
				
				if ( colArray.length == 2 )
				{
					var playerName:String = colArray[0] as String;
					var scoreString:String = colArray[1];
					var score:Number = Number(scoreString);
					
					var userData:UserData = new UserData( playerName, score );
					_scoreArray.push ( userData );
				}
			}
		}
		
		public function scoreProcess( newScore:Number, name:String ):void
		{
			var userdata:UserData = new UserData( name, newScore );
			userdata.currentUser = true;
			
			var insertOK:Boolean = true;
			for each( var userIt:UserData in _scoreArray )
			{
				_userDataArray.push ( userIt.clone() );
			}
			if ( insertOK )
			{
				_userDataArray.push ( userdata );	
			}
			_userDataArray.sort( sortFunction );
			writeScoreIntoFile( _userDataArray );
		}
		
		private function sortFunction( userLeft:UserData, userRight:UserData ):int
		{
			if ( userLeft.userScore < userRight.userScore )
			{
				return 1;
			}
			else if ( userLeft.userScore >= userRight.userScore )
			{
				return -1;
			}
			return 1;
		}
		
		private function writeScoreIntoFile( scoreArray:Array ):void
		{
			var dataIndex:int = 0;
			var stringResult:String = "";
			for each( var userData:UserData in scoreArray )
			{
				stringResult += userData.userName + "," + userData.userScore.toString() + "\n";
				dataIndex++;
				if ( dataIndex >= _scoreLimitCounts )
				{
					break;
				}
			}
			var kaleResPath:KaleTxtResourcePath = new KaleTxtResourcePath("score");
			kaleResPath.setSubPathString("");
			var filePathString:String = kaleResPath.resourcePath;
			
			var dataWrite:KaleResourceDataWrite = new KaleResourceDataWrite();
			dataWrite.writeDataToFile( filePathString, stringResult );
		}
		
		public function get userDataArray():Array 
		{
			return _userDataArray;
		}
		
		public function set userDataArray(value:Array):void 
		{
			_userDataArray = value;
		}
		
	}

}