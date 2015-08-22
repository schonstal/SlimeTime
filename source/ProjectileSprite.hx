package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class ProjectileSprite extends FlxSprite {
  public inline static var WIDTH = 14;
  public inline static var HEIGHT = 6;

  public var originalWidth:Float = 32;
  public var originalHeight:Float = 32;

  public var onCollisionCallback:Void->Void;

  public function new() {
    super();
    loadGraphic("assets/images/projectiles/player/projectile.png", true, 16, 16);
    animation.add("pulse", [0,1,2,3], 15);
    animation.play("pulse");
    width = WIDTH;
    height = HEIGHT;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function onCollide() {
    if(onCollisionCallback != null) onCollisionCallback();
  }

  override public function updateHitbox():Void
  {
    var newWidth:Float = scale.x * WIDTH;
    var newHeight:Float = scale.y * HEIGHT;
		
    width = newWidth;
    height = newHeight;
    offset.set( - ((newWidth - frameWidth) * 0.5), - ((newHeight - frameHeight) * 0.5));
		centerOrigin();
  }
}
