package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;

class ProjectileService {
  var projectiles:Array<Projectile> = new Array<Projectile>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.projectiles = new Array<Projectile>();
    this.group = group;
  }

  public function shoot(X:Float, Y:Float, direction:FlxVector):Projectile {
    var projectile = recycle(X, Y, direction);
    group.add(projectile);

    return projectile;
  }

  function recycle(X:Float, Y:Float, direction:FlxVector):Projectile {
    for(p in projectiles) {
      if(!p.exists) {
        p.initialize(X, Y, direction);
        return p;
      }
    }

    var projectile:Projectile = new Projectile(X, Y, direction);
    projectiles.push(projectile);

    return projectile;
  }
}
