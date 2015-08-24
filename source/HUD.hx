package;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class HUD extends FlxSpriteGroup {
  var scoreText:BitmapText;

  public function new():Void {
    super();

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers2x.png",
      "0123456789",
      new FlxPoint(16, 16)
    );

    scoreText = new BitmapText(font);
    scoreText.letterSpacing = -2;
    scoreText.text = "34500";
    add(scoreText);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
