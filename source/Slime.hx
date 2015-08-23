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
      slimeSprite.makeGraphic(16, 32, 0xff33ff88);
      slimeSprite.immovable = true;
      add(slimeSprite);
    }
  }

  public override function update(elapsed):Void {
    sinAmt += elapsed;
    var i = 0;
    for (slimeSprite in members) {
      i++;
      slimeSprite.offset.y = 2 * Math.sin(sinAmt + i);
    }
    super.update(elapsed);
  }
}
