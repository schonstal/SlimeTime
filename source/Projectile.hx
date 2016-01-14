package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class Projectile extends FlxSpriteGroup
{
  inline static var SPEED = 450;

  public var direction:FlxVector;
  public var physical = true;

  var projectile:ProjectileSprite;
  var particles:Array<FlxSprite>;
  var particleGroup:FlxSpriteGroup;
  var explosionSprite:FlxSprite;
  var showParticles:Bool;
  var name:String;

  public function new(X:Float, Y:Float, direction:FlxVector, facing:Int, showParticles:Bool = false, name:String):Void {
    super(X, Y);
    this.showParticles = showParticles;
    this.name = name;
    this.facing = facing;

    particles = new Array<FlxSprite>();
    particleGroup = new FlxSpriteGroup();
    add(particleGroup);

    projectile = new ProjectileSprite(name);
    projectile.onCollisionCallback = onCollide;
    add(projectile);

    explosionSprite = new FlxSprite();
    explosionSprite.loadGraphic('assets/images/projectiles/$name/hit.png', true, 16, 16);
    explosionSprite.animation.add("explode", [0, 1, 2, 3, 4, 5], 15, false);
    explosionSprite.solid = false;
    if (name == "enemy") {
      explosionSprite.setFacingFlip(0, true, false);
      explosionSprite.setFacingFlip(1, false, false);
      explosionSprite.setFacingFlip(2, true, true);
      explosionSprite.setFacingFlip(3, false, true);
    } else {
      explosionSprite.setFacingFlip(FlxObject.LEFT, false, false);
      explosionSprite.setFacingFlip(FlxObject.RIGHT, true, false);
    }
    explosionSprite.animation.finishCallback = explosionFinished;
    add(explosionSprite);

    initialize(X, Y, direction, facing);
  }
  
  public function initialize(X:Float, Y:Float, direction:FlxVector, facing:Int):Void {
    x = X;
    y = Y;
    projectile.x = X;
    projectile.y = Y;
    projectile.facing = facing;
    physical = true;
    visible = true;
    this.facing = facing;

    projectile.updateHitbox();
    projectile.initialize();

    exists = projectile.exists = particleGroup.exists = explosionSprite.exists = true;
    if (showParticles) spawnParticle();

    explosionSprite.visible = false;
    this.direction = direction;
    var speed = name == "enemy" ? 100 : SPEED;
    projectile.velocity.x = direction.x * speed;
    projectile.velocity.y = direction.y * speed;
  }

  private function spawnParticle():FlxSprite {
    var particle:FlxSprite = null;

    for (p in particles) {
      if (!p.exists) {
        p.exists = true;
        particle = p;
        break;
      }
    }

    if (particle == null) {
      particle = new FlxSprite();
      particle.loadGraphic('assets/images/projectiles/$name/particle.png', true, 8, 8);
      particle.animation.add("fade", [0, 1, 2, 3], 15, false);
      particle.animation.play("fade");
      particle.solid = false;
      new FlxTimer().start(0.2, function(t) { particle.exists = false; });
      particleGroup.add(particle);
    }

    particle.x = projectile.x + Reg.random.int(-1, 1);
    particle.y = projectile.y + Reg.random.int(-1, 1);
    particle.velocity.x = projectile.velocity.x/4;
    particle.velocity.y = projectile.velocity.y/4;

    new FlxTimer().start(0.1, function(t) { if(projectile.exists) spawnParticle(); });
    return particle;
  }

  public function onCollide():Void {
    if(!physical) return;
    physical = false;

    explosionSprite.x = projectile.x - 5;
    explosionSprite.y = projectile.y - 5;
    explosionSprite.visible = true;
    explosionSprite.animation.play("explode");
    if (name == "enemy") {
      explosionSprite.facing = Reg.random.int(0, 3);
    } else {
      explosionSprite.facing = facing;
      explosionSprite.x += facing == FlxObject.LEFT ? 3 : -3;
    }
    projectile.exists = false;
    //FlxG.camera.shake(0.02, 0.3);
    //FlxG.sound.play("assets/sounds/orb_explode.wav");
  }

  function explosionFinished(_:String):Void {
    explosionSprite.exists = false;
    exists = false;
  }

  public static function handleCollision(other, projectile):Void {
    cast(projectile, ProjectileSprite).onCollide();
  }
}
