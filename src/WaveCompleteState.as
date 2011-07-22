package
{
	import org.flixel.*;
	
	public class WaveCompleteState extends FlxState
	{
		override public function create():void
		{
			var t:FlxText;
			t = new FlxText(0, 100, FlxG.width, "Wave " + (Globals.day - 1) + " Complete");
			t.size = 32;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(0, 200, FlxG.width, "Zombie Kills Today: " + Globals.levelKills);
			t.size = 32;
			t.alignment = "center";
			add(t);
			
			t = new FlxText(0, 260, FlxG.width, "Total Zombie Kills: " + Globals.totalKills);
			t.size = 32;
			t.alignment = "center";
			add(t);
			
			
			t = new FlxText(FlxG.width/2-100,FlxG.height-30,200,"click to start");
			t.size = 16;
			t.alignment = "center";
			add(t);
			
			FlxG.mouse.show();
		}
		
		override public function update():void
		{
			super.update();
			
			if(FlxG.mouse.justPressed())
				FlxG.switchState(new PlayState());
		}
	}
}