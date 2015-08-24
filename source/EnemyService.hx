package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class LaserService {
  var enemies:Array<EnemyGroup> = new Array<EnemyGroup>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.enemies = new Array<EnemyGroup>();
    this.group = group;
  }

  public function spawn(X:Float, Y:Float, facing:Int = FlxObject.LEFT):EnemyGroup {
    var enemy = recycle(X, Y);
    group.add(enemy);
    enemy.shoot(facing);

    return enemy;
  }

  function recycle(X:Float, Y:Float):EnemyGroup {
    for(p in enemies) {
      if(!p.exists) {
        p.initialize(X, Y);
        return p;
      }
    }

    var enemy:EnemyGroup = new EnemyGroup();
    enemy.initialize(X, Y);
    enemies.push(laserGroup);

    return enemy;
  }
}
