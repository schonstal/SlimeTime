package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;

import flixel.math.FlxVector;
import flixel.math.FlxMath;

class HealthGroup extends FlxSpriteGroup {
  var spawnTimer:Float = 5;
  var particles:FlxSpriteGroup;
  var healthSprite:Health;

  var particleTimer:Float = 0;
  var particleThreshold:Float = 0.025;

  public function new() {
    super();
    particles = new FlxSpriteGroup();
    add(particles);
  }

  override public function update(elapsed:Float):Void {
    if (Reg.started) {
      spawnTimer -= elapsed;
      if (spawnTimer < 0) {
        spawnTimer = Reg.random.float(
          FlxMath.lerp(8, 6, Reg.difficulty),
          FlxMath.lerp(12, 10, Reg.difficulty)
        );

        healthSprite = cast(recycle(Health), Health);
        healthSprite.spawn();
        add(healthSprite);
      }
    }

    if(healthSprite != null && healthSprite.exists) {
      spawnParticles(elapsed);
    }

    super.update(elapsed);
  }

  function spawnParticles(elapsed:Float) {
    particleTimer += elapsed;
    if (particleTimer >= particleThreshold) {
      var particle:FlxSprite = particles.recycle(FlxSprite);
      var size = Reg.random.int(0, 2);

      particle.loadGraphic("assets/images/healthParticle.png", true, 5, 5);
      particle.animation.add("0", [0]);
      particle.animation.add("1", [0]);
      particle.animation.add("2", [1]);
      particle.animation.play('$size');

      particle.color = FlxColor.fromHSB(336,
        size > 1 ? 0.9 : 0.1,
        Reg.random.float(0.8, 1)
      );

      particle.x = healthSprite.x + Reg.random.int(0, 12);
      particle.y = healthSprite.y;

      particle.velocity.x = Reg.random.int(-10, 10);
      particle.velocity.y = Reg.random.int(-10, 0);

      particle.exists = true;
      particle.visible = true;
      particle.solid = false;

      new FlxTimer().start(Reg.random.float(0.3, 0.6), function(t) {
        particle.exists = false;
      });

      particleTimer = 0;
    }
  }
}
