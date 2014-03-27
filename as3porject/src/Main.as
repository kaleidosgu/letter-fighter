package
{
	import org.flixel.*;
	//import state.GameOverState;
	import state.GameStartState;
	[SWF(width="320", height="240", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(320, 240, GameStartState, 1, 20, 20);
		}
	}
}
