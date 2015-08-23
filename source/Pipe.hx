package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

class Pipe extends Enemy {
  public function new(side:Int, Y:Float) {
    super();
    y = Y;

    setFacingFlip(FlxObject.LEFT, false, false);
    setFacingFlip(FlxObject.RIGHT, true, false);

    facing = side;

    if (facing == FlxObject.DOWN) angle = 90;

    loadRotatedGraphic("assets/images/pipe.png");

    if(side == FlxObject.LEFT) {
      x = -width;
    } else {
      x = FlxG.width;
    }
    new FlxTimer().start(1, function(t) { shoot(); });
    spawn();
  }

  public override function spawn():Void {
    exists = true;
    FlxTween.tween(this,
                   { x: facing == FlxObject.LEFT ? 0 : FlxG.width - width },
                   0.5,
                   { ease: FlxEase.bounceOut });
  }

  public function shoot():Void {
    Reg.enemyLaserService.shoot(y, facing);
  }
}
