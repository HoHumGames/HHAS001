package
{
	import org.flixel.*;
	[SWF(width="720", height="540", backgroundColor="#FFFFFF")]
	[Frame(factoryClass="Preloader")]
	
	public class Main extends FlxGame
	{
		public function Main()
		{
			super(720, 540, MenuState);
		}
	}
}