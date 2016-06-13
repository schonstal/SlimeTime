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
import flixel.addons.effects.chainable.FlxEffectSprite;

class TitleGroup extends FlxSpriteGroup {
  public var mainMenuGroup:MainMenuGroup;
  public var optionsGroup:OptionsGroup;

  var title:FlxSprite;

  public function new():Void {
    super();

    mainMenuGroup = new MainMenuGroup();
    mainMenuGroup.startGame = startGame;
    mainMenuGroup.showOptions = showOptions;
    mainMenuGroup.startHardMode = startHardMode;

    optionsGroup = new OptionsGroup();
    optionsGroup.showMainMenu = showMainMenu;

    title = new FlxSprite();
    title.loadGraphic("assets/images/logo.png");
    title.x = FlxG.width/2 - title.width/2;
    title.y = 32;
    add(title);
  }

  function showMainMenu(index:Int = 1):Void {
    optionsGroup.exists = false;
    title.exists = true;
    mainMenuGroup.initialize(index);
  }

  function showOptions(index:Int = 0):Void {
    mainMenuGroup.exists = false;
    title.exists = false;
    optionsGroup.initialize(index);
  }

  function startGame():Void {
    exists = false;
    mainMenuGroup.exists = false;
    Reg.initialized = true;
  }

  function startHardMode():Void {
    Reg.hardMode = true;
    startGame();
  }
}
