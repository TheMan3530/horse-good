package;

import flixel.addons.ui.FlxUITooltip;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;

class SecretBeat extends FlxState
{
    var daNumber:FlxSprite;

    public function new(sonic:Bool)
    {
        super();
        
        if (!sonic)
        {
            create();
        }
        else
        {
            FlxG.switchState(new Sonic());
        }
    }
    override function create() 
    {
        super.create();

        FlxG.sound.playMusic(Paths.music('breakfast'));

        var daArt:FlxSprite = new FlxSprite(0, 0);
        daArt.loadGraphic(Paths.image('numberleft/congrats'));
        daArt.screenCenter();
        add(daArt);

        var num = Std.string(5 - Secret.secretsUnlocked.length);

        daNumber = new FlxSprite(540, 590);
        daNumber.loadGraphic(Paths.image('numberleft/$num'));
        add(daNumber);

        trace(Secret.secretsUnlocked);
        trace(Secret.secretsUnlocked.length);

        if (num == '0')
            Secret.dearest = true;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
        {
            FlxG.switchState(new MainMenuState());
        }
    }
}

class Sonic extends FlxState
{
    var daNumber:FlxSprite;
    
    override function create() 
    {
        super.create();

        FlxG.sound.playMusic(Paths.inst('horse'));

        var daArt:FlxSprite = new FlxSprite(0, 0);
        daArt.loadGraphic(Paths.image('numberleft/touchgrass'));
        daArt.screenCenter();
        add(daArt);

        var num = Std.string(5 - Secret.secretsUnlocked.length);

        trace(Secret.secretsUnlocked);
        trace(Secret.secretsUnlocked.length);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
        {
            FlxG.switchState(new MainMenuState());
        }
    }
}

class Third extends FlxState
{
    override function create() 
    {
        super.create();

        FlxG.sound.playMusic(Paths.music('breakfast'));

        var daArt:FlxSprite = new FlxSprite(0, 0);
        daArt.loadGraphic(Paths.image('numberleft/troll'));
        daArt.screenCenter();
        add(daArt);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE)
        {
            FlxG.switchState(new MainMenuState());
        }
    }
}

class Secret
{
    public static var secretsUnlocked:Array<String> = [];
    public static var dearest:Bool = false;

    function new()
    {
        FlxG.save.data.secrets = secretsUnlocked;
        FlxG.save.data.dearest = dearest;
    }
}