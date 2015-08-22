package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
  override public function create():Void {
    super.create();
    FlxG.camera.pixelPerfectRender = false;

    var background = new FlxSprite();
    background.makeGraphic(FlxG.width, FlxG.height, 0xffffffff);
    add(background);

    var p = new Player();
    p.init();
    add(p);

    //DEBUGGER
    FlxG.debugger.drawDebug = true;
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }
}
