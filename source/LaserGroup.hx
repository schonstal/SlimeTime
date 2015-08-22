package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;

class LaserGroup extends FlxSpriteGroup {
  var laserSprite:FlxSprite;

  var particles:FlxSpriteGroup;

  public function new():Void {
    super();

    particles = new FlxSpriteGroup(); 
    add(particles);

    laserSprite = new FlxSprite();
    laserSprite.loadGraphic("assets/images/projectiles/player/laser.png", true, 12, 240);
    laserSprite.animation.add("shoot", [0, 2, 0, 1, 2, 3, 4], 30, false);
    laserSprite.animation.finishCallback = onAnimationComplete;
    add(laserSprite);
  }

  public function initialize(X, Y):Void {
    exists = laserSprite.exists = true;
    particles.exists = false;
    x = X;
    y = Y;
  }

  public function shoot(facing:Int):Void {
    laserSprite.facing = facing;
    laserSprite.animation.play("shoot");
    new FlxTimer().start(1, function(t) {
      exists = false;
    });

    spawnParticles();
  }

  function spawnParticles() {
    for (i in (0...50)) {
      var particle:FlxSprite = particles.recycle(FlxSprite);
      var size = Reg.random.int(1, 2);
      particle.makeGraphic(size, size, FlxColor.fromHSB(307, 1, Reg.random.float(0.5, 1)));
      particle.x = x + Reg.random.int(0, 12);
      particle.y = y + Reg.random.int(0, 240);
      particle.velocity.x = Reg.random.int(-10, 10);
      particle.velocity.y = Reg.random.int(-10, 10);
      new FlxTimer().start(Reg.random.float(0.2, 0.4), function(t) {
        particle.exists = false;
      });
    }
    particles.exists = true;
  }

  function onAnimationComplete(name:String):Void {
    laserSprite.exists = false;
  }
}
