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

  var sliderInnerBar:FlxSprite;

  var sliderHandle:FlxSprite;
  var sliderHandleBorder:FlxSprite;

  public function new(defaultValue:Float = 0.7):Void {
    super();

    sliderBar = new FlxSprite();
    sliderBar.y = 2;
    sliderBar.x = 1;
    sliderBar.makeGraphic(44, 4, 0xffffffff);

    sliderInnerBar = new FlxSprite();
    sliderInnerBar.y = 2;
    sliderInnerBar.makeGraphic(Std.int(sliderBar.width), Std.int(sliderBar.height), 0xff332c39);

    sliderBarBorder = new FlxSprite();
    sliderBarBorder.makeGraphic(Std.int(sliderBar.width) + 1, Std.int(sliderBar.height) + 3, 0xff000000);
    sliderBarBorder.y = 1;

    add(sliderBarBorder);
    add(sliderInnerBar);
    add(sliderBar);

    sliderHandle = new FlxSprite();
    sliderHandle.makeGraphic(4, 8, 0xffffffff);

    sliderHandleBorder = new FlxSprite();
    sliderHandleBorder.makeGraphic(Std.int(sliderHandle.width) + 2, Std.int(sliderHandle.height) + 3, 0xff000000);
    sliderHandleBorder.y = -1;

    add(sliderHandleBorder);
    add(sliderHandle);

    value = defaultValue;
  }

#if flash
  // Flash does not scale cleanly
  @:access(FlxSprite._flashRect)
#end
  public override function update(elapsed:Float):Void {
    super.update(elapsed);

    if(FlxG.mouse.y > y - 4 && FlxG.mouse.y < y + 12 && FlxG.mouse.pressed) {
      value = (FlxG.mouse.x - x) / sliderBar.width;
    }

    if (value < 0) value = 0;
    if (value > 1) value = 1;

#if flash
    sliderBar._flashRect.setTo(0, 0, Std.int(sliderBar.width * value), 4);
#else
    sliderBar.scale.x = value;
    sliderBar.x = x - (sliderBar.width * (1 - value))/2 + 1;
#end

    sliderHandle.x = x + sliderBar.width * value - sliderHandle.width/2 + 1;
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
