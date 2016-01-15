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
  var buttons:Array<MainMenuButton>;
  var selectedIndex:Int = 1;

  public function new():Void {
    super();

    buttons = new Array<MainMenuButton>();
    buttons[0] = new MainMenuButton("options");
    buttons[1] = new MainMenuButton("start");
    buttons[2] = new MainMenuButton("credits");

    for (i in (0...3)) {
      buttons[i].x = (i + 1) * 80;
      add(buttons[i]);
    }
  }

  public override function update(elapsed:Float):Void {
    buttons[selectedIndex].select();
    for (i in (0...3)) {
      if (buttons[i].overlapsMouse()) {
        selectedIndex = i;
      }
      if (i == selectedIndex) {
        buttons[i].select();
      } else {
        buttons[i].deselect();
      }
    }

    if (selectedIndex == 0) FlxTween.tween(buttons[1], { x: 170 }, 0.05, { ease: FlxEase.quadOut });
    if (selectedIndex == 1) FlxTween.tween(buttons[1], { x: 160 }, 0.05, { ease: FlxEase.quadOut });
    if (selectedIndex == 2) FlxTween.tween(buttons[1], { x: 150 }, 0.05, { ease: FlxEase.quadOut });

    if (FlxG.keys.justPressed.LEFT) selectedIndex--;
    if (FlxG.keys.justPressed.RIGHT) selectedIndex++;
    if (selectedIndex < 0) selectedIndex = buttons.length - 1;
    if (selectedIndex >= buttons.length) selectedIndex = 0;

    super.update(elapsed);
  }
}