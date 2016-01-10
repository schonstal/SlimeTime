import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;

class Slime extends FlxSpriteGroup {
  var sinAmt:Float = 0;
  public function new() {
    super();
    for (i in (0...Std.int((FlxG.width - 32)/16))) {
      var slimeSprite = new FlxSprite(16 + i * 16, FlxG.height - 16);
      slimeSprite.loadGraphic("assets/images/ooze.png", true, 16, 32);
      slimeSprite.animation.add("pulse", [0, 1, 2, 3], 10, true);
      slimeSprite.animation.play("pulse");
      slimeSprite.immovable = true;
      add(slimeSprite);
    }
  }

  public override function update(elapsed:Float):Void {
    sinAmt += 3.0 * elapsed;
    var i = 0;
    for (slimeSprite in members) {
      i++;
      slimeSprite.offset.y = 2 * Math.sin(sinAmt + i);
    }
    super.update(elapsed);
  }
}
