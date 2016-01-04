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

    for(i in (0...3)) {
      chute = new Chute();
      chute.x = 39 + i * 100;
      chute.y = 115;
      add(chute);
    }
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
