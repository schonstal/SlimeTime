package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.math.FlxPoint;

import flash.geom.ColorTransform;

class Enemy extends FlxSprite {
  var flashTimer:FlxTimer;
  var explosionTimer:FlxTimer;
  var explosionRate:Float = 0.2;
  var deathTimer:FlxTimer;

  var deathTime:Float = 0;
  var deathWidth:Float = 0;
  var deathHeight:Float = 0;

  var points:Int;

  var explosionOffset:FlxPoint;
  var explosionCount:Int = 1;

  public function new() {
    super();
    health = 5;
    points = 50;
    flashTimer = new FlxTimer();
    explosionTimer = new FlxTimer();
    deathTimer = new FlxTimer();
    explosionOffset = new FlxPoint(0, 0);
  }

  public override function hurt(damage:Float):Void {
    if (!alive) return;

    super.hurt(damage);
    flash();
  }

  public override function kill():Void {
    setColorTransform();
    color = 0xff8c4a53;
    alive = false;

    if (Reg.combo < 10) Reg.combo++;
    Reg.score += points * Reg.combo;
    Reg.pointService.showPoints(x + width/2, y + height/2, points * Reg.combo);

    blowUp();
    die();
  }

  function blowUp():Void {
    FlxG.camera.shake(0.005, 0.2);
    for(i in 0...explosionCount) {
      Reg.enemyExplosionService.explode(x + width/2 + explosionOffset.x,
                                        y + height/2 + explosionOffset.y,
                                        deathWidth, deathHeight);
    }
  }

  function die():Void {
    exists = false;
  }

  public function flash():Void {
    useColorTransform = true;
    setColorTransform(0, 0, 0, 1, 0, 0, 0, 0);

    flashTimer.start(0.025, function(t) {
      setColorTransform(0, 0, 0, 1, 255, 255, 255, 0);

      flashTimer.start(0.025, function(t) {
        setColorTransform();
      });
    });
  }

  public function spawn():Void {
    alive = true;
    exists = true;
    setColorTransform();
  }

  public function onStart():Void {
  };
}
