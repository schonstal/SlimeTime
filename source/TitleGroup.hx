package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;
import flash.display.BlendMode;

class TitleGroup extends FlxSpriteGroup {
  var title:FlxSprite;

  public function new():Void {
    super();
    title = new FlxSprite();
    title.loadGraphic("assets/images/logo.png");
    add(title);
  }

  override public function update(elapsed:Float):Void {
    if (FlxG.mouse.justPressed) {
      exists = false;
      Reg.initialized = true;
      FlxG.mouse.visible = false;
    }
    super.update(elapsed);
  }
}
