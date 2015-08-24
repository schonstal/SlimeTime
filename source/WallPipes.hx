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
  var SPAWN_RATE:Float = 3;

  var spawnRate:Float = 3;
  var spawnTimer:Float = 3;

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
    spawnRate = SPAWN_RATE/Reg.difficulty;

    if (Reg.started) {
      spawnTimer -= elapsed;
      if (spawnTimer <= 0) {
        spawnPipe();
        spawnTimer = spawnRate + Reg.random.float(-1, 1);
      }
    }
    super.update(elapsed);
  }

  function spawnPipe():Void {
    cast(members[Reg.random.int(0, members.length-1)], Pipe).spawn();
  }
}
