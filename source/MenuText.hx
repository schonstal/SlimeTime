import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText.FlxTextAlign;
import flixel.util.FlxSpriteUtil;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class MenuText extends FlxBitmapText {
  var selected = false;
  var activeTween:FlxTween;
  var scales:Bool = true;

  public var selectedColor:Int = 0xffffffff;
  public var deselectedColor:Int = 0xff9777a1;

  public function new(content:String, scale:Bool = true):Void {
#if html5
    var font = FlxBitmapFont.fromXNA(
      "assets/images/fonts/alphabetXNA-WebGL.png",
      "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    );
#else
    var font = FlxBitmapFont.fromXNA(
      "assets/images/fonts/alphabetXNA.png",
      "abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      0xff33ff33
    );
#end

    super(font);

    letterSpacing = -1;
    text = content;

    offset.y = -height/2;
    y -= height/2;
    height = 2 * height;

    color = 0xff9777a1;
    scales = scale;
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
  }

  public function select():Void {
    color = selectedColor;

    if (selected) return;
    selected = true;

    if (scales) {
      if (activeTween != null) activeTween.cancel();
      activeTween = FlxTween.tween(scale, { x: 2, y: 2 }, 0.05, { ease: FlxEase.quadOut });
      width = 2 * width;
      offset.x = -width/4;
      x -= width/4;
    }
  }

  public function deselect():Void {
    color = deselectedColor;

    if (!selected) return;
    selected = false;

    if (scales) {
      if (activeTween != null) activeTween.cancel();
      activeTween = FlxTween.tween(scale, { x: 1, y: 1 }, 0.05, { ease: FlxEase.quadOut });
      width = width/2;
      offset.x = 0;
      x += width/2;
    }
  }
}
