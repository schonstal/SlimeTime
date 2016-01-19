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

  public var startGame:Void->Void;
  public var showOptions:Int->Void;
  public var showCredits:Void->Void;

  public function new():Void {
    super();

    buttons = new Array<MainMenuButton>();
    buttons[0] = new MainMenuButton("options", function() { showOptions(0); });
    buttons[1] = new MainMenuButton("start", function() { startGame(); });
    buttons[2] = new MainMenuButton("credits", function() { showCredits(); });

    for (i in (0...3)) {
      buttons[i].x = (i + 1) * 80;
      add(buttons[i]);
    }
  }

  public function initialize(index:Int = 1):Void {
    for (button in buttons) {
      button.initialize();
    }
    selectedIndex = index;
    exists = true;
  }

  public override function update(elapsed:Float):Void {
    buttons[selectedIndex].select();
    for (i in (0...3)) {
      if (buttons[i].overlapsMouse()) {
        selectedIndex = i;
        if (FlxG.mouse.justPressed) buttons[i].activate();
      }
      if (i == selectedIndex) {
        buttons[i].select();
        if (FlxG.keys.justPressed.ENTER) buttons[i].activate();
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
