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
import flixel.addons.effects.FlxWaveSprite;

class MainMenuButton extends FlxSpriteGroup {
  var selected = false;
  var belcher:MenuBelcher;
  var menuText:MenuText;
  var callback:Void->Void;

  public function new(text:String, onPress:Void->Void):Void {
    super();

    menuText = new MenuText(text);
    menuText.y = 172;
    menuText.x = -menuText.width/2;

    belcher = new MenuBelcher();

    add(belcher);
    add(menuText);

    callback = onPress;
  }

  public function select():Void {
    if (selected) return;

    menuText.select();
    belcher.spawn(x);
    selected = true;
  }

  public function deselect():Void {
    if (!selected) return;

    menuText.deselect();
    belcher.despawn();
    selected = false;
  }

  public function activate():Void {
    if (callback != null) callback();
    belcher.select();
  }

  public function overlapsMouse():Bool {
    return FlxG.mouse.x > menuText.x && FlxG.mouse.x < menuText.x + menuText.width &&
           FlxG.mouse.y > menuText.y && FlxG.mouse.y < menuText.y + menuText.height;
  }
}
