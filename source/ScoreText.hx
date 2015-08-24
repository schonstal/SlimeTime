package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;
import flixel.text.FlxText;

class HUD extends FlxSpriteGroup {
  var scoreText:FlxText;
  var size:Int = 28;

  public function new():Void {
    super();

    scoreText = new FlxText();
    scoreText.x = 12;
    scoreText.y = 12;
    scoreText.setFormat(
      "assets/fonts/acknowtt.ttf",
      28,
      FlxColor.WHITE,
      FlxTextAlign.LEFT,
      FlxTextBorderStyle.OUTLINE,
      FlxColor.BLACK
    );
    scoreText.color = 0xffffffff;
    scoreText.borderColor = 0xff000000;
    scoreText.text = "154350";
    add(scoreText);
  }

  public override function update(elapsed:Float):Void {
    if (FlxG.keys.justPressed.Q) size++;
    if (FlxG.keys.justPressed.E) size--;
    scoreText.setFormat(
      "assets/fonts/acknowtt.ttf",
      size,
      FlxColor.WHITE,
      FlxTextAlign.LEFT,
      FlxTextBorderStyle.OUTLINE,
      FlxColor.BLACK
    );
    super.update(elapsed);
  }
}
