package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.FlxState;

class StartupState extends FlxState
{
  var title:FlxEffectSprite;
  var waveEffect:FlxWaveEffect;
  var bg:FlxSprite;

  override public function create():Void {
    super.create();
    FlxG.mouse.useSystemCursor = true;

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
        FlxG.switchState(new PlayState());
      }});
    }});
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
