package
{
	import org.flixel.*;
	import state.GamePlayState;
	import state.GameTestState;
	//import state.GameOverState;
	//import state.GameStartState;
	//import state.GameTestState;
	import state.GameStartState;
	[SWF(width="320", height="240", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(320, 240, GameTestState, 1, 20, 20);
			//super(320, 240, GamePlayState, 1, 20, 20);
			//super(320, 240, PlayState, 1, 20, 20);
		}
	}
}
