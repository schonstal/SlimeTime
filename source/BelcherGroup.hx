package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;
import flixel.math.FlxMath;

class BelcherGroup extends FlxSpriteGroup {
  var spawnTimer:Float = 1;

  public function new() {
    super();
  }

  override public function update(elapsed:Float):Void {
    if (Reg.started && Reg.score >= 1000) {
      spawnTimer -= elapsed;
      if (spawnTimer < 0) {
        spawnTimer = Reg.random.float(
          FlxMath.lerp(5, 4, Reg.difficulty),
          FlxMath.lerp(8, 6, Reg.difficulty)
        );
        var g = recycle(Belcher);
        cast(g, Belcher).spawn();
        add(g);
      }
    }

    super.update(elapsed);
  }
}
