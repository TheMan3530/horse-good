package;

import flixel.FlxSprite;

class Picoyasumi extends FlxSprite
{
    public function new()
    {
        super();
        
        frames = Paths.getSparrowAtlas('characters/picoyasumi');
        animation.addByPrefix('oyasumi', 'picoyasumi', 2, true);
        animation.play('oyasumi');

        flipY = true;

        screenCenter();
    }
}