package;

import flixel.FlxG;
import flixel.FlxState;

class Mono extends FlxState
{
    override function create()
    {
        FlxG.sound.play(Paths.sound("ImEd"), 1, false, null, true, monochrome);
    }

    function monochrome()
    {
        var poop:String = Highscore.formatSong('Monochrome', 1);

		PlayState.SONG = Song.loadFromJson(poop, 'Monochrome');
		PlayState.isStoryMode = true;
		PlayState.storyDifficulty = 2;
		PlayState.storyWeek = 420; // ha ha funni number lol
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
    }
}