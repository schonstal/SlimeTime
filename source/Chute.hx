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

class Chute extends FlxSpriteGroup {
  var chute:FlxSprite;
  var ooze:FlxSprite;
  var initialized:Bool = false;

  public function new() {
    super();
    chute = new FlxSprite();
    chute.loadGraphic("assets/images/chute.png");
    add(chute);

    ooze = new FlxSprite();
    ooze.loadGraphic("assets/images/chuteOoze.png", true, 32, 96);
    ooze.animation.add("flow", [0, 1, 2, 3], 5, true);
    ooze.animation.play("flow");
    ooze.animation.curAnim.curFrame = new FlxRandom().int(0, 3);
    ooze.y = 29;
    ooze.x = chute.width/2 - ooze.width/2;
    add(ooze);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
