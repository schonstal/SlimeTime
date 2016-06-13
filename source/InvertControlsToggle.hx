package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class InvertControlsToggle extends MenuBooleanToggle {
  public override function get_value():Bool {
    if (FlxG.save.data.invertControls == null) FlxG.save.data.invertControls = true;
    return FlxG.save.data.invertControls;
  }

  public override function set_value(v:Bool):Bool {
    FlxG.save.data.invertControls = v;
    return v;
  }
}
