package;

import flixel.FlxSprite;
import flixel.FlxG;

class ProjectileSprite extends FlxSprite {
  public inline static var WIDTH = 14;
  public inline static var HEIGHT = 6;

  public inline static var OFFSET_X = 9;
  public inline static var OFFSET_Y = 16;

  public var originalWidth:Float = 32;
  public var originalHeight:Float = 32;

  public var onCollisionCallback:Void->Void;

  public function new() {
    super();
    loadGraphic("assets/images/projectiles/player/projectile.png", true, 32, 32);
    animation.add("pulse", [0,1,2,3], 15);
    animation.play("pulse");
    width = WIDTH;
    height = HEIGHT;
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
    offset.y += OFFSET_Y;
		centerOrigin();
  }
}
