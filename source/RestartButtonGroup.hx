package;

import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class RestartButtonGroup extends FlxSpriteGroup {
  var buttons:Array<GameOverButton>;
  var selectedIndex:Int = 0;

  public function new():Void {
    super();

    buttons = new Array<GameOverButton>();
    buttons[0] = new GameOverButton("retry", function() { FlxG.switchState(new PlayState()); });
    buttons[1] = new GameOverButton("menu", function() {
      Reg.initialized = false;
      FlxG.switchState(new PlayState());
    });

    buttons[0].x = FlxG.width/2 - 30;
    buttons[1].x = FlxG.width/2 + 30;

    add(buttons[0]);
    add(buttons[1]);
  }

  public function initialize(index:Int = 1):Void {
    selectedIndex = index;
    exists = true;
  }

  public override function update(elapsed:Float):Void {
    buttons[selectedIndex].select();
    for (i in (0...2)) {
      if (Reg.mouseSelect && buttons[i].overlapsMouse()) {
        selectedIndex = i;
        if (FlxG.mouse.justPressed) buttons[i].activate();
      }
      if (i == selectedIndex) {
        buttons[i].select();
        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) buttons[i].activate();
      } else {
        buttons[i].deselect();
      }
    }

    if (FlxG.keys.justPressed.LEFT) selectedIndex--;
    if (FlxG.keys.justPressed.RIGHT) selectedIndex++;
    if (selectedIndex < 0) selectedIndex = buttons.length - 1;
    if (selectedIndex >= buttons.length) selectedIndex = 0;

    super.update(elapsed);
  }
}
