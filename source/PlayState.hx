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

  var enemyGroup:FlxSpriteGroup;
  var enemyExplosionGroup:FlxSpriteGroup;
  var pipes:WallPipes;

  var spawnGroup:SpawnGroup;
  var player:Player;

  var level:Room;
  var slime:Slime;

  override public function create():Void {
    super.create();
    FlxG.camera.flash(0xffffffff, 1);
    Reg.random = new FlxRandom();
    Reg.started = false;
    Reg.difficulty = 0;

    playerProjectileGroup = new FlxSpriteGroup();
    playerLaserGroup = new FlxSpriteGroup();

    enemyProjectileGroup = new FlxSpriteGroup();
    enemyLaserGroup = new FlxSpriteGroup();
    enemyGroup = new FlxSpriteGroup();
    enemyExplosionGroup = new FlxSpriteGroup();
    
    Reg.enemyGroup = enemyGroup;
    Reg.enemyExplosionService = new EnemyExplosionService(enemyExplosionGroup);

    Reg.playerProjectileService = new ProjectileService(playerProjectileGroup);
    Reg.playerLasesrService = new LaserService(playerLaserGroup);

    Reg.enemyProjectileService = new ProjectileService(enemyProjectileGroup, "enemy");
    Reg.enemyLaserService = new EnemyLaserService(enemyLaserGroup);

    level = new Room("assets/tilemaps/level.tmx");
    add(level.backgroundTiles);

    spawnGroup = new SpawnGroup();
    add(spawnGroup);

    player = new Player(spawnGroup.x + 6, spawnGroup.y + 6);
    player.init();
    add(player);

    enemyGroup.add(new GrenadeGroup());
    enemyGroup.add(new BelcherGroup());
    add(enemyGroup);

    add(playerLaserGroup);
    add(enemyLaserGroup);

    add(new OozeGlow());

    add(level.foregroundTiles);

    pipes = new WallPipes();
    add(pipes);

    slime = new Slime();
    add(slime);

    add(playerProjectileGroup);
    add(enemyProjectileGroup);

    add(enemyExplosionGroup);

    add(new HUD());

    //DEBUGGER
    FlxG.debugger.drawDebug = true;
  }

  override public function destroy():Void {
    super.destroy();
  }

  override public function update(elapsed:Float):Void {
    if (player.started) spawnGroup.exists = false;
    level.collideWithLevel(player);

    if (Reg.started) Reg.difficulty += elapsed/1000;
    if (Reg.difficulty >= 1) Reg.difficulty = 1;

    FlxG.overlap(slime, enemyProjectileGroup, Projectile.handleCollision);
    FlxG.overlap(slime, playerProjectileGroup, Projectile.handleCollision);
    FlxG.overlap(enemyLaserGroup, playerProjectileGroup, Projectile.handleCollision);

    FlxG.overlap(enemyGroup, playerProjectileGroup, function(enemy:FlxObject, projectile:FlxObject):Void {
      if (enemy.alive) Projectile.handleCollision(enemy, projectile);
      enemy.hurt(1);
    });

    FlxG.overlap(pipes, playerProjectileGroup, function(pipe:FlxObject, projectile:FlxObject):Void {
      Projectile.handleCollision(pipe, projectile);
      cast(pipe, Pipe).hurt(1);
    });

    level.collideWithLevel(playerProjectileGroup, Projectile.handleCollision);
    level.collideWithLevel(enemyProjectileGroup, Projectile.handleCollision);

    FlxG.overlap(player, enemyProjectileGroup, function(player:FlxObject, projectile:FlxObject):Void {
      Projectile.handleCollision(player, projectile);
      player.hurt(10);
    });

    FlxG.overlap(player, enemyLaserGroup, function(player:FlxObject, laser:FlxObject):Void {
      player.hurt(10);
    });

    FlxG.overlap(player, slime, function(player:FlxObject, laser:FlxObject):Void {
      player.hurt(10);
    });

    super.update(elapsed);

    var laserSprite:FlxObject;
    FlxG.overlap(enemyGroup, playerLaserGroup, function(enemy:FlxObject, laser:FlxObject):Void {
      if (enemy.y < FlxG.height - 14) enemy.hurt(10);
      laserSprite = laser;
    });
    if (laserSprite != null) laserSprite.solid = false;
  }
}
