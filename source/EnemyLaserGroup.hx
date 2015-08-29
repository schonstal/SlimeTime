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

  var duration:Float = 0;

  public function new(Y):Void {
    super();

    for (i in (0...Std.int((FlxG.width - 32)/32))) {
      var laserSprite = new FlxSprite(16 + i * 32, 0);
      laserSprite.loadGraphic("assets/images/projectiles/enemy/laser.png", true, 32, 32);
      laserSprite.height = 16;
      laserSprite.offset.y = 8;
      laserSprite.animation.add("shoot", [0, 1, 2, 3], 30, true);
      laserSprite.animation.add("fade", [4, 5, 6, 7, 8], 30, false);
      laserSprite.immovable = true;
      laserSprite.setFacingFlip(FlxObject.RIGHT, true, false);
      laserSprite.setFacingFlip(FlxObject.LEFT, false, false);
      laserSprite.animation.callback = onAnimate;
      laserSprite.animation.finishCallback = onAnimationComplete;
      add(laserSprite);
    }

    y = Y;
  }

  public function initialize(Y):Void {
    exists = true;
    for(laserSprite in members) {
      laserSprite.exists = true;
    }
    y = Y;
  }

  public override function update(elapsed:Float):Void {
    duration -= elapsed;

    super.update(elapsed);
  }

  public function shoot(facing:Int, duration:Float):Void {
    this.duration = duration;
    for(laserSprite in members) {
      laserSprite.animation.play("shoot");
      laserSprite.solid = true;
      laserSprite.facing = facing;
    }
  }

  function onAnimate(name:String, frame:Int, frameIndex:Int):Void {
    if (name == "shoot" && frame == 3) {
      if (duration <= 0) {
        for(laserSprite in members) {
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
