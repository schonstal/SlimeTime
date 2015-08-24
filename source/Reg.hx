package;

import flixel.util.FlxSave;
import flixel.FlxCamera;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import flixel.group.FlxSpriteGroup;

class Reg {
  public static var playerProjectileService:ProjectileService;
  public static var enemyProjectileService:ProjectileService;
  public static var playerLasesrService:LaserService;
  public static var enemyLaserService:EnemyLaserService;
  public static var enemyExplosionService:EnemyExplosionService;

  public static var enemyGroup:FlxSpriteGroup;

  public static var random:FlxRandom;
  public static var started:Bool = false;

  public static var TAU:Float = 6.28318530718;
}
