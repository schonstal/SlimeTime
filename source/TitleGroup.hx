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
import flixel.math.FlxPoint;

class TitleGroup extends FlxSpriteGroup {
  public var mainMenuGroup:MainMenuGroup;
  public var optionsGroup:OptionsGroup;

  var lastMousePosition:FlxPoint;

  var title:FlxWaveSprite;
  var bg:FlxSprite;

  public function new():Void {
    super();

    lastMousePosition = FlxG.mouse.toPoint();

    mainMenuGroup = new MainMenuGroup();
    mainMenuGroup.visible = false;
    mainMenuGroup.startGame = startGame;
    mainMenuGroup.showOptions = showOptions;
    mainMenuGroup.showCredits = showCredits;

    optionsGroup = new OptionsGroup();
    optionsGroup.showMainMenu = showMainMenu;

    bg = new FlxSprite();
    bg.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    add(bg);

    var titleTemplate = new FlxSprite();
    titleTemplate.loadGraphic("assets/images/logo.png");
    titleTemplate.x = FlxG.width/2 - titleTemplate.width/2;
    titleTemplate.y = 32;

    title = new FlxWaveSprite(titleTemplate, FlxWaveMode.START, 0, -1, 3, 7);
    add(title);

    title.center = Std.int(titleTemplate.height) * 2;
    title.scale.y = 0;

    title.strength = 400;
    title.speed = 50;
    title.scale.y = 0;

    FlxTween.tween(title.scale, { y: 1 }, 1, { ease: FlxEase.quadOut, onComplete: function(t) {
      FlxTween.tween(title, { strength: 0, speed: 25 }, 1, { ease: FlxEase.quartOut, onComplete: function(t) {
        FlxG.camera.flash();
        bg.visible = false;
        mainMenuGroup.visible = true;
      }});
    }});
  }

  override public function update(elapsed:Float):Void {
    var nextMousePosition = FlxG.mouse.toPoint();
    if (!lastMousePosition.equals(nextMousePosition)) {
      Reg.mouseSelect = true;
    }
    lastMousePosition.put();
    lastMousePosition = nextMousePosition;

    if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN ||
        FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.RIGHT ||
        FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) {
      Reg.mouseSelect = false;
    }

    super.update(elapsed);
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
    FlxG.mouse.visible = false;
  }

  function showCredits():Void {
  }
}
