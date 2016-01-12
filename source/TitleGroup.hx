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
  var clickToBegin:FlxSprite;
  var bg:FlxSprite;

  var sinAmt:Float = 0;

  public function new():Void {
    super();

    bg = new FlxSprite();
    bg.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    add(bg);

    clickToBegin = new FlxSprite();
    clickToBegin.loadGraphic("assets/images/clickToBegin.png");
    clickToBegin.x = FlxG.width/2 - clickToBegin.width/2;
    clickToBegin.y = 180;
    clickToBegin.visible = false;
    add(clickToBegin);

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

    FlxTween.tween(title.scale, { y: 1 }, 1, { ease: FlxEase.quadOut, onComplete: function(t) {
      FlxTween.tween(title, { strength: 0, speed: 25 }, 1, { ease: FlxEase.quartOut, onComplete: function(t) {
        FlxG.camera.flash();
        bg.visible = false;
        clickToBegin.visible = true;
      }});
    }});
  }

  override public function update(elapsed:Float):Void {
    if (FlxG.mouse.justPressed) {
      exists = false;
      Reg.initialized = true;
      FlxG.mouse.visible = false;
    }

    if (FlxG.keys.justPressed.SPACE) {
    }

    super.update(elapsed);
  }
}
