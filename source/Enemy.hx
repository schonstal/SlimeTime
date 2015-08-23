package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

import flash.geom.ColorTransform;

class Enemy extends FlxSprite {
  var flashTimer:FlxTimer;

  public function new() {
    super();
    health = 10;
    flashTimer = new FlxTimer();
  }

  public override function hurt(damage:Float):Void {
    //don't call super...
    health -= damage;
    flash();
  }

  public function flash():Void {
    useColorTransform = true;
    setColorTransform(0, 0, 0, 1, 0, 0, 0, 0);

    flashTimer.start(0.025, function(t) {
      setColorTransform(0, 0, 0, 1, 255, 255, 255, 0);

      flashTimer.start(0.025, function(t) {
        useColorTransform = false;
      });
    });
  }

  public function spawn():Void {
    // Just for the interface for now
  }
}
