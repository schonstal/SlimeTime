package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class VolumeSliderToggle extends MenuSliderToggle {
  var initialized:Bool = false;

  public function new():Void {
    super(FlxG.save.data.sfxVolume);
    initialized = true;
  }

  public override function get_value():Float {
    return FlxG.save.data.sfxVolume;
  }

  public override function set_value(volume:Float):Float {
    FlxG.save.data.sfxVolume = volume;
    return volume;
  }
}
