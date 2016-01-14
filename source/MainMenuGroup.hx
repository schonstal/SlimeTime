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
  var buttons:Array<MenuText>;
  var selectedIndex:Int = 1;

  public function new():Void {
    super();

    buttons = new Array<MenuText>();
    buttons[0] = new MenuText("options");
    buttons[1] = new MenuText("start");
    buttons[2] = new MenuText("credits");

    for (i in (0...3)) {
      buttons[i].y = 180;
      buttons[i].x = (i + 1) * 80 - buttons[i].width/2;
      add(buttons[i]);
    }
  }

  public override function update(elapsed:Float):Void {
    buttons[selectedIndex].select();
    for (i in (0...3)) {
      if (FlxG.mouse.x > buttons[i].x && FlxG.mouse.x < buttons[i].x + buttons[i].width &&
          FlxG.mouse.y > buttons[i].y && FlxG.mouse.y < buttons[i].y + buttons[i].height) {
        selectedIndex = i;
      }
      if (i == selectedIndex) {
        buttons[i].select();
      } else {
        buttons[i].deselect();
      }
    }

    if (FlxG.keys.justPressed.LEFT) selectedIndex--;
    if (FlxG.keys.justPressed.RIGHT) selectedIndex++;
    if (selectedIndex < 0) selectedIndex = buttons.length - 1;
    if (selectedIndex >= buttons.length) selectedIndex = 0;

    super.update(elapsed);
  }
}
