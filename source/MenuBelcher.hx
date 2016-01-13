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
    animation.add("shoot", [3, 4, 5, 5, 6, 7], 10, false);
    animation.finishCallback = onAnimationComplete;
    animation.play("idle");
  }

  public function spawn(X:Float):Void {
    animation.play("shoot", true);

    height = 32;
    offset.y = 32;
    y = FlxG.height;
    x = X - width/2;
    tweenIn();
  }

  function tweenIn():Void {
    if (activeTween != null) activeTween.cancel();

    activeTween = FlxTween.tween(this, { y: FlxG.height - 40},
                                 0.5, { ease: FlxEase.quadOut });
  }

  function onAnimationComplete(name:String):Void {
    animation.play("idle");
  }
}
