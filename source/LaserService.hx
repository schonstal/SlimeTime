package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class LaserService {
  var laserGroups:Array<LaserGroup> = new Array<LaserGroup>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.laserGroups = new Array<LaserGroup>();
    this.group = group;
  }

  public function shoot(X:Float, Y:Float, facing:Int = FlxObject.LEFT):LaserGroup {
    var laserGroup = recycle(X, Y);
    group.add(laserGroup);
    laserGroup.shoot(facing);

    return laserGroup;
  }

  function recycle(X:Float, Y:Float):LaserGroup {
    for(p in laserGroups) {
      if(!p.exists) {
        p.initialize(X, Y);
        return p;
      }
    }

    var laserGroup:LaserGroup = new LaserGroup();
    laserGroup.initialize(X, Y);
    laserGroups.push(laserGroup);

    return laserGroup;
  }
}
