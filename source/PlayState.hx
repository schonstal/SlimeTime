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
  var playerLaserGroup:FlxSpriteGroup;
  var spawnGroup:SpawnGroup;
  var player:Player;

  override public function create():Void {
    super.create();
    Reg.random = new FlxRandom();

    playerProjectileGroup = new FlxSpriteGroup();
    playerLaserGroup = new FlxSpriteGroup();

    Reg.playerProjectileService = new ProjectileService(playerProjectileGroup);
    Reg.playerLasesrService = new LaserService(playerLaserGroup);

    spawnGroup = new SpawnGroup();
    add(spawnGroup);

    add(playerLaserGroup);

    player = new Player(spawnGroup.x + 6, spawnGroup.y + 6);
    player.init();
    add(player);

    add(playerProjectileGroup);

    //DEBUGGER
    FlxG.debugger.drawDebug = true;
  }
  
  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    if (player.started) spawnGroup.exists = false;
    super.update(elapsed);
  }
}
