package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;

class PlayState extends FlxState
{
  var playerProjectileGroup:FlxSpriteGroup;

  override public function create():Void {
    super.create();
    Reg.random = new FlxRandom();

    playerProjectileGroup = new FlxSpriteGroup();

    var background = new FlxSprite();
    background.makeGraphic(FlxG.width, FlxG.height, 0xffffffff);
    add(background);

    Reg.playerProjectileService = new ProjectileService(playerProjectileGroup);

    var p = new Player();
    p.init();
    add(p);

    add(playerProjectileGroup);

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
