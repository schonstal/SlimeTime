package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

import flash.geom.ColorTransform;

class Enemy extends FlxSprite {
  public function new() {
    super();
  }

  public function flash():Void {
    useColorTransform = true;
    setColorTransform(0, 0, 0, 1, 0, 0, 0, 0);

    new FlxTimer().start(0.025, function(t) {
      setColorTransform(0, 0, 0, 1, 255, 255, 255, 0);

      new FlxTimer().start(0.025, function(t) {
        useColorTransform = false;
      });
    });
  }

  public function spawn():Void {
    // Just for the interface for now
  }
}
