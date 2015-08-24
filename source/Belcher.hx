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

class Belcher extends Enemy {
  var activeTween:FlxTween;

  public function new() {
    super();
    loadGraphic("assets/images/enemies/belcher.png", true, 64, 64);
    animation.add("idle", [2, 1, 0], 5, true);
    animation.add("shoot", [7, 3, 4, 5, 5, 6], 10, false);
    animation.add("spawn", [7, 3, 4, 5], 10, false);
    animation.finishCallback = onAnimationComplete;
    animation.play("idle");
  }

  public override function spawn():Void {
    super.spawn();

    animation.play("spawn");
    health = 500;

    y = FlxG.height;
    x = Reg.random.int(16, FlxG.width - 80);
    tweenIn();
  }

  function tweenIn():Void {
    if (activeTween != null) activeTween.cancel();

    activeTween = FlxTween.tween(this, { y: FlxG.height - 72},
                                 0.5, { ease: FlxEase.quadOut });
  }

  public override function update(elapsed:Float):Void {
    if (FlxG.keys.justPressed.Q) explode();
    super.update(elapsed);
  }

  function explode():Void {
    animation.play("shoot");
  }

  function onAnimationComplete(name:String) {
    if (name == "shoot") {
    //FlxG.camera.shake(0.02, 0.2);
      for(i in (0...8)) {
        Reg.enemyProjectileService.shoot(
          x + 6, y + 6, new FlxVector(Math.cos(i/8 * Math.PI), Math.sin(i/8 * Math.PI))
        );
      }
    }
  }
}
