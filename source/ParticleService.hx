package;

import flixel.group.FlxSpriteGroup;
import flixel.math.FlxVector;
import flixel.FlxObject;
import flixel.FlxSprite;

class ParticleService {
  var particles:Array<SlimeParticle> = new Array<SlimeParticle>();
  var group:FlxSpriteGroup;

  public function new(group:FlxSpriteGroup):Void {
    this.particles = new Array<SlimeParticle>();
    this.group = group;
  }

  public function spawn(X:Float, Y:Float):SlimeParticle {
    var particle = recycle(X, Y);
    group.add(particle);

    return particle;
  }

  function recycle(X:Float, Y:Float):SlimeParticle {
    for(p in particles) {
      if(!p.exists) {
        p.initialize(X, Y);
        return p;
      }
    }

    var particle:SlimeParticle = new SlimeParticle();
    particle.initialize(X, Y);
    particles.push(particle);

    return particle;
  }
}
