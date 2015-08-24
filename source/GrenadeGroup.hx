package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;
import flixel.math.FlxMath;

class GrenadeGroup extends FlxSpriteGroup {
  var spawnTimer:Float = 0;

  public function new() {
    super();
  }

  override public function update(elapsed:Float):Void {
    if (Reg.started) {
      spawnTimer -= elapsed;
      if (spawnTimer < 0) {
        spawnTimer = Reg.random.float(
          FlxMath.lerp(1, 0.25, Reg.difficulty),
          FlxMath.lerp(1.5, 0.75, Reg.difficulty)
        );
        var g = recycle(Grenade);
        cast(g, Grenade).spawn();
        add(g);
      }
    }

    super.update(elapsed);
  }
}
