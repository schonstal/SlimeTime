package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;

import flixel.math.FlxVector;
import flixel.math.FlxMath;

class CoinGroup extends FlxSpriteGroup {
  var spawnTimer:Float = 3;
  var particles:FlxSpriteGroup;
  var coinSprite:Coin;

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
          FlxMath.lerp(3, 2, Reg.difficulty),
          FlxMath.lerp(4, 3, Reg.difficulty)
        );

        coinSprite = cast(recycle(Coin), Coin);
        coinSprite.spawn();
        add(coinSprite);
      }
    }

    if(coinSprite != null && coinSprite.exists) {
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

      particle.color = FlxColor.fromHSB(41,
        size > 1 ? 0.9 : 0.1,
        Reg.random.float(0.8, 1)
      );

      particle.x = coinSprite.x + Reg.random.int(0, 12);
      particle.y = coinSprite.y;

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
