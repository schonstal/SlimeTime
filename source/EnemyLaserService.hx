package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class EnemyLaserService {
  var laserGroups:Array<EnemyLaserGroup> = new Array<EnemyLaserGroup>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.laserGroups = new Array<EnemyLaserGroup>();
    this.group = group;
  }

  public function shoot(Y:Float, facing:Int = FlxObject.RIGHT):EnemyLaserGroup {
    var laserGroup = recycle(Y);
    group.add(laserGroup);
    laserGroup.shoot(facing);

    return laserGroup;
  }

  function recycle(Y:Float):EnemyLaserGroup {
    for(p in laserGroups) {
      if(!p.exists) {
        p.initialize(Y);
        return p;
      }
    }

    var laserGroup:EnemyLaserGroup = new EnemyLaserGroup(Y);
    laserGroup.initialize(Y);
    laserGroups.push(laserGroup);

    return laserGroup;
  }
}
