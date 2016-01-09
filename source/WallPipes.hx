package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;
import flash.display.BlendMode;
import flixel.math.FlxMath;

class WallPipes extends FlxSpriteGroup {
  var spawnTimer:Float = 1;

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
    if (Reg.started && Reg.difficulty >= 0.01) {
      spawnTimer -= elapsed;
      if (spawnTimer <= 0) {
        spawnPipe();
        spawnTimer = Reg.random.float(
          FlxMath.lerp(7, 5, Reg.difficulty),
          FlxMath.lerp(10, 7, Reg.difficulty)
        );
      }
    }
    super.update(elapsed);
  }

  function spawnPipe():Void {
    cast(members[Reg.random.int(0, members.length-1)], Pipe).spawn();
  }
}
