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
import flixel.addons.effects.chainable.FlxWaveEffect;

class OptionsGroup extends FlxSpriteGroup {
  var buttons:Array<MenuButton>;
  var mainMenuButton:MainMenuButton;
  var selectedIndex:Int = 0;
  var optionsLabel:LabelText;

  var toggles:Array<MenuToggle>;

  public var showMainMenu:Int->Void;

  public var mouseLocked:Bool = false;

  public function new():Void {
    super();

    optionsLabel = new LabelText("OPTIONS");
    optionsLabel.scale.x = optionsLabel.scale.y = 2;
    //optionsLabel.x = 80 - optionsLabel.width/2;
    optionsLabel.x = FlxG.width/2 - optionsLabel.width/2;
    optionsLabel.y = 40;
    add(optionsLabel);

    buttons = new Array<MenuButton>();
    buttons[0] = new PipeButton("volume", FlxObject.LEFT);
    buttons[1] = new PipeButton("music", FlxObject.RIGHT);
    buttons[2] = new PipeButton("invert x", FlxObject.LEFT);

    mainMenuButton = new MainMenuButton("main menu", function() { showMainMenu(0); });
    buttons[3] = mainMenuButton;

    mainMenuButton.x = 161;
    add(mainMenuButton);

    toggles = new Array<MenuToggle>();
    toggles[0] = new VolumeSliderToggle();
    toggles[1] = new MenuSliderToggle();
    toggles[2] = new MenuBooleanToggle(false);

    for (i in 0...3) {
      buttons[i].y = i * 32 + 64;
      buttons[i].x = -6;

      toggles[i].x = FlxG.width/2 + 6;
      toggles[i].y = buttons[i].y + 12.5;

      add(buttons[i]);
      add(toggles[i]);
    }

    exists = false;
  }

  public function initialize(index:Int = 0):Void {
    mainMenuButton.initialize();
    selectedIndex = index;
    exists = true;
  }

  public override function update(elapsed:Float):Void {
    buttons[selectedIndex].select();
    if (!FlxG.mouse.pressed) Reg.mouseLockY = 0;
    if (Reg.mouseLockY > 0) {
      super.update(elapsed);
      return;
    }

    for (i in 0...buttons.length) {
      if (Reg.mouseSelect && buttons[i].overlapsMouse()) {
        selectedIndex = i;
        if (FlxG.mouse.justPressed) {
          buttons[i].activate();
          if (i < toggles.length) toggles[i].activate();
        }
      }
      if (i == selectedIndex) {
        if (i < toggles.length) toggles[i].select();
        buttons[i].select();
        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) buttons[i].activate();
        if (FlxG.keys.justPressed.ENTER && i < toggles.length) toggles[i].toggle();
        if (FlxG.keys.justPressed.LEFT && i < toggles.length) toggles[i].decrement();
        if (FlxG.keys.justPressed.RIGHT && i < toggles.length) toggles[i].increment();
      } else {
        if (i < toggles.length) toggles[i].deselect();
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
