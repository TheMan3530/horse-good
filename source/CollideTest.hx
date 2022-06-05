package; //this is here to test the moving Eds thing in the third song

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;

class CollideTest extends FlxState
{
    var bg:FlxSprite;
    var pico:Character;
    var text:FlxText;

    override function create() 
    {
        bg = new FlxSprite();
        bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.LIME);
        add(bg);

        pico = new Character(Std.int((FlxG.width / 4) * 3), Std.int(FlxG.height / 2), 'pico', true);
        pico.playAnim('idle');
        add(pico);

        super.create();
    }

    override function update(elapsed:Float) 
    {
        super.update(elapsed);

        //if (FlxG.keys.justPressed.E)

        if (FlxG.keys.justPressed.SPACE)
        {
            pico.playAnim('singDOWN');
        }
        
    }
}