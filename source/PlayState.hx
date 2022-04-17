package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class PlayState extends FlxState
{
	// Spike Var
	var spkDwn:FlxSprite;
	var spkDwnF:FlxSprite; // F = Front
	var spkUp:FlxSprite;
	var spkUpF:FlxSprite; // F = Front

	// Menu Assets
	var menuItem:FlxTypedGroup<FlxSprite>;
	var menuArray:Array<String> = ["New Game", "Continue", "Options", "Exit"];
	var curSelected:Int;

	var bg:FlxSprite;

	override public function create()
	{
		// Adding the bg
		bg = new FlxSprite(-1793, 0).loadGraphic("assets/images/Complete padron 1st.png", false);
		bg.setGraphicSize(Std.int(bg.width * 6));
		bg.alpha = 0.7;
		bg.updateHitbox();
		add(bg);

		// Adding the options
		menuItem = new FlxTypedGroup<FlxSprite>();
		add(menuItem);

		for (i in 0...menuArray.length)
		{
			var menuBox:FlxSprite = new FlxSprite(0, FlxG.height);
			menuBox.frames = FlxAtlasFrames.fromSparrow("assets/images/MenuAssets.png", "assets/images/MenuAssets.xml");
			menuBox.animation.addByPrefix('selected', menuArray[i], 30, false);
			menuBox.animation.addByPrefix('idle', menuArray[i] + ' idle', 24, false);
			menuBox.ID = i;
			menuBox.setGraphicSize(Std.int(menuBox.width * 6));
			menuBox.updateHitbox();
			menuBox.screenCenter(X);
			menuItem.add(menuBox);

			// doing the tween
			new FlxTimer().start(2.2, function(tmr:FlxTimer)
			{
				FlxTween.tween(menuBox, {y: 130 + (110 * i)}, 2, {ease: FlxEase.expoOut});
			});
		}

		// Adding the spikes
		spkDwn = new FlxSprite(FlxG.width - 800, FlxG.height + 50).loadGraphic("assets/images/spikeBG.png", false);
		spkDwn.setGraphicSize(Std.int(spkDwn.width * 6));

		spkDwnF = new FlxSprite(FlxG.width - 800, FlxG.height + 50).loadGraphic("assets/images/spikeBG-front.png", false);
		spkDwnF.setGraphicSize(Std.int(spkDwnF.width * 6));

		spkUp = new FlxSprite(FlxG.width - 800, -50).loadGraphic("assets/images/spikeBG.png", false);
		spkUp.setGraphicSize(Std.int(spkUp.width * 6));
		spkUp.flipY = true;

		spkUpF = new FlxSprite(FlxG.width - 800, -50).loadGraphic("assets/images/spikeBG-front.png", false);
		spkUpF.setGraphicSize(Std.int(spkUpF.width * 6));
		spkUpF.flipY = true;

		add(spkDwn);
		add(spkDwnF);
		add(spkUp);
		add(spkUpF);

		// making it more "cute"?
		// doing some spike tweens
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			FlxTween.tween(spkDwn, {y: FlxG.height - 56}, 1);
			FlxTween.tween(spkDwnF, {y: FlxG.height - 56}, 1);
			FlxTween.tween(spkUp, {y: 39}, 1);
			FlxTween.tween(spkUpF, {y: 39}, 1);
		});

		changeOption();

		super.create();
	}

	var spkTwn:Bool = false;
	var bgTwn:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// doing the tweens :)
		if (!spkTwn)
		{
			// Back Sprites
			FlxTween.tween(spkUp, {x: spkUp.x - 72}, 1, {
				onComplete: function(twn:FlxTween)
				{
					// reset the tween
					// kinda ugly tbh
					spkTwn = false;
					spkUp.x = FlxG.width - 800;
					spkDwn.x = FlxG.width - 800;
					spkUpF.x = FlxG.width - 800;
					spkDwnF.x = FlxG.width - 800;
				}
			});
			FlxTween.tween(spkDwn, {x: spkDwn.x + 72}, 1);

			// Front sprites
			FlxTween.tween(spkDwnF, {x: spkDwnF.x - 72}, 1);
			FlxTween.tween(spkUpF, {x: spkUpF.x + 72}, 1);

			spkTwn = true;
		}

		// bg
		if (!bgTwn)
		{
			// i don't know why this solution work
			// big number = no tween / (big number/2) * 2 = tween
			FlxTween.tween(bg, {x: bg.x + (576 * 2), y: bg.y - (852 * 2)}, 10, {
				onComplete: function(twn:FlxTween)
				{
					bgTwn = false;
					bg.setPosition(-1793, 0);
				}
			});

			bgTwn = true;
		}

		// let's change da options now :)
		if (FlxG.keys.anyJustPressed([UP, W]))
		{
			changeOption(-1);
		}

		if (FlxG.keys.anyJustPressed([DOWN, S]))
		{
			changeOption(1);
		}

		// some program commands
		if (FlxG.keys.justPressed.ESCAPE)
		{
			System.exit(0);
		}

		if (FlxG.keys.justPressed.F)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
	}

	function changeOption(chng:Int = 0)
	{
		curSelected += chng;

		if (curSelected >= menuArray.length)
		{
			curSelected = 0;
		}

		if (curSelected < 0)
		{
			curSelected = menuArray.length - 1;
		}

		menuItem.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
			}

			spr.updateHitbox();
			spr.screenCenter(X);
		});
	}
}
