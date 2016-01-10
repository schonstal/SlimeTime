package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;

class EnemyLaserGroup extends FlxSpriteGroup {
  public var onCompleteCallback:Void->Void;

  var lasers:FlxSpriteGroup;
  var particles:FlxSpriteGroup;

  var duration:Float = 0;

  public function new(Y:Float):Void {
    super();

    lasers = new FlxSpriteGroup();
    particles = new FlxSpriteGroup();

    for (i in (0...Std.int((FlxG.width - 32)/32))) {
      var laserSprite = new FlxSprite(16 + i * 32, 0);
      laserSprite.loadGraphic("assets/images/projectiles/enemy/laser.png", true, 32, 32);
      laserSprite.height = 6;
      laserSprite.offset.y = 13;
      laserSprite.animation.add("shoot", [0, 1, 2, 3], 30, true);
      laserSprite.animation.add("fade", [4, 5, 6, 7, 8], 30, false);
      laserSprite.immovable = true;
      laserSprite.setFacingFlip(FlxObject.RIGHT, true, false);
      laserSprite.setFacingFlip(FlxObject.LEFT, false, false);
      laserSprite.animation.callback = onAnimate;
      laserSprite.animation.finishCallback = onAnimationComplete;
      lasers.add(laserSprite);
    }

    var particleSprite = new FlxSprite();
    particleSprite.loadGraphic("assets/images/projectiles/enemy/laserSplash.png", true, 16, 48);
    particleSprite.animation.add("splash", [0, 1, 2, 3], 15, true);
    particleSprite.setFacingFlip(FlxObject.RIGHT, true, false);
    particleSprite.setFacingFlip(FlxObject.LEFT, false, false);
    particleSprite.y = -22;
    particles.add(particleSprite);

    add(lasers);
    add(particles);

    y = Y + 5;
  }

  public function initialize(Y:Float):Void {
    exists = true;
    lasers.exists = true;
    particles.exists = true;

    for(particleSprite in particles.members) {
      particleSprite.exists = true;
      particleSprite.solid = false;
    }

    for(laserSprite in lasers.members) {
      laserSprite.exists = true;
    }

    y = Y + 5;
  }

  public override function update(elapsed:Float):Void {
    duration -= elapsed;

    super.update(elapsed);
  }

  public function shoot(facing:Int, duration:Float):Void {
    this.duration = duration;

    for(laserSprite in lasers.members) {
      laserSprite.animation.play("shoot");
      laserSprite.solid = true;
      laserSprite.facing = facing;
    }

    for(particleSprite in particles.members) {
      particleSprite.animation.play("splash");
      particleSprite.facing = facing;
      particleSprite.x = facing == FlxObject.RIGHT ? 16 : FlxG.width - 16 - particleSprite.width;
    }
  }

  function onAnimate(name:String, frame:Int, frameIndex:Int):Void {
    if (name == "shoot" && frame == 3) {
      if (duration <= 0) {
        for(particleSprite in particles.members) {
          particleSprite.exists = false;
        }

        for(laserSprite in lasers.members) {
          laserSprite.solid = false;
          laserSprite.animation.play("fade");
        }

        if (onCompleteCallback != null) onCompleteCallback();
      }
    }
  }

  function onAnimationComplete(name:String):Void {
    if (name == "fade") {
      exists = false;
    }
  }
}
