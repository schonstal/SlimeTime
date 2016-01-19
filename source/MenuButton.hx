package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class MenuButton extends FlxSpriteGroup {
  var selected = false;
  var callback:Void->Void;

  public function new(onPress:Void->Void):Void {
    super();

    callback = onPress;
  }

  public function select():Void {
  }

  public function deselect():Void {
  }

  public function activate():Void {
    if (callback != null) callback();
  }

  public function overlapsMouse():Bool {
    return FlxG.mouse.x > x && FlxG.mouse.x < x + width &&
           FlxG.mouse.y > y && FlxG.mouse.y < y + height;
  }
}
