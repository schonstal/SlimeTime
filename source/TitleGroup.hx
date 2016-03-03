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
import flixel.math.FlxPoint;

class TitleGroup extends FlxSpriteGroup {
  public var mainMenuGroup:MainMenuGroup;
  public var optionsGroup:OptionsGroup;

  var lastMousePosition:FlxPoint;

  var title:FlxEffectSprite;
  var waveEffect:FlxWaveEffect;
  var bg:FlxSprite;

  public function new():Void {
    super();

    lastMousePosition = FlxG.mouse.getWorldPosition();

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

    title = new FlxEffectSprite(titleTemplate);
    title.x = FlxG.width/2 - titleTemplate.width/2;
    title.y = 32;
    title.scale.y = 0;

    waveEffect = new FlxWaveEffect(FlxWaveMode.START, 0, -1, 3, 7);
    waveEffect.center = Std.int(titleTemplate.height) * 2;
    waveEffect.strength = 400;
    waveEffect.speed = 50;
    title.effects = [waveEffect];

    add(title);

    FlxTween.tween(title.scale, { y: 1 }, 1, { ease: FlxEase.quadOut, onComplete: function(t) {
      FlxTween.tween(waveEffect, { strength: 0, speed: 25 }, 1, { ease: FlxEase.quartOut, onComplete: function(t) {
        FlxG.camera.flash();
        bg.visible = false;
        mainMenuGroup.visible = true;
      }});
    }});
  }

  override public function update(elapsed:Float):Void {
    var nextMousePosition = FlxG.mouse.getWorldPosition();
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
