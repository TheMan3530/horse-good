package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class PiracyCheck
{
    public static function check()
    {
        #if html5
        pirate();
        #else
        trace('all clear');
        #end
    }

    function pirate()
    {
        FlxG.switchState(new Piracy());
    }
}

class Piracy extends FlxState
{
    override function create()
    {
        super.create();

        FlxG.sound.playMusic(Paths.image("antipiracy/aubergine'd"));

        var aubrey:FlxSprite = new FlxSprite();
        aubrey.loadGraphic(Paths.image('antipiracy/piracy'));
        aubrey.screenCenter();
        aubrey.setGraphicSize(Std.int(aubrey.width * 4));
        add(aubrey);

        var caption:FlxText = new FlxText(0, 0, 0, 'Oh no you pirated the game auby is mad\nauby now wants feet pics', 20);
        add(caption);

        //var link:FlxButton = new FlxButton(0, ((FlxG.height / 2) * 1.5), 'Link', gamebanana);
        //add(link);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }

    function gamebanana()
    {
        FlxG.openURL('');
    }
}