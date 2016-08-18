package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class MusicSliderToggle extends MenuSliderToggle {
  var initialized:Bool = false;

  public function new():Void {
    super(FlxG.save.data.musicVolume);
    initialized = true;
  }

  public override function get_value():Float {
    return FlxG.save.data.musicVolume;
  }

  public override function set_value(volume:Float):Float {
    FlxG.save.data.musicVolume = volume;
    return volume;
  }
}
