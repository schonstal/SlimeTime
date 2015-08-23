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
    makeGraphic(12, 12, 0xff33ff88);
  }

  public override function spawn():Void {
    acceleration.y = Player.gravity;
    velocity.y = Reg.random.int(-300, -600);

    y = FlxG.height;
    x = Reg.random.int(16, FlxG.width - 16);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
    if (velocity.y >= 10) explode();
  }

  function explode():Void {
    exists = false;
    FlxG.camera.shake(0.02, 0.2);
    for(i in (0...8)) {
      Reg.enemyProjectileService.shoot(
        x + 6, y + 6, new FlxVector(Math.cos(i/8 * Reg.TAU), Math.sin(i/8 * Reg.TAU))
      );
    }
  }
}
