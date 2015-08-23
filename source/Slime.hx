import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;

class Slime extends FlxSpriteGroup {
  public function new() {
    super();
    for (i in (0...Std.int((FlxG.width - 32)/16))) {
      var slimeSprite = new FlxSprite(16 + i * 16, FlxG.height - 16);
      slimeSprite.makeGraphic(16, 32, 0xff33ff88);
      add(slimeSprite);
    }
  }
}
