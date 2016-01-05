package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;

import flixel.math.FlxVector;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;

class ChuteGroup extends FlxSpriteGroup {
  public function new() {
    super();

    var chute:Chute;

    chute = new Chute();
    chute.x = 53;
    chute.y = 108;
    add(chute);

    chute = new Chute(2);
    chute.x = 212;
    chute.y = 108;
    add(chute);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
