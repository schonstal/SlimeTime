package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.math.FlxVector;
import flash.display.BlendMode;

class SpawnGroup extends FlxSpriteGroup {
  var squares:FlxSpriteGroup;

  var controlsBlaster:FlxSprite;
  var controlsLaser:FlxSprite;

  public function new():Void {
    super();

    squares = new FlxSpriteGroup();

    var square = new FlxSprite();
    square.loadGraphic("assets/images/player/spawn.png");
    square.color = 0xffffff00;
    square.blend = BlendMode.ADD;
    square.y = 70;
    square.x = FlxG.width/2 - square.width/2;
    squares.add(square);
    
    square = new FlxSprite();
    square.loadGraphic("assets/images/player/spawn.png");
    square.color = 0xffff00ff;
    square.blend = BlendMode.ADD;
    square.y = 70;
    square.x = FlxG.width/2 - square.width/2;
    squares.add(square);

    square = new FlxSprite();
    square.loadGraphic("assets/images/player/spawn.png");
    square.color = 0xff00ffff;
    square.blend = BlendMode.ADD;
    square.y = 70;
    square.x = FlxG.width/2 - square.width/2;
    squares.add(square);

    add(squares);

    controlsBlaster = new FlxSprite();
    controlsBlaster.loadGraphic("assets/images/controlsBlaster.png");
    controlsBlaster.x = FlxG.width/2 - controlsBlaster.width/2 - FlxG.width/5;
    controlsBlaster.y = 116;
    add(controlsBlaster);

    controlsLaser = new FlxSprite();
    controlsLaser.loadGraphic("assets/images/controlsLaser.png");
    controlsLaser.x = FlxG.width/2 - controlsLaser.width/2 + FlxG.width/5;
    controlsLaser.y = 116;
    add(controlsLaser);
  }

  override public function update(elapsed:Float):Void {
    for (square in squares.members) {
      square.offset.x = Reg.random.int(-1, 1);
      square.offset.y = Reg.random.int(-1, 1);
    }
    super.update(elapsed);
  }
}
