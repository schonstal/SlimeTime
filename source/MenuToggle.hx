package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class MenuToggle extends MenuButton {
  public function new():Void {
    super(toggle);
  }

  public function toggle():Void {}

  public function increment():Void { toggle(); }
  public function decrement():Void { toggle(); }
}
