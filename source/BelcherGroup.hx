package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;
import flixel.math.FlxMath;
import flixel.math.FlxRandom;

class BelcherGroup extends FlxSpriteGroup {
  var spawnTimer:Float = 1;
  var availableSlots:Array<Int> = [];
  var random:FlxRandom;

  public function new() {
    super();
    random = new FlxRandom();
    availableSlots = [for (i in (16...(FlxG.width - 80))) if (i % 16 == 0) i];
    availableSlots = random.shuffleArray(availableSlots, 100);
  }

  override public function update(elapsed:Float):Void {
    if (Reg.started && (Reg.score >= 500 || Reg.hardMode)) {
      spawnTimer -= elapsed;
      if (spawnTimer < 0) {
        if (availableSlots.length < 1) {
          super.update(elapsed);
          return;
        }
        spawnTimer = Reg.random.float(
          FlxMath.lerp(5, 3, Reg.difficulty),
          FlxMath.lerp(8, 4, Reg.difficulty)
        );
        var g = recycle(Belcher);
        var belcher = cast(g, Belcher);
        belcher.spawn();
        belcher.x = availableSlots.pop();
        belcher.onDeath = function() {
          availableSlots.push(Std.int(belcher.x));
          availableSlots = random.shuffleArray(availableSlots, 100);
        }
        add(g);
      }
    }

    super.update(elapsed);
  }
}
