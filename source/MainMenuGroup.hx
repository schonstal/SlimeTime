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

class MainMenuGroup extends FlxSpriteGroup {
  var lastMouseX:Float = 0;

  var optionsText:MenuText;
  var startText:MenuText;
  var creditsText:MenuText;

  public function new():Void {
    super();

    optionsText = new MenuText("options");
    optionsText.y = 180;
    optionsText.x = 80 - optionsText.width/2;
    optionsText.visible = false;
    add(optionsText);

    startText = new MenuText("start");
    startText.y = 180;
    startText.x = FlxG.width/2 - startText.width/2;
    startText.scale.x = startText.scale.y = 2;
    startText.visible = false;
    add(startText);

    creditsText = new MenuText("credits");
    creditsText.y = 180;
    creditsText.x = 240 - creditsText.width/2;
    creditsText.visible = false;
    add(creditsText);
  }

  public override function update(elapsed:Float):Void {
    optionsText.deselect();
    startText.deselect();
    creditsText.deselect();

    if (FlxG.mouse.x < FlxG.width / 3) {
      optionsText.select();
    } else if (FlxG.mouse.x < 2 * FlxG.width / 3) {
      startText.select();
    } else {
      creditsText.select();
    }

    lastMouseX = FlxG.mouse.x;

    optionsText.x = 80 - optionsText.width/2;
    startText.x = FlxG.width/2 - startText.width/2;
    creditsText.x = 240 - creditsText.width/2;

    super.update(elapsed);
  }
}
