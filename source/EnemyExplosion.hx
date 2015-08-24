package;

import flixel.FlxSprite;
import flixel.FlxG;

class EnemyExplosion extends FlxSprite {
  public function new() {
    super();
    loadGraphic("assets/images/enemies/explosion.png", true, 32, 32);
    offset.x = 16;
    offset.y = 16;
    animation.add("explode", [0, 1, 2, 3, 4, 5, 6], 15, false);
    animation.finishCallback = onAnimationComplete;
  }

  public function initialize(X:Float, Y:Float):Void {
    exists = true;
    x = X;
    y = Y;
  }

  public function explode():Void {
    animation.play("explode");
  }

  function onAnimationComplete(name:String):Void {
    exists = false;
  }
}
