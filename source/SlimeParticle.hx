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

class SlimeParticle extends FlxSprite {

  public function new() {
    super();
    loadGraphic("assets/images/projectiles/enemy/particle.png", true, 8, 8);
    animation.add("fade", [0, 0, 1, 2], 10, false);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
    if (y > FlxG.height) exists = false;
  }

  public function initialize(X:Float, Y:Float):Void {
    animation.play("fade");
    x = X;
    y = Y;
    exists = true;
  }
}
