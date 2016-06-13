package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class MenuBooleanToggle extends MenuToggle {
  var value(get, set):Bool;
  var _value:Bool = true;

  var onText:MenuText;
  var offText:MenuText;

  public function get_value():Bool {
    return _value;
  }

  public function set_value(v:Bool):Bool {
    _value = v;
    return v;
  }

  public function new():Void {
    super();

    onText = new MenuText("on", false);
    add(onText);

    offText = new MenuText("off", false);
    offText.x = onText.width + 8;
    add(offText);

    onText.deselectedColor = offText.deselectedColor = 0xff332c39;
    onText.selectedColor = offText.selectedColor = 0xff9777a1;
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
    FlxG.sound.play("assets/sounds/enemyHurt.wav");
  }

  public override function increment():Void {
    value = false;
    FlxG.sound.play("assets/sounds/enemyHurt.wav");
  }

  public override function onSelect():Void {
    onText.selectedColor = offText.selectedColor = 0xffffffff;
  }

  public override function onDeselect():Void {
    onText.selectedColor = offText.selectedColor = 0xff9777a1;
  }

  public override function activate():Void {
    toggle();
  }

  public override function toggle():Void {
    FlxG.sound.play("assets/sounds/enemyHurt.wav");
    value = !value;
  }
}
