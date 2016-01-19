package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

class MenuPipe extends FlxSprite {
  var activeTween:FlxTween;
  var laserGroup:EnemyLaserGroup;

  public function new(side:Int) {
    super();
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

    x = facing == FlxObject.LEFT ? -width : FlxG.width;
  }

  public function tweenIn():Void {
    if (activeTween != null) activeTween.cancel();

    activeTween = FlxTween.tween(this, { x: facing == FlxObject.LEFT ? 0 : FlxG.width - width },
                                 0.5, { ease: FlxEase.bounceOut });
  }

  public function shoot():Void {
    //var shootSound = FlxG.sound.play("assets/sounds/pipeShoot.wav");
    //FlxG.camera.shake(0.02, 0.1, null, true);
    //shootSound.pan = facing == FlxObject.LEFT ? -0.25 : 0.25;
    laserGroup = Reg.enemyLaserService.shoot(y, facing, 1000000000, tweenIn);
    if (activeTween != null) activeTween.cancel();
    x = facing == FlxObject.LEFT ? -5 : FlxG.width - width + 5;
    animation.play("sploosh");
  }

  public function charge():Void {
    var chargeSound = FlxG.sound.play("assets/sounds/pipeCharge.wav", 0.75);
    chargeSound.pan = facing == FlxObject.LEFT ? -0.4 : 0.4;
    animation.play("charge");
  }

  public function stopShooting():Void {
    if (laserGroup == null) return;
    laserGroup.stopShooting();
    tweenIn();
  }

  public function onAnimationComplete(name:String):Void {
    if (name == "charge") {
      shoot();
    }
    if (name == "sploosh") {
      animation.play("idle");
    }
  }
}
