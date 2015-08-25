import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;

class Health extends FlxSprite {
  var initialized:Bool = false;

  public function new() {
    super();
  }

  public function spawn():Void {
    if (!initialized) {
      loadGraphic("assets/images/healthPickup.png", true, 15, 15);
      animation.add("flash", [0, 1], 10, true);
      animation.play("flash");
    }
    initialized = true;
    alive = true;
    exists = true;
    velocity.y = 100;
    y = 0;
//    acceleration.y = Player.gravity;

//    velocity.y = Reg.random.int(-400, -600);

//    y = FlxG.height;
    x = Reg.random.int(16, FlxG.width - 32);
  }

  public override function update(elapsed:Float):Void {
    if (y > FlxG.height) exists = false;
    super.update(elapsed);
  }
}
