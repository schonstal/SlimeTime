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
    if (Reg.started && (Reg.score >= 1500 || Reg.hardMode)) {
      spawnTimer -= elapsed;
      if (spawnTimer < 0) {
        spawnTimer = Reg.random.float(
          FlxMath.lerp(1.25, 1, Reg.difficulty),
          FlxMath.lerp(1.75, 1.25, Reg.difficulty)
        );
        var g = recycle(Grenade);
        cast(g, Grenade).spawn();
        add(g);
      }
    }

    super.update(elapsed);
  }
}
