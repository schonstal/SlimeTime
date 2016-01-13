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

class TitleGroup extends FlxSpriteGroup {
  var title:FlxWaveSprite;
  var bg:FlxSprite;

  var optionsText:MenuText;
  var startText:MenuText;
  var creditsText:MenuText;

  public var belchers:FlxSpriteGroup;
  var belcher:MenuBelcher;

  var sinAmt:Float = 0;

  var lastMouseX:Float = 0;

  public function new():Void {
    super();

    belchers = new FlxSpriteGroup();

    bg = new FlxSprite();
    bg.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    add(bg);

    optionsText = new MenuText("options");
    optionsText.y = 180;
    optionsText.x = 80 - optionsText.width/2;
    optionsText.color = 0xff9777a1;
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
    creditsText.color = 0xff9777a1;
    creditsText.visible = false;
    add(creditsText);

    var titleTemplate = new FlxSprite();
    titleTemplate.loadGraphic("assets/images/logo.png");
    titleTemplate.x = FlxG.width/2 - titleTemplate.width/2;
    titleTemplate.y = 37;

    title = new FlxWaveSprite(titleTemplate, FlxWaveMode.START, 0, -1, 3, 7);
    add(title);

    title.center = Std.int(titleTemplate.height) * 2;
    title.scale.y = 0;

    title.strength = 400;
    title.speed = 50;
    title.scale.y = 0;

    belcher = new MenuBelcher();

    FlxTween.tween(title.scale, { y: 1 }, 1, { ease: FlxEase.quadOut, onComplete: function(t) {
      FlxTween.tween(title, { strength: 0, speed: 25 }, 1, { ease: FlxEase.quartOut, onComplete: function(t) {
        FlxG.camera.flash();
        bg.visible = false;
        creditsText.visible = startText.visible = optionsText.visible = true;
        belcher.spawn(FlxG.width/2);
        belchers.add(belcher);
      }});
    }});
  }

  override public function update(elapsed:Float):Void {
    if (FlxG.mouse.justPressed) {
      exists = false;
      Reg.initialized = true;
      FlxG.mouse.visible = false;
    }

    creditsText.color = startText.color = optionsText.color = 0xff9777a1;
    creditsText.scale.x = creditsText.scale.y = 1;
    startText.scale.x = startText.scale.y = 1;
    optionsText.scale.x = optionsText.scale.y = 1;

    if (FlxG.mouse.x < FlxG.width / 3) {
      optionsText.color = 0xffffffff;
      optionsText.scale.x = optionsText.scale.y = 2;
      if (lastMouseX > FlxG.width / 3) belcher.spawn(optionsText.x + optionsText.width/2);
    } else if (FlxG.mouse.x < 2 * FlxG.width / 3) {
      startText.color = 0xffffffff;
      startText.scale.x = startText.scale.y = 2;
      if (lastMouseX < FlxG.width / 3 || lastMouseX > 2 * FlxG.width / 3) belcher.spawn(startText.x + startText.width/2);
    } else {
      creditsText.color = 0xffffffff;
      creditsText.scale.x = creditsText.scale.y = 2;
      if (lastMouseX < 2 * FlxG.width / 3) belcher.spawn(creditsText.x + creditsText.width/2);
    }

    lastMouseX = FlxG.mouse.x;

    optionsText.x = 80 - optionsText.width/2;
    startText.x = FlxG.width/2 - startText.width/2;
    creditsText.x = 240 - creditsText.width/2;

    super.update(elapsed);
  }
}
