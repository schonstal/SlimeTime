package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class ProjectileSprite extends FlxSprite {
  var WIDTH = 6;
  var HEIGHT = 6;
  var name:String;

  public var onCollisionCallback:Void->Void;

  public function new(name:String = "player") {
    super();
    this.name = name;
    var size = name == "player" ? 16 : 8;

    loadGraphic('assets/images/projectiles/$name/projectile.png', true, size, size);
    animation.add("pulse", [0, 1, 2], 10);
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
    if (name == "player") {
      offset.x += (facing == FlxObject.LEFT ? 4 : -4);
    }
  }
}
