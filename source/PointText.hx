package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText.FlxTextAlign;
import flixel.util.FlxSpriteUtil;

class PointText extends FlxSpriteGroup {
  var scoreText:FlxBitmapText;

  public function new(X:Float, Y:Float, amount:Int):Void {
    super();

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers.png",
      "0123456789",
      new FlxPoint(8, 8)
    );

    scoreText = new FlxBitmapText(font);
    scoreText.letterSpacing = -1;
    initialize(X, Y, amount);
    add(scoreText);
  }

  public function initialize(X:Float, Y:Float, amount:Int):Void {
    exists = true;

    scoreText.text = "" + amount;
    scoreText.x = X - scoreText.width/2;
    scoreText.y = Y - 20;
    scoreText.exists = true;

    scoreText.velocity.y = -30;
    FlxSpriteUtil.flicker(this, 0.3, 0.04, true, true, function(flicker) {
      scoreText.exists = false;
      exists = false;
    });
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
