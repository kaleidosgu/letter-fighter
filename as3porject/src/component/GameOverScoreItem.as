package component 
{
	import flash.ui.Keyboard;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import kale.KaleiTextFormatConst;
	
	/**
	 * ...
	 * @author kaleidos
	 */
	public class GameOverScoreItem extends FlxGroup
	{
		private var _nameTextField:FlxText = null;
		private var _scoreTextField:FlxText = null;
		private var _posY:Number = 0;
		private var _diff:Number = 5;
		private var enterCharCode:String = "";
		public function GameOverScoreItem() 
		{
			var posX:Number = 15;
			var width:Number = FlxG.width - posX * 2;
			_nameTextField = new FlxText( posX, 0, width, "" );
			_nameTextField.alignment = KaleiTextFormatConst.ALIGH_LEFT;
			_nameTextField.size = 14;
			
			_scoreTextField = new FlxText( posX, 0, width, "" );
			_scoreTextField.alignment = KaleiTextFormatConst.ALIGH_RIGHT;
			_scoreTextField.size = 16;
			
			add( _scoreTextField );
			add( _nameTextField );
			enterCharCode = String.fromCharCode( Keyboard.ENTER );
		}
		/*override public function create():void
		{
			super.create();
		}*/
		
		public function setNameText( listRank:int, name:String ):void
		{
			if ( name == enterCharCode )
			{
				name = "UnnamedPlayer";
			}
			_nameTextField.text = listRank.toString() + "." + name;
		}
		
		public function setScore( score:int ):void
		{
			_scoreTextField.text = score.toString();
		}
		public function setPos( xPos:Number, yPos:Number ):void
		{
			_nameTextField.y = yPos;
			_scoreTextField.y = yPos;
		}
		override public function destroy():void
		{
			super.destroy();
			
			_nameTextField = null;
			_scoreTextField = null;
		}
		
	}

}