import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;

class Belcher extends Enemy {
  var activeTween:FlxTween;

  var shootTimer:Float = 2;
  var shootTime:Float = 1.5;

  public function new() {
    super();
    loadGraphic("assets/images/enemies/belcher.png", true, 64, 64);
    animation.add("idle", [0, 1, 2], 5, true);
    animation.add("shoot", [3, 4, 5, 5, 6, 7], 10, false);
    animation.callback = onAnimate;
    animation.finishCallback = onAnimationComplete;
    animation.play("idle");
    explosionOffset.y = -20;
    points = 500;
  }

  public override function spawn():Void {
    super.spawn();

    animation.play("shoot");
    health = 100;

    height = 32;
    offset.y = 32;
    y = FlxG.height;
    x = Reg.random.int(16, FlxG.width - 80);
    tweenIn();
  }

  function tweenIn():Void {
    if (activeTween != null) activeTween.cancel();

    activeTween = FlxTween.tween(this, { y: FlxG.height - 40},
                                 0.5, { ease: FlxEase.quadOut });
  }

  public override function update(elapsed:Float):Void {
    shootTimer -= elapsed;
    if (shootTimer <= 0) {
      explode();
      shootTimer = shootTime;
    }
    super.update(elapsed);
  }

  function explode():Void {
    animation.play("shoot");
  }

  function onAnimationComplete(name:String):Void {
    animation.play("idle");
  }

  function onAnimate(name:String, frameIndex:Int, frame:Int):Void {
    if (name == "shoot" && frame == 6) {
    //FlxG.camera.shake(0.02, 0.2);
      for(i in (1...9)) {
        if(i == 8) return;
        Reg.enemyProjectileService.shoot(
          x + 29, y + 6, new FlxVector(Math.cos(i/8 * Math.PI + Math.PI), Math.sin(i/8 * Math.PI + Math.PI))
        );
      }
    }
  }
}
