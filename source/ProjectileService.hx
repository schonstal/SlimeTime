package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class ProjectileService {
  var projectiles:Array<Projectile> = new Array<Projectile>();
  var group:FlxSpriteGroup;
  var showParticles:Bool;
  var name:String;

  public function new(group:FlxSpriteGroup, name:String = "player", showParticles:Bool = false):Void {
    this.projectiles = new Array<Projectile>();
    this.group = group;
    this.showParticles = showParticles;
    this.name = name;
  }

  public function shoot(X:Float, Y:Float, direction:FlxVector, facing:Int = FlxObject.LEFT):Projectile {
    var projectile = recycle(X, Y, direction, facing, name);
    group.add(projectile);

    return projectile;
  }

  function recycle(X:Float, Y:Float, direction:FlxVector, facing:Int, name:String):Projectile {
    for(p in projectiles) {
      if(!p.exists) {
        p.initialize(X, Y, direction, facing);
        return p;
      }
    }

    var projectile:Projectile = new Projectile(X, Y, direction, facing, showParticles, name);
    projectiles.push(projectile);

    return projectile;
  }
}
