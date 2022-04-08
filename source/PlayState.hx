package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flash.system.System;
import flixel.graphics.frames.FlxAtlasFrames;
import haxe.io.Path;
import flixel.tweens.FlxTween;

using StringTools;

class PlayState extends FlxState
{
	var spkDwn:FlxSprite;
	var spkUp:FlxSprite;

	override public function create()
	{
		//adding the assets
		//obs: change bg to be the thingy (i don't know how to say "padronagens" in english :P) 
		//obs2: PLACEHOLDER AAAAAAAAAAAA
		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.GREEN);
		add(bg);

		spkDwn = new FlxSprite(FlxG.width - 800, FlxG.height - 56).loadGraphic("assets/images/spikeBG.png", false);
		spkDwn.setGraphicSize(Std.int(spkDwn.width*6));
		add(spkDwn);

		spkUp = new FlxSprite(FlxG.width - 800, 39).loadGraphic("assets/images/spikeBG.png", false);
		spkUp.setGraphicSize(Std.int(spkUp.width * 6));
		spkUp.flipY = true;
		add(spkUp);

		//THIS IS A PLACEHOLDER
		var menuBox:FlxSprite = new FlxSprite(50, 150).makeGraphic(250, 400, FlxColor.WHITE);
		add(menuBox);
 
		super.create();
	}

	var spkTwn:Bool = false;

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		//doing the tweens :)
		if(!spkTwn){
			FlxTween.tween(spkUp, {x: spkUp.x - 72}, 1, {
				onComplete: function(twn:FlxTween)
				{
					spkTwn = false;
					spkUp.x = FlxG.width - 800;
					spkDwn.x = FlxG.width - 800; 
				}
			});

			FlxTween.tween(spkDwn, {x: spkDwn.x + 72}, 1);
			spkTwn = true;
		}

		//some program commands
		if (FlxG.keys.justPressed.ESCAPE){
			System.exit(0);
		}

		if (FlxG.keys.justPressed.F){
			FlxG.fullscreen = !FlxG.fullscreen;
		}
	}
}
