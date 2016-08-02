import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;

class Coin extends FlxSprite {
  var initialized:Bool = false;

  public function new() {
    super();
  }

  public function spawn():Void {
    if (!initialized) {
      loadGraphic("assets/images/coin.png", true, 16, 16);
      animation.add("rotate", [0, 1, 2, 3, 4, 5, 6, 7], 15, true);
      animation.play("rotate");
    }
    initialized = true;
    alive = true;
    exists = true;
    velocity.y = 100;
    y = 0;
    x = Reg.random.int(16, FlxG.width - 32);
  }

  public override function update(elapsed:Float):Void {
    if (y > FlxG.height) exists = false;
    super.update(elapsed);
  }
}
