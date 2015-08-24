package;

import flixel.FlxSprite;
import flixel.FlxG;
import flash.display.BlendMode;

class OozeGlow extends FlxSprite {
  var sinAmt:Float = 0;

  public function new() {
    super();
    loadGraphic("assets/images/oozeGlow.png");
    blend = BlendMode.ADD;
    y = FlxG.height/2;
    alpha = 0.2;
  }

  public override function update(elapsed:Float):Void {
    sinAmt += 2 * elapsed;
    alpha = 0.2 + (0.025 * Math.sin(sinAmt));
    super.update(elapsed);
  }
}
