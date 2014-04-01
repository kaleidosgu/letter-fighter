package dispatcher 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GlobalDispatcher extends EventDispatcher 
	{
		private static var _dispatcher:GlobalDispatcher = null;
		public function GlobalDispatcher() 
		{
			
		}
		public static function getIns():GlobalDispatcher
		{
			if ( _dispatcher == null )
			{
				_dispatcher = new GlobalDispatcher();
			}
			return _dispatcher;
		}
		
	}

}