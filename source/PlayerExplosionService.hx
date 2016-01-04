package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;

class EnemyExplosionService {
  var enemyExplosions:Array<EnemyExplosion> = new Array<EnemyExplosion>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.enemyExplosions = new Array<EnemyExplosion>();
    this.group = group;
  }

  public function explode(X:Float, Y:Float, width:Float = 0, height:Float = 0):EnemyExplosion {
    var x = X + Reg.random.float(0, width);
    var y = Y + Reg.random.float(0, height);

    var enemyExplosion = recycle(x, y);
    group.add(enemyExplosion);
    enemyExplosion.explode();

    return enemyExplosion;
  }

  function recycle(X:Float, Y:Float):EnemyExplosion {
    for(p in enemyExplosions) {
      if(!p.exists) {
        p.initialize(X, Y);
        return p;
      }
    }

    var enemyExplosion:EnemyExplosion = new EnemyExplosion();
    enemyExplosion.initialize(X, Y);
    enemyExplosions.push(enemyExplosion);

    return enemyExplosion;
  }
}
