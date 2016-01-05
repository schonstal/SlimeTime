import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText.FlxTextAlign;
import flixel.util.FlxSpriteUtil;

class LabelText extends FlxBitmapText {
  public function new(content:String, X:Float = 0, Y:Float = 0):Void {
    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/alphabetRed.png",
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      new FlxPoint(8, 9)
    );

    super(font);

    letterSpacing = -1;
    text = content;
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
