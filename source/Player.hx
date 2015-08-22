package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flash.geom.Point;
import flixel.system.FlxSound;
import flixel.math.FlxRandom;
import flixel.math.FlxVector;

class Player extends FlxSprite
{
  public static var RUN_SPEED:Float = 200;

  var speed:Point;
  var gravity:Float = 800;
  var terminalVelocity:Float = 200;

  var started:Bool = false;
  var dead:Bool = false;

  var jumpPressed:Bool = false;
  var jumpAmount:Float = 300;
  var jumpTimer:Float = 0;
  var jumping:Bool = false;
  var jumpThreshold:Float = 0.075;

  var shootTimer:Float = 0;
  var shootRate:Float = 0.05;

  var elapsed:Float = 0;

  public function new(X:Float=0,Y:Float=0) {
    super(X,Y);
    loadGraphic("assets/images/player.png", true, 12, 12);

    animation.add("jump start", [0], 15, true);
    animation.add("jump peak", [1], 15, true);
    animation.add("jump fall", [2], 15, true);
    animation.play("jump fall");

    //width = 12;
    //height = 15;

    //offset.y = 1;
    //offset.x = 3;

    speed = new Point();
    speed.y = jumpAmount;
    speed.x = 800;

    maxVelocity.x = RUN_SPEED;

    setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);
  }

  public function init():Void {
    jumpPressed = false;
    jumping = false;

    jumpTimer = 0;

    velocity.x = velocity.y = 0;
    acceleration.x = 0;

    facing = FlxObject.RIGHT;
    acceleration.y = gravity;
    started = true;
  }

  private function isJumpPressed():Bool {
    //Check for jump input, allow for early timing
    jumpTimer += elapsed;
    if(justPressed("jump")) {
      jumpPressed = true;
      jumpTimer = 0;
    }
    if(jumpTimer > jumpThreshold) {
      jumpPressed = false;
    }

    return jumpPressed;
  }

  private function jump():Void {
    animation.play("jump start");
    jumping = true;
    velocity.y = -speed.y;
    jumpPressed = false;
    FlxG.camera.flash(0x33ffffff, 0.1);
    Reg.playerLasesrService.shoot(x, y + height - 6, facing);
  }

  private function tryJumping():Void {
    if(isJumpPressed()) jump();

    if(velocity.y < -1) {
      if(velocity.y > -50) {
        animation.play("jump peak");
      }
    } else if (velocity.y > 1) {
      if(velocity.y > 100) {
        animation.play("jump fall");
      }
    }

    if(!pressed("jump") && velocity.y < 0)
      acceleration.y = gravity * 3;
    else
      acceleration.y = gravity;
  }

  private function handleMovement():Void {
    if(pressed("left")) {
      acceleration.x = -speed.x * (velocity.x > 0 ? 4 : 1);
      facing = FlxObject.LEFT;
      shoot();
    } else if(pressed("right")) {
      acceleration.x = speed.x * (velocity.x < 0 ? 4 : 1);
      facing = FlxObject.RIGHT;
      shoot();
    } else if (Math.abs(velocity.x) < 10) {
      velocity.x = 0;
      acceleration.x = 0;
    } else if (velocity.x > 0) {
      acceleration.x = -speed.x * 2;
    } else if (velocity.x < 0) {
      acceleration.x = speed.x * 2;
    }

    if (x < 0) x = 0;
    if (x > FlxG.width - width) x = FlxG.width - width;
    if (y < 0) y = 0;
    if (y > FlxG.height - height) y = FlxG.height - height;
  }

  private function shoot():Void {
    if (shootTimer <= 0) {
      var direction = new FlxVector(facing == FlxObject.LEFT ? 1 : -1, 0);
      Reg.playerProjectileService.shoot(x, y + 3, direction, facing);
      shootTimer = shootRate;
    }
  }

  private function computeTerminalVelocity():Void {
    if(velocity.y > terminalVelocity) {
      velocity.y = terminalVelocity;
    }
  }

  override public function update(elapsed:Float):Void {
    this.elapsed = elapsed;

    if(!dead && started) {
      handleMovement();
      tryJumping();
      computeTerminalVelocity();
      shootTimer -= elapsed;
    }

    super.update(elapsed);
  }

  public function die():Void {
    visible = false;
    dead = true;
    acceleration.y = acceleration.x = velocity.x = velocity.y = 0;
  }

  private function justPressed(action:String):Bool {
    switch(action) {
      case "jump":
        return FlxG.keys.justPressed.W || FlxG.keys.justPressed.UP || FlxG.keys.justPressed.SPACE;
    }
    return false;
  }

  private function pressed(action:String):Bool {
    switch(action) {
      case "jump":
        return FlxG.keys.pressed.W || FlxG.keys.pressed.UP || FlxG.keys.pressed.SPACE;
      case "left":
        return FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A;
      case "right":
        return FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D;
      case "direction":
        return pressed("left") || pressed("right");
    }
    return false;
  }
}
