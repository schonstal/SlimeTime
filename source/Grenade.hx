import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;
import flixel.group.FlxSpriteGroup;

class Grenade extends Enemy {
  public function new() {
    super();
    loadGraphic("assets/images/enemies/canister.png", true, 16, 16);
    animation.add("spin", [1, 2, 3, 0], 15, true);
    animation.add("explode", [4, 5, 6, 7], 15, false);
    animation.finishCallback = onAnimationComplete;
    animation.play("spin");
    points = 50;
  }

  public override function spawn():Void {
    super.spawn();

    acceleration.y = Player.gravity;
    velocity.y = Reg.random.int(-300, -600);
    animation.play("spin");
    health = 2;

    y = FlxG.height;
    x = Reg.random.int(16, FlxG.width - 32);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
    if (velocity.y >= 10) {
      acceleration.y = 0;
      velocity.y = 0;
      explode();
    }
  }

  function explode():Void {
    animation.play("explode");
    alive = false;
    //FlxG.camera.shake(0.02, 0.2);
    for(i in (0...8)) {
      Reg.enemyProjectileService.shoot(
        x + 6, y + 6, new FlxVector(Math.cos(i/8 * Reg.TAU), Math.sin(i/8 * Reg.TAU))
      );
    }
  }

  function onAnimationComplete(name:String) {
    if (name == "explode") exists = false;
  }
}
