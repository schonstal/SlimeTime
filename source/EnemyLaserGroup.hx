package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;

class EnemyLaserGroup extends FlxSpriteGroup {
  public function new(Y):Void {
    super();

    for (i in (0...Std.int((FlxG.width - 32)/32))) {
      var laserSprite = new FlxSprite(16 + i * 32, -6);
      laserSprite.loadGraphic("assets/images/projectiles/enemy/laser.png", true, 32, 32);
      laserSprite.animation.add("shoot", [0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 4, 5, 6, 7, 8], 30, false);
      laserSprite.immovable = true;
      laserSprite.setFacingFlip(FlxObject.RIGHT, true, false);
      add(laserSprite);
    }

    y = Y;
  }

  public function initialize(Y):Void {
    exists = true;
    for(laserSprite in members) {
      laserSprite.exists = true;
    }
    y = Y;
  }

  public function shoot(facing:Int):Void {
    for(laserSprite in members) {
      laserSprite.animation.play("shoot");
      laserSprite.facing = facing;
    }
    new FlxTimer().start(0.6, function(t) {
      exists = false;
      for(laserSprite in members) laserSprite.exists = false;
    });
  }
}
