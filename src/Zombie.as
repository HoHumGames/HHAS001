package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class Zombie extends FlxSprite
	{
		public var startHealth:Number;
		public var moneyValue:Number;

		public function Zombie(X:Number=0, Y:Number=0, ZombieType:String="Standard")
		{
			switch(ZombieType)
			{
				case "Standard":
					super(X, Y, Assets.TEST_ZOMBIE);
					startHealth = 1;
					this.health = startHealth;
					moneyValue = 5;
					break;
			}
		}
		
		
		public function regenerate():void
		{
			this.velocity.y = 15 + (Math.random() * 25);
			this.health = this.startHealth;
			this.revive();
		}

	}
}