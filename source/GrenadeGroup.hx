package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class GrenadeGroup extends FlxSpriteGroup {
  var spawnTimer:Float = 0;

  public function new() {
    super();
  }

  override public function update(elapsed:Float):Void {
    if (Reg.started) {
      spawnTimer -= elapsed;
      if (spawnTimer < 0) {
        spawnTimer = Reg.random.float(0.5/Reg.difficulty, 2/Reg.difficulty);
        var g = recycle(Grenade);
        cast(g, Grenade).spawn();
        add(g);
      }
    }

    super.update(elapsed);
  }
}
