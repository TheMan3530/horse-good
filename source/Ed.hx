package;

import flixel.FlxG;
import flixel.ui.FlxButton;

class Ed extends FlxButton
{
    var theAnim:String;

    public var isRed:Bool = false;

    override public function new(x:Float, y:Float, ?chance:Int, ?OnClick:Void->Void) 
    {
        super(x, y, OnClick);

        var redChance = FlxG.random.int(0, chance);

        loadGraphic(Paths.image('edButt'), true, 1000, 988);

        animation.add('good', [0], 1);
        animation.add('bad', [1], 1);
        animation.add('bad-colour', [2], 1);

        if (redChance == 0)
        {
            animation.play('good');

            isRed = false;
        }
        else
        {
            isRed = true;
            
            if (PlayStateChangeables.colorBlind)
            {
                animation.play('bad-colour');
            }
            else 
            {
                animation.play('bad');
            }
        }
    }
}
