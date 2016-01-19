package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

class Pipe extends Enemy {
  var laserTimer:Float;

  var laserDuration:Float = 0.5;
  var activeTween:FlxTween;

  public function new(side:Int, Y:Float) {
    super();
    y = Y;
    alive = false;

    laserTimer = 0.5;

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

    explosionOffset.x = -width/2;
    explosionOffset.y = -height/2;
    deathWidth = width;
    deathHeight = height;
    explosionCount = 3;
    points = 250;
  }

  public override function spawn():Void {
    if (alive) return;
    super.spawn();
    visible = true;
    resetX();
    tweenIn();
    health = 5;
    laserTimer = 0.5;
  }

  function tweenIn():Void {
    if (activeTween != null) activeTween.cancel();

    activeTween = FlxTween.tween(this, { x: facing == FlxObject.LEFT ? 0 : FlxG.width - width },
                                 0.5, { ease: FlxEase.bounceOut });
  }

  public function shoot():Void {
    var chargeSound = FlxG.sound.play("assets/sounds/pipeCharge.wav", 0.75);
    chargeSound.pan = facing == FlxObject.LEFT ? -0.4 : 0.4;
    animation.play("charge");
    laserTimer = Reg.random.float(3, 6);
  }

  public function onAnimationComplete(name:String):Void {
    if (name == "charge") {
      FlxG.camera.shake(0.02, 0.1, null, true);
      var shootSound = FlxG.sound.play("assets/sounds/pipeShoot.wav");
      shootSound.pan = facing == FlxObject.LEFT ? -0.25 : 0.25;
      Reg.enemyLaserService.shoot(y, facing, 0.5, tweenIn);
      x += facing == FlxObject.LEFT ? -5 : 5;
      animation.play("sploosh");
    }
    if (name == "sploosh") {
      animation.play("idle");
    }
  }

  public override function update(elapsed:Float):Void {
    if (alive) {
      laserTimer -= elapsed;
      if (laserTimer <= 0) {
        shoot();
      }
    }
    super.update(elapsed);
  }

  override function kill():Void {
    super.kill();
    animation.play("idle");
    activeTween.cancel();
    visible = false;
    resetX();
  }

  override function die():Void { return; }

  function resetX():Void {
    x = facing == FlxObject.LEFT ? -width : FlxG.width;
  }
}
