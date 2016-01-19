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

class MainMenuButton extends MenuButton {
  var belcher:MenuBelcher;
  var menuText:MenuText;

  public function new(text:String, onPress:Void->Void):Void {
    super(onPress);

    menuText = new MenuText(text);
    menuText.y = 172;
    menuText.x = -menuText.width/2;

    belcher = new MenuBelcher();

    add(belcher);
    add(menuText);
  }

  public override function onSelect():Void {
    menuText.select();
    belcher.spawn(x);
  }

  public override function onDeselect():Void {
    menuText.deselect();
    belcher.despawn();
  }

  public override function activate():Void {
    super.activate();
    belcher.select();
    menuText.deselect();
    FlxG.camera.flash(0x88ffffff, 0.2);
  }

  public function initialize():Void {
    deselect();
    belcher.initialize();
  }

  public override function overlapsMouse():Bool {
    return FlxG.mouse.x > menuText.x && FlxG.mouse.x < menuText.x + menuText.width &&
           FlxG.mouse.y > menuText.y;
  }
}
