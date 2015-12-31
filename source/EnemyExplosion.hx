package;

import flixel.FlxSprite;
import flixel.FlxG;

class EnemyExplosion extends FlxSprite {
  var isPlayer:Bool = false;

  public function new() {
    super();
    loadGraphic("assets/images/enemies/explosion.png", true, 32, 32);
    offset.x = 16;
    offset.y = 16;
    animation.add("explode", [0, 1, 2, 3, 4, 5, 6], 15, false);
    animation.add("player explode", [8, 9, 10, 11, 12, 13], 15, false);
    animation.finishCallback = onAnimationComplete;
  }

  public function initialize(X:Float, Y:Float, player:Bool = false):Void {
    exists = true;
    x = X;
    y = Y;
    isPlayer = player;
  }

  public function explode():Void {
    if (isPlayer) {
      animation.play("player explode");
    } else {
      animation.play("explode");
    }
  }

  function onAnimationComplete(name:String):Void {
    exists = false;
  }
}
