package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class MenuSliderToggle extends MenuToggle {
  var value:Float = 0.7;
  var previousValue:Float = 0;

  var sliderBar:FlxSprite;
  var sliderBarBorder:FlxSprite;

  var sliderHandle:FlxSprite;
  var sliderHandleBorder:FlxSprite;

  public function new(defaultValue:Float = 0.7):Void {
    super();

    sliderBar = new FlxSprite();
    sliderBar.y = 2;
    sliderBar.makeGraphic(48, 4, 0xffffffff);

    sliderBarBorder = new FlxSprite();
    sliderBarBorder.makeGraphic(Std.int(sliderBar.width) + 2, Std.int(sliderBar.height) + 2, 0xff000000);
    sliderBarBorder.x = -1;
    sliderBarBorder.y = 1;

    add(sliderBarBorder);
    add(sliderBar);

    sliderHandle = new FlxSprite();
    sliderHandle.makeGraphic(4, 8, 0xffffffff);

    sliderHandleBorder = new FlxSprite();
    sliderHandleBorder.makeGraphic(Std.int(sliderHandle.width) + 2, Std.int(sliderHandle.height) + 2, 0xff000000);
    sliderHandleBorder.y = -1;

    add(sliderHandleBorder);
    add(sliderHandle);

    value = defaultValue;
  }

  public override function update(elapsed:Float):Void {
    super.update(elapsed);

    if(FlxG.mouse.y > y - 4 && FlxG.mouse.y < y + 12 && FlxG.mouse.pressed) {
      value = (FlxG.mouse.x - x) / sliderBar.width;
    }

    if (value < 0) value = 0;
    if (value > 1) value = 1;

    sliderBar.scale.x = value;
    sliderBar.x = x - (sliderBar.width * (1 - value))/2;

    sliderHandle.x = x + sliderBar.width * value - sliderHandle.width/2;
    sliderHandleBorder.x = sliderHandle.x - 1;
  }
  
  public override function decrement():Void {
    value -= 0.1;
  }

  public override function increment():Void {
    value += 0.1;
  }

  public override function onSelect():Void {
    color = 0xffffffff;
  }

  public override function onDeselect():Void {
    color = 0xff9777a1;
  }

  public override function toggle():Void {
    if (value > 0) {
      previousValue = value;
      value = 0;
    } else {
      value = previousValue;
    }
  }
}
