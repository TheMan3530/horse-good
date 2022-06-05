package;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIInputText;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;

class DontButton extends FlxState
{
    var goodButton:FlxButton;
    var badButton:FlxButton;

    override function create()
    {
        super.create();

        FlxG.mouse.visible = true;

        goodButton = new FlxButton(Std.int(FlxG.width / 4), 0, 'dont click this', good);
        goodButton.screenCenter(Y);
        add(goodButton);

        badButton = new FlxButton(Std.int((FlxG.width / 4) * 3), 0, 'click this', bad);
        badButton.screenCenter(Y);
        add(badButton);
    }

    function good()
    {
        FlxG.switchState(new DontType());
    }

    function bad()
    {
        badButton.visible = false;
    }

    override function update(elapsed:Float) 
    {
        super.update(elapsed);
    }
}

class DontType extends FlxState 
{
    var daBox:FlxUIInputText;

    override function create() 
    {
        super.create();

        FlxG.mouse.visible = true;

        daBox = new FlxUIInputText(0, 0, 300, '', 10);
		daBox.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.BLACK);
		daBox.screenCenter();
		add(daBox);
        daBox.backgroundColor = FlxColor.WHITE;
        daBox.maxLength = 50;
        daBox.lines = 2;
        daBox.caretColor = FlxColor.GRAY;

        var warning:FlxText = new FlxText(0, 0, 0, ("Don't type " + '"oyasumi" into the bar.'), 30);
        var otherwarning:FlxText = new FlxText(0, 30, 0, 'Type "aubergine" instead.', 30);
        add(warning);
        add(otherwarning);
    }

    override function update(elapsed:Float) 
    {
        super.update(elapsed);

        var daInput = daBox.text.toUpperCase();

        if (FlxG.keys.justPressed.ENTER && daInput != '')
        {
            switch (daInput)
            {
                case 'AUBERGINE' | 'AUBREY':
                {
                    begin('Aubergine');
                }
                case 'OYASUMI': 
                {
                    begin('Oh-Yeah-Sue-Me');
                }
                default: 
                {
                    trace('invalid code');
                }
            }
        }
    }

    function begin(songNew:String)
    {
        var poop:String = Highscore.formatSong(songNew, 1);

		PlayState.SONG = Song.loadFromJson(poop, songNew);
		PlayState.isStoryMode = true;
		PlayState.storyDifficulty = 2;
		PlayState.storyWeek = 69; // ha ha funni number lol
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
    }
}
