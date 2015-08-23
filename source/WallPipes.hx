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

    var y = 16;
    var left:Bool = Reg.random.int(0, 1) < 1;
    while ((y += 16) < FlxG.height - 48) {
      var pipe:FlxSprite = new FlxSprite();
      left = !left;
      var pipe:Pipe = new Pipe(left ? FlxObject.LEFT : FlxObject.RIGHT, y);
      add(pipe);
    }
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
