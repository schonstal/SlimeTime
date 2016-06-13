package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;
import flash.display.BlendMode;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class GameOverButton extends MenuButton {
  var menuText:MenuText;

  public function new(text:String, onPress:Void->Void):Void {
    super(onPress);

    menuText = new MenuText(text);
    menuText.y = 172;
    menuText.x = -menuText.width/2;

    add(menuText);
  }

  public override function onSelect():Void {
    menuText.select();
  }

  public override function onDeselect():Void {
    menuText.deselect();
  }

  public override function activate():Void {
    super.activate();
    menuText.deselect();
  }

  public override function overlapsMouse():Bool {
    return FlxG.mouse.x > menuText.x && FlxG.mouse.x < menuText.x + menuText.width &&
           FlxG.mouse.y > menuText.y;
  }
}
