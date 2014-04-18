package manager 
{
	/**
	 * ...
	 * @author kaleidos
	 */
	public class UserData 
	{
		private var _userName:String = "";
		private var _userScore:Number = 0;
		public function UserData( name:String, score:Number ) 
		{
			_userName = name;
			_userScore = score;
		}
		
		public function get userName():String 
		{
			return _userName;
		}
		
		public function set userName(value:String):void 
		{
			_userName = value;
		}
		
		public function get userScore():Number 
		{
			return _userScore;
		}
		
		public function set userScore(value:Number):void 
		{
			_userScore = value;
		}
		
		public function clone():UserData
		{
			var userTemp:UserData = new UserData( this._userName, this._userScore );
			return userTemp;
		}
		
	}

}