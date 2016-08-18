package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class VolumeSliderToggle extends MenuSliderToggle {
  var initialized:Bool = false;

  public function new():Void {
    super(FlxG.sound.volume);
    initialized = true;
  }

  public override function get_value():Float {
    return FlxG.sound.volume;
  }

  public override function set_value(volume:Float):Float {
    FlxG.sound.volume = volume;
    return volume;
  }
}
