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

class MenuBelcher extends FlxSprite {
  var activeTween:FlxTween;

  public function new() {
    super();
    loadGraphic("assets/images/enemies/belcher.png", true, 64, 64);
    animation.add("idle", [0, 1, 2], 5, true);
    animation.add("spawn", [3, 4, 5, 5, 6, 7], 10, false);
    animation.add("leave", [3, 4, 5], 10, false);
    animation.finishCallback = onAnimationComplete;
    animation.play("idle");

    y = FlxG.height;
  }

  public function spawn(X:Float):Void {
    animation.play("spawn", true);

    height = 32;
    offset.y = 32;
    y = FlxG.height;
    x = X - width/2;
    tweenIn();
  }

  public function despawn():Void {
    animation.play("leave", true);
    tweenOut();
  }

  public function select():Void {
    visible = false;
    FlxG.camera.shake(0.005, 0.2);
    for(i in 0...8) {
      Reg.enemyExplosionService.explode(x, y, width, height/2);
    }
  }

  public function initialize():Void {
    visible = true;
    animation.play("idle");
    y = FlxG.height;
  }

  function tweenIn():Void {
    if (activeTween != null) activeTween.cancel();

    activeTween = FlxTween.tween(this, { y: FlxG.height - 40},
                                 0.5, { ease: FlxEase.quadOut });
  }

  function tweenOut():Void {
    if (activeTween != null) activeTween.cancel();

    activeTween = FlxTween.tween(this, { y: FlxG.height + 5},
                                 0.25, { ease: FlxEase.cubeIn });
  }

  function onAnimationComplete(name:String):Void {
    if (name == "spawn") animation.play("idle");
  }
}
