import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxMath;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;

class Grenade extends Enemy {
  var rng:FlxRandom;
  var particles:Array<SlimeParticle>;

  public function new() {
    super();
    loadGraphic("assets/images/enemies/canister.png", true, 16, 16);
    animation.add("spin", [1, 2, 3, 0], 15, true);
    animation.play("spin");
    points = 50;

    rng = new FlxRandom();
    particles = new Array<SlimeParticle>();
  }

  public override function spawn():Void {
    super.spawn();

    acceleration.y = Player.gravity;
    velocity.y = Reg.random.int(-400, -600);
    animation.play("spin");
    health = 1;

    y = FlxG.height;
    x = Reg.random.int(16, FlxG.width - 32);

    for(i in (0...8)) {
      particles[i] = Reg.splashParticleService.spawn(x, y);
      particles[i].acceleration.y = 800;
      particles[i].velocity.y = FlxMath.lerp(-150, velocity.y/2, i/8);
      particles[i].velocity.x = rng.int(-25, 25);
    }
  }

  public override function update(elapsed:Float):Void {
    if (y > FlxG.height) {
      despawn();
    }
    super.update(elapsed);
  }

  public override function kill():Void {
    super.kill();
    explode();
  }

  function despawn():Void {
    exists = false;
  }

  function explode():Void {
    despawn();
    alive = false;
    //FlxG.camera.shake(0.02, 0.2);
    for(i in (0...8)) {
      Reg.enemyProjectileService.shoot(
        x + 6, y + 6, new FlxVector(Math.cos(i/8 * Reg.TAU + Math.PI/8), Math.sin(i/8 * Reg.TAU + Math.PI/8))
      );
    }
  }
}
