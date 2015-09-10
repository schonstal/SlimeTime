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

class TitleGroup extends FlxSpriteGroup {
  var title:FlxSprite;
  var clickToBegin:FlxSprite;

  var sinAmt:Float = 0;

  public function new():Void {
    super();
    clickToBegin = new FlxSprite();
    clickToBegin.loadGraphic("assets/images/clickToBegin.png");
    clickToBegin.x = FlxG.width/2 - clickToBegin.width/2;
    clickToBegin.y = 180;
    clickToBegin.visible = false;
    add(clickToBegin);

    title = new FlxSprite();
    title.loadGraphic("assets/images/logo.png");
    title.x = FlxG.width/2 - title.width/2;
    title.y = 37;
    title.angle = 360;
    title.scale.x = title.scale.y = 0;
    add(title);

    FlxTween.tween(title, { angle: 0 }, 1, { ease: FlxEase.elasticOut });
    FlxTween.tween(title.scale, { x: 1, y: 1 }, 1, { ease: FlxEase.elasticOut, onComplete: function(t) {
      new FlxTimer().start(0.5, function(t) {
        FlxG.camera.flash();
        clickToBegin.visible = true;
      });
    }});
  }

  override public function update(elapsed:Float):Void {
    if (FlxG.mouse.justPressed) {
      exists = false;
      Reg.initialized = true;
      FlxG.mouse.visible = false;
    }

    super.update(elapsed);
  }
}
