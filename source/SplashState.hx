package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxTimer;

class SplashState extends FlxState
{
  var splash:FlxSprite;
  var bg:FlxSprite;

  override public function create():Void {
    FlxG.mouse.useSystemCursor = true;
    FlxG.sound.muteKeys = null;
    if (FlxG.save.data.invertControls == null) FlxG.save.data.invertControls = true;

    bg = new FlxSprite();
    bg.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
    add(bg);

    splash = new FlxSprite();
    splash.loadGraphic("assets/images/splash.png");

      FlxG.sound.play("assets/sounds/bading.wav");
    new FlxTimer().start(0.25, function(t):Void {
      add(splash);
      new FlxTimer().start(2, function(t):Void {
        remove(splash);
        new FlxTimer().start(0.75, function(t):Void {
          FlxG.switchState(new StartupState());
        });
      });
    });
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
