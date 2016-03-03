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

class PipeButton extends MenuButton {
  var pipe:MenuPipe;
  var menuText:MenuText;

  public function new(text:String, side:Int):Void {
    super(null);

    menuText = new MenuText(text, false);
    menuText.y = 8;
    menuText.x = FlxG.width/2 - menuText.width;

    pipe = new MenuPipe(side);
    pipe.y = 8;

    add(pipe);
    add(menuText);

    pipe.tweenIn();
  }

  public override function onSelect():Void {
    menuText.select();
    pipe.shoot();
  }

  public override function onDeselect():Void {
    menuText.deselect();
    pipe.stopShooting();
  }

  public override function overlapsMouse():Bool {
    return FlxG.mouse.y > pipe.y && FlxG.mouse.y < pipe.y + pipe.height;
  }
}
