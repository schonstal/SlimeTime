package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class MenuBooleanToggle extends MenuToggle {
  var value:Bool = true;

  var onText:MenuText;
  var offText:MenuText;

  public function new(defaultValue:Bool = true):Void {
    super();

    value = defaultValue;

    onText = new MenuText("on", false);
    add(onText);

    offText = new MenuText("off", false);
    offText.x = onText.width + 8;
    add(offText);
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);
    
    if (value) {
      onText.select();
      offText.deselect();
    } else {
      offText.select();
      onText.deselect();
    }
  }
  
  public override function decrement():Void {
    value = true;
  }

  public override function increment():Void {
    value = false;
  }

  override function toggle():Void {
    value = !value;
  }
}
