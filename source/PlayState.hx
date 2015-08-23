package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
  var playerProjectileGroup:FlxSpriteGroup;
  var playerLaserGroup:FlxSpriteGroup;

  var enemyProjectileGroup:FlxSpriteGroup;
  var enemyLaserGroup:FlxSpriteGroup;

  var spawnGroup:SpawnGroup;
  var player:Player;

  var level:Room;
  var slime:Slime;

  override public function create():Void {
    super.create();
    Reg.random = new FlxRandom();

    playerProjectileGroup = new FlxSpriteGroup();
    playerLaserGroup = new FlxSpriteGroup();

    enemyProjectileGroup = new FlxSpriteGroup();
    enemyLaserGroup = new FlxSpriteGroup();

    Reg.playerProjectileService = new ProjectileService(playerProjectileGroup);
    Reg.playerLasesrService = new LaserService(playerLaserGroup);

    Reg.enemyProjectileService = new ProjectileService(enemyProjectileGroup, "enemy");
    Reg.enemyLaserService = new EnemyLaserService(enemyLaserGroup);

    level = new Room("assets/tilemaps/level.tmx");
    add(level.backgroundTiles);
    add(playerLaserGroup);
    add(enemyLaserGroup);

    spawnGroup = new SpawnGroup();
    add(spawnGroup);

    player = new Player(spawnGroup.x + 6, spawnGroup.y + 6);
    player.init();
    add(player);

    add(level.foregroundTiles);
    add(new WallPipes());

    var g = new Grenade();
    g.spawn();
    add(g);

    slime = new Slime();
    add(slime);

    add(playerProjectileGroup);
    add(enemyProjectileGroup);

    //DEBUGGER
    FlxG.debugger.drawDebug = true;
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    if (player.started) spawnGroup.exists = false;
    level.collideWithLevel(player);
    level.collideWithLevel(playerProjectileGroup, Projectile.handleCollision);
    level.collideWithLevel(enemyProjectileGroup, Projectile.handleCollision);
    FlxG.overlap(slime, enemyProjectileGroup, Projectile.handleCollision);
    FlxG.overlap(slime, playerProjectileGroup, Projectile.handleCollision);

    FlxG.overlap(player, enemyProjectileGroup, function(player, projectile):Void {
      Projectile.handleCollision(player, projectile);
      cast(player, Player).die();
      FlxG.camera.flash(0xff33ff88, 0.5);
      spawnGroup.exists = true;
      player.x = spawnGroup.x + 6;
      player.y = spawnGroup.y + 6;
    });
    super.update(elapsed);
  }
}
