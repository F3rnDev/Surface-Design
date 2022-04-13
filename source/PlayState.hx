package;

import flash.system.System;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

using StringTools;

class PlayState extends FlxState
{
	//Spike Var
	var spkDwn:FlxSprite;
	var spkDwnF:FlxSprite; //F = Front
	var spkUp:FlxSprite;
	var spkUpF:FlxSprite; // F = Front

	var bg:FlxSprite;

	override public function create()
	{
		// adding the assets
		// obs: change bg to be the thingy (i don't know how to say "padronagens" in english :P)
		// obs2: PLACEHOLDER AAAAAAAAAAAA
		bg = new FlxSprite(-1793, 0).loadGraphic("assets/images/Complete padron 1st.png", false);
		bg.setGraphicSize(Std.int(bg.width * 6));
		bg.alpha = 0.7;
		bg.updateHitbox();
		add(bg);

		// SETTING THE SPIKES
		spkDwn = new FlxSprite(FlxG.width - 800, FlxG.height - 56).loadGraphic("assets/images/spikeBG.png", false);
		spkDwn.setGraphicSize(Std.int(spkDwn.width * 6));
		
		spkDwnF = new FlxSprite(FlxG.width - 800, FlxG.height - 56).loadGraphic("assets/images/spikeBG-front.png", false);
		spkDwnF.setGraphicSize(Std.int(spkDwnF.width * 6));
		
		spkUp = new FlxSprite(FlxG.width - 800, 39).loadGraphic("assets/images/spikeBG.png", false);
		spkUp.setGraphicSize(Std.int(spkUp.width * 6));
		spkUp.flipY = true;
		
		spkUpF = new FlxSprite(FlxG.width - 800, 39).loadGraphic("assets/images/spikeBG-front.png", false);
		spkUpF.setGraphicSize(Std.int(spkUpF.width * 6));
		spkUpF.flipY = true;
		
		add(spkDwn);
		add(spkDwnF);
		add(spkUp);
		add(spkUpF);
		// END

		// THIS IS A PLACEHOLDER
		var menuBox:FlxSprite = new FlxSprite(50, 150).makeGraphic(250, 400, FlxColor.WHITE);
		add(menuBox);

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
			//Back Sprites
			FlxTween.tween(spkUp, {x: spkUp.x - 72}, 1, {
				onComplete: function(twn:FlxTween)
				{
					//reset the tween
					//kinda ugly tbh
					spkTwn = false;
					spkUp.x = FlxG.width - 800;
					spkDwn.x = FlxG.width - 800;
					spkUpF.x = FlxG.width - 800;
					spkDwnF.x = FlxG.width - 800;

					
				}
			});
			FlxTween.tween(spkDwn, {x: spkDwn.x + 72}, 1);
			
			//Front sprites
			FlxTween.tween(spkDwnF, {x: spkDwnF.x - 72}, 1);
			FlxTween.tween(spkUpF, {x: spkUpF.x + 72}, 1);

			spkTwn = true;
		}

		// bg
		if (!bgTwn){	
			FlxTween.tween(bg, {x: bg.x + 576, y: bg.y - 426}, 5, {
			onComplete: function(twn:FlxTween)
			{
				bgTwn = false;
				bg.setPosition(-1793, 0);
			}});

			bgTwn = true;
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
}
