package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

class Pipe extends Enemy {
  var spawnTimer:Float;
  var laserTimer:Float;

  var laserDuration:Float = 0.5;
  var activeTween:FlxTween;

  public function new(side:Int, Y:Float) {
    super();
    y = Y;
    alive = false;

    spawnTimer = Reg.random.float(0, 10);
    laserTimer = Reg.random.float(3, 7);

    setFacingFlip(FlxObject.LEFT, false, false);
    setFacingFlip(FlxObject.RIGHT, true, false);

    facing = side;

    loadGraphic("assets/images/pipe.png", true, 48, 32);

    width = 21;
    height = 16;
    offset.y = 8;
    if (facing == FlxObject.RIGHT) {
      offset.x = 27;
    }

    animation.add("idle", [0]);
    animation.add("charge", [1, 2, 1, 2, 3, 2, 4], 10, false);
    animation.add("sploosh", [5], 15, false);
    animation.play("idle");
    animation.finishCallback = onAnimationComplete;

    if(side == FlxObject.LEFT) {
      x = -width;
    } else {
      x = FlxG.width;
    }
  }

  public override function spawn():Void {
    exists = true;
    alive = true;
    tweenIn();
  }

  function tweenIn():Void {
    if (activeTween != null) activeTween.cancel();

    activeTween = FlxTween.tween(this, { x: facing == FlxObject.LEFT ? 0 : FlxG.width - width },
                                 0.5, { ease: FlxEase.bounceOut });
  }

  public function shoot():Void {
    animation.play("charge");
    laserTimer = Reg.random.float(3, 7);
  }

  public function onAnimationComplete(name:String):Void {
    if (name == "charge") {
      Reg.enemyLaserService.shoot(y, facing, 0.5, tweenIn);
      FlxG.camera.shake(0.02, 0.1);
      x += facing == FlxObject.LEFT ? -5 : 5;
      animation.play("sploosh");
    }
    if (name == "sploosh") {
      animation.play("idle");
    }
  }

  public override function update(elapsed:Float):Void {
    if (!alive) {
      spawnTimer -= elapsed;
      if (spawnTimer <= 0) {
        spawn();
      }
    } else {
      laserTimer -= elapsed;
      if (laserTimer <= 0) {
        shoot();
      }
    }
    super.update(elapsed);
  }
}
