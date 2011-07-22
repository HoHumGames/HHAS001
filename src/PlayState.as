package
{
	import flash.display.DisplayObject;
	
	import org.flixel.*;
	
	
	public class PlayState extends FlxState
	{
		private var background:FlxSprite;
		private var hero:FlxSprite;
		
		private var zombies:FlxGroup;
		private var bullets:FlxGroup;
		
		private var bulletBackstop:FlxObject;
		private var zombieBackstop:FlxObject;
		
		private var zombieTimer:FlxTimer;
		private var waveTimer:FlxTimer;
		private var waveTime:FlxText;
		
		override public function create():void
		{
			FlxG.mouse.hide();

			Globals.levelKills = 0;
			
			background = new FlxSprite(0, 0, Assets.TEST_BG);
			hero = new FlxSprite(360, 450, Assets.TEST_HERO);
			
			zombies = new FlxGroup();
			bullets = new FlxGroup();
			
			bulletBackstop = new FlxObject(-10, 0, FlxG.width, 10);
			zombieBackstop = new FlxObject(0, FlxG.height + 5, FlxG.width, 0);
			
			zombieTimer = new FlxTimer();
			zombieTimer.start(0.5, 0, spawnZombie);
			
			waveTimer = new FlxTimer();
			waveTimer.start(Globals.waveLength, 1, waveComplete);
			
			waveTime = new FlxText(0, 0, 100);
			
			for(var i:int = 0; i < 20; i++)
			{
				var testZombie:Zombie = new Zombie(0, 0, "Standard");
				testZombie.kill();

				zombies.add(testZombie);
			}
			
			for(var x:int = 0; x < 40; x++)
			{
				var testBullet:FlxSprite = new FlxSprite(0, 0, Assets.TEST_BULLET);
				testBullet.kill();
				bullets.add(testBullet);
			}

			// Draw Images
			add(background);
			add(hero);
			add(zombies);
			add(bullets);
			
			// Draw Text
			add(waveTime);
		}
		
		override public function update():void
		{
			super.update();
			
			// Hero Controls
			if(FlxG.keys.D)
			{
				hero.velocity.x = 200;
			}
			else if(FlxG.keys.A)
			{
				hero.velocity.x = -200
			}
			else
			{
				hero.velocity.x = 0;
			}
			
			// Hero Container
			if(hero.x < 0)
			{
				hero.x = 0;
			}
			if((hero.x + hero.width) > FlxG.width)
			{
				hero.x = FlxG.width - hero.width;
			}
			
			// Shoot Bullets
			if(FlxG.mouse.justPressed())
			{
				var bullet:FlxSprite = FlxSprite(bullets.getFirstAvailable());
				bullet.reset(hero.x, hero.y);
				bullet.velocity.y = -500;
				bullet.revive();
			}

			// Check Bullet Bounds
			FlxG.collide(bullets, bulletBackstop, containBullet);
			
			// Check Zombie Bounds
			FlxG.collide(zombies, zombieBackstop, containZombie);
			
			// Check Bullet -> Zombie Hit
			FlxG.overlap(bullets, zombies, hitZombie);
			
			waveTime.text = Globals.totalMoney.toString();
			waveTime.size = 24;
		}
		
		public function containBullet(bullet:FlxObject, bulletBackstop:FlxObject):void
		{
			bullet.kill();
		}
		
		public function containZombie(zombie:FlxObject, zombieBackstop:FlxObject):void
		{
			zombie.kill();
		}
		
		public function spawnZombie(Timer:FlxTimer):void
		{
			var zombie:Zombie = Zombie(zombies.getFirstAvailable());
			zombie.reset(Math.random() * (FlxG.width - zombie.width), 0 - zombie.height);
			zombie.regenerate();
		}
		
		public function hitZombie(bullet:FlxObject, zombie:FlxObject):void
		{
			bullet.kill();
			
			zombie.health -= 1;
			
			if(zombie.health == 0)
			{
				killZombie(Zombie(zombie));
			}
		}
		
		public function killZombie(zombie:Zombie):void
		{	
			zombie.kill();
			
			Globals.levelKills++;
			Globals.totalKills++;
			Globals.totalMoney += zombie.moneyValue;
		}
		
		public function waveComplete(Timer:FlxTimer):void
		{
			Globals.day++;
			FlxG.switchState(new WaveCompleteState());
		}
		
		
	}
}