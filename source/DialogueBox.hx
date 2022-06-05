package;

import flixel.FlxBasic;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var vPortrait:FlxSprite;
	var portraitTroll:FlxSprite;
	var portraitBf:FlxSprite;
	var portraitGf:FlxSprite;
	var portraitEd:FlxSprite;
	var portraitGfSad:FlxSprite;
	var portraitPicoS:FlxSprite;
	var portraitPicoSad:FlxSprite;
	var portraitPicoAngry:FlxSprite;
	var portraitPico:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	var bigBlackBox:FlxSprite;

	private static var isntBf:Bool = false;

	var mainBox:Bool = false;
	var downBad:Bool = false;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai' | 'placeholder':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'horse': 
				FlxG.sound.playMusic(Paths.inst('pico'), 0.5);
			case 'horse-drip': 
				FlxG.sound.playMusic(Paths.inst('horse-drip'), 1);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				mainBox = false;
				downBad = false;

			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

				mainBox = false;
				downBad = false;

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

				mainBox = false;
				downBad = false;

			case 'trolled': 
				bigBlackBox = new FlxSprite();
				bigBlackBox.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
				add(bigBlackBox);

				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('dialogueBox-4k');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				mainBox = false;
				downBad = true;

			case 'aubergine': 
				bigBlackBox = new FlxSprite();
				bigBlackBox.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
				add(bigBlackBox);

				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'speech bubble normal', 24, true);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.y = Std.int(FlxG.height / 2);

				mainBox = true;
				downBad = false;

			default: 
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'speech bubble normal', 24, true);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.y = Std.int(FlxG.height / 2);

				mainBox = true;
				downBad = false;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight);
		portraitRight.visible = false;

		vPortrait = new FlxSprite(100, FlxG.height - 510);
		vPortrait.loadGraphic(Paths.image('portraits/vintendo'));
		vPortrait.updateHitbox();
		vPortrait.scrollFactor.set();
		vPortrait.flipX = true;
		add(vPortrait);
		vPortrait.visible = false;

		portraitTroll = new FlxSprite(100, FlxG.height - 510);
		portraitTroll.loadGraphic(Paths.image('portraits/troll'));
		portraitTroll.updateHitbox();
		portraitTroll.scrollFactor.set();
		add(portraitTroll);
		portraitTroll.visible = false;

		portraitBf = new FlxSprite(-25, FlxG.height - 510);
		portraitBf.loadGraphic(Paths.image('portraits/bf-dark'));
		portraitBf.updateHitbox();
		portraitBf.scrollFactor.set();
		portraitBf.flipX = true;
		add(portraitBf);
		portraitBf.visible = false;

		portraitGf = new FlxSprite(800, FlxG.height - 535);
		portraitGf.loadGraphic(Paths.image('portraits/gf'));
		portraitGf.updateHitbox();
		portraitGf.scrollFactor.set();
		add(portraitGf);
		portraitGf.visible = false;

		portraitEd = new FlxSprite(-200, FlxG.height - 900);
		portraitEd.loadGraphic(Paths.image('portraits/ed'));
		portraitEd.updateHitbox();
		portraitEd.setGraphicSize(Std.int(portraitEd.width / 4));
		portraitEd.scrollFactor.set();
		portraitEd.flipX = true;
		add(portraitEd);
		portraitEd.visible = false;

		portraitGfSad = new FlxSprite(800, FlxG.height - 525);
		portraitGfSad.loadGraphic(Paths.image('portraits/gf_sad'));
		portraitGfSad.updateHitbox();
		portraitGfSad.scrollFactor.set();
		add(portraitGfSad);
		portraitGfSad.visible = false;

		portraitPicoS = new FlxSprite(750, FlxG.height - 550);
		portraitPicoS.loadGraphic(Paths.image('portraits/pico-missed'));
		portraitPicoS.updateHitbox();
		portraitPicoS.scrollFactor.set();
		add(portraitPicoS);
		portraitPicoS.visible = false;

		portraitPicoSad = new FlxSprite(750, FlxG.height - 550);
		portraitPicoSad.loadGraphic(Paths.image('portraits/pico_sad'));
		portraitPicoSad.updateHitbox();
		portraitPicoSad.scrollFactor.set();
		add(portraitPicoSad);
		portraitPicoSad.visible = false;

		portraitPicoAngry = new FlxSprite(750, FlxG.height - 550);
		portraitPicoAngry.loadGraphic(Paths.image('portraits/pico_sad_angry'));
		portraitPicoAngry.updateHitbox();
		portraitPicoAngry.scrollFactor.set();
		add(portraitPicoAngry);
		portraitPicoAngry.visible = false;

		portraitPico = new FlxSprite(750, FlxG.height - 550);
		portraitPico.loadGraphic(Paths.image('portraits/pico'));
		portraitPico.updateHitbox();
		portraitPico.scrollFactor.set();
		add(portraitPico);
		portraitPico.visible = false;
		
		if (!mainBox)
		{
			box.animation.play('normalOpen');
			box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
			box.updateHitbox();
			add(box);
		}
		else 
		{
			box.animation.play('normalOpen');
			//box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
			box.updateHitbox();
			add(box);
		}

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);

		if (downBad)
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			
			swagDialogue = new FlxTypeText(240, 475, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Muff99 Regular';
			swagDialogue.color = FlxColor.BLACK;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);
		}
		else 
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			add(dropText);

			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = 0xFF3F2021;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);
		}

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.SPACE && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}

		if (mainBox)
		{
			if (isntBf)
			{
				box.flipX = true;
			}
			else
			{
				box.flipX = false;
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'senpai':
			{
				makeInvisible();

				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
					isntBf = true;
				}
			}

			case 'bf-pixel':
			{
				makeInvisible();

				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
					isntBf = false;
				}
			}

			case 'bf':
			{
				makeInvisible();

				if (!portraitBf.visible)
				{
					portraitBf.visible = true;
					isntBf = true;
				}
			}

			case 'troll': 
			{
				makeInvisible();

				if (!portraitTroll.visible)
				{
					portraitTroll.visible = true;
					isntBf = true;

					FlxG.sound.playMusic(Paths.music('trolled'), 1);

					if (downBad)
					{
						killDaBox();
					}
				}
			}

			case 'gf': 
			{
				makeInvisible();

				if (!portraitGf.visible)
				{
					portraitGf.visible = true;
					isntBf = false;
				}
			}

			case 'ed': 
			{
				makeInvisible();

				if (!portraitEd.visible)
				{
					portraitEd.visible = true;
					isntBf = true;
				}
			}

			case 'gf-sad': 
			{
				makeInvisible();

				if (!portraitGfSad.visible)
				{
					portraitGfSad.visible = true;
					isntBf = false;
				}
			}

			case 'pico-surprised': 
			{
				makeInvisible();

				if (!portraitPicoS.visible)
				{
					portraitPicoS.visible = true;
					isntBf = false;
				}
			}

			case 'pico-sad': 
			{
				makeInvisible();

				if (!portraitPicoSad.visible)
				{
					portraitPicoSad.visible = true;
					isntBf = false;
				}
			}

			case 'pico-sad-angry': 
			{
				makeInvisible();

				if (!portraitPicoAngry.visible)
				{
					portraitPicoAngry.visible = true;
					isntBf = false;
				}
			}

			case 'pico': 
			{
				makeInvisible();

				if (!portraitPico.visible)
				{
					portraitPico.visible = true;
					isntBf = false;
				}
			}

			case 'vintendo':
			{
				makeInvisible();

				if (!vPortrait.visible)
				{
					vPortrait.visible = true;
					isntBf = true;
				}
			}

			case '' | 'troll-dark': 
			{
				makeInvisible();
			}

			case 'fade': 
			{
				killDaBox2();
			}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
	
	function makeInvisible()
	{
		portraitBf.visible = false;
		portraitLeft.visible = false;
		portraitRight.visible = false;
		portraitTroll.visible = false;
		portraitGf.visible = false;
		portraitEd.visible = false;
		portraitGfSad.visible = false;
		portraitPicoS.visible = false;
		portraitPicoSad.visible = false;
		portraitPicoAngry.visible = false;
		portraitPico.visible = false;
		vPortrait.visible = false;
		isntBf = false;
	}

	function killDaBox()
	{
		var daTimer:FlxTimer = new FlxTimer();
		daTimer.start(0.01, boxvisible, 100);
	}

	function killDaBox2()
	{
		var daTimer:FlxTimer = new FlxTimer();
		daTimer.start(1, boxvisible2, 10);
	}

	function boxvisible(tmr:FlxTimer)
	{
		bigBlackBox.alpha =- 0.01;
	}

	function boxvisible2(tmr:FlxTimer)
	{
		bigBlackBox.alpha =- 0.1;
	}
}
