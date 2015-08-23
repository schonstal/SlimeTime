package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;
import flash.display.BlendMode;

class WallPipes extends FlxSpriteGroup {
  public function new():Void {
    super();

    var y = 0;
    var left:Bool = Reg.random.int(0, 1) < 1;
    while ((y += 32 + Reg.random.int(0, 8)) < FlxG.height - 48) {
      var pipe:FlxSprite = new FlxSprite();
      left = !left;
      pipe.loadGraphic("assets/images/pipe.png");
      if(left) {
        pipe.x = 0;
      } else {
        pipe.x = FlxG.width - pipe.width;
        pipe.setFacingFlip(FlxObject.LEFT, true, false);
        pipe.facing = FlxObject.LEFT;
      }
      pipe.y = y;
      add(pipe);
    }
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
