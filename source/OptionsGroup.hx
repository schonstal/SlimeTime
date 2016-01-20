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

class OptionsGroup extends FlxSpriteGroup {
  var buttons:Array<MenuButton>;
  var mainMenuButton:MainMenuButton;
  var selectedIndex:Int = 0;
  var optionsLabel:LabelText;

  public var showMainMenu:Int->Void;

  public function new():Void {
    super();

    optionsLabel = new LabelText("OPTIONS");
    optionsLabel.scale.x = optionsLabel.scale.y = 2;
    //optionsLabel.x = 80 - optionsLabel.width/2;
    optionsLabel.x = FlxG.width/2 - optionsLabel.width/2;
    optionsLabel.y = 40;
    add(optionsLabel);

    buttons = new Array<MenuButton>();
    buttons[0] = new PipeButton("volume", FlxObject.LEFT, function() { });
    buttons[1] = new PipeButton("music", FlxObject.RIGHT, function() { });
    buttons[2] = new PipeButton("invert x", FlxObject.LEFT, function() { });

    mainMenuButton = new MainMenuButton("main menu", function() { showMainMenu(0); });
    buttons[3] = mainMenuButton;

    for (i in 0...3) {
      buttons[i].y = i * 32 + 64;
      add(buttons[i]);
    }

    mainMenuButton.x = 160;
    add(mainMenuButton);

    exists = false;
  }

  public function initialize(index:Int = 0):Void {
    mainMenuButton.initialize();
    selectedIndex = index;
    exists = true;
  }

  public override function update(elapsed:Float):Void {
    buttons[selectedIndex].select();

    for (i in 0...buttons.length) {
      if (Reg.mouseSelect && buttons[i].overlapsMouse()) {
        selectedIndex = i;
        if (FlxG.mouse.justPressed) buttons[i].activate();
      }
      if (i == selectedIndex) {
        buttons[i].select();
        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) buttons[i].activate();
      } else {
        buttons[i].deselect();
      }
    }

    if (FlxG.keys.justPressed.UP) selectedIndex--;
    if (FlxG.keys.justPressed.DOWN) selectedIndex++;
    if (selectedIndex < 0) selectedIndex = buttons.length - 1;
    if (selectedIndex >= buttons.length) selectedIndex = 0;

    super.update(elapsed);
  }
}
