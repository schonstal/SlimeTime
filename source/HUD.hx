package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class HUD extends FlxSpriteGroup {
  var scoreText:BitmapText;
  var scoreLabel:FlxSprite;
  var comboLabel:FlxSprite;
  var healthLabel:FlxSprite;
  var healthBarBackground:FlxSprite;
  var healthBar:FlxSprite;

  public function new():Void {
    super();

    var font = FlxBitmapFont.fromMonospace(
      "assets/images/fonts/numbers2x.png",
      "0123456789",
      new FlxPoint(16, 16)
    );

    scoreText = new BitmapText(font);
    scoreText.letterSpacing = -2;
    scoreText.text = "34500";
    scoreText.x = 4;
    scoreText.y = 8;
    add(scoreText);

    scoreLabel = new FlxSprite(4, 2);
    scoreLabel.loadGraphic("assets/images/hud/score.png");
    add(scoreLabel);

    healthLabel = new FlxSprite(0, 2);
    healthLabel.loadGraphic("assets/images/hud/health.png");
    healthLabel.x = FlxG.width - 4 - healthLabel.width;
    add(healthLabel);

    healthBarBackground = new FlxSprite(0, 8);
    healthBarBackground.loadGraphic("assets/images/hud/healthBar.png");
    healthBarBackground.x = FlxG.width - 4 - healthBarBackground.width;
    add(healthBarBackground); 
  }

  public override function update(elapsed:Float):Void {
    scoreText.text = "" + Reg.score;
    super.update(elapsed);
  }
}
