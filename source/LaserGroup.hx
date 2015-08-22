package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;

import flixel.math.FlxVector;

class LaserGroup extends FlxSpriteGroup {
  var laserSprite:FlxSprite;

  var particles:FlxSpriteGroup;

  public function new():Void {
    super();

    particles = new FlxSpriteGroup(); 
    add(particles);

    laserSprite = new FlxSprite();
    laserSprite.loadGraphic("assets/images/projectiles/laser.png", true, 12, 240);
    laserSprite.animation.add("shoot", [0, 1, 2, 3], 15);
    add(laserSprite);
  }

  public function initialize(X, Y):Void {
    x = X;
    y = Y;
  }

  public function shoot(facing:Int):Void {
    laserSprite.facing = facing;
    laserSprite.animation.play("shoot");
  }
}
