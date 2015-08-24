package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;

class HUD extends FlxSpriteGroup {
  var scoreText:BitmapText;
  var comboText:BitmapText;

  var scoreLabel:FlxSprite;
  var comboLabel:FlxSprite;
  var maxCombo:FlxSprite;
  var healthLabel:FlxSprite;
  var healthBarBackground:FlxSprite;
  var healthBar:FlxSprite;

  var previousHealth:Float = 0;

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

    comboLabel = new FlxSprite(0, 4);
    comboLabel.loadGraphic("assets/images/hud/combo.png");
    comboLabel.x = FlxG.width/2 - comboLabel.width/2;
    add(comboLabel);

    comboText = new BitmapText(font);
    comboText.letterSpacing = -2;
    comboText.text = "0";
    comboText.x = FlxG.width/2 - 8;
    comboText.y = 10;
    add(comboText);

    maxCombo = new FlxSprite(0, 10);
    maxCombo.loadGraphic("assets/images/hud/max.png");
    maxCombo.x = FlxG.width/2 - maxCombo.width/2;
    add(maxCombo);

    healthLabel = new FlxSprite(0, 2);
    healthLabel.loadGraphic("assets/images/hud/health.png");
    healthLabel.x = FlxG.width - 4 - healthLabel.width;
    add(healthLabel);

    healthBarBackground = new FlxSprite(0, 8);
    healthBarBackground.loadGraphic("assets/images/hud/healthBar.png");
    healthBarBackground.x = FlxG.width - 4 - healthBarBackground.width;
    add(healthBarBackground); 

    healthBar = new FlxSprite(healthBarBackground.x + 4, healthBarBackground.y + 4);
    healthBar.makeGraphic(Std.int(healthBarBackground.width) - 8,
                          Std.int(healthBarBackground.height) - 10,
                          0xffff1472);
    add(healthBar);
  }

  public override function update(elapsed:Float):Void {
    scoreText.text = "" + Reg.score;
    comboText.text = "" + Reg.combo;

    if (Reg.combo > 1) {
      comboLabel.visible = true;
      if (Reg.combo >= 10) {
        maxCombo.visible = true;
        comboText.visible = false;
      } else {
        comboText.visible = true;
      }
    } else {
      comboLabel.visible = false;
      comboText.visible = false;
      maxCombo.visible = false;
    }
 

    var width:Int = Std.int((healthBarBackground.width - 8) * Reg.player.health/100);
    if (Reg.player.health != previousHealth && width > 0) {
      healthBar.makeGraphic(width, Std.int(healthBar.height), 0xffff1472);
      healthBar.x = healthBarBackground.x + healthBarBackground.width - 4 - healthBar.width;
    } else if (width <= 0) {
      healthBar.visible = false;
    }
    previousHealth = Reg.player.health;
    super.update(elapsed);
  }
}
