package maki.flixel.portfolio;

import flixel.FlxG;
import flixel.FlxState;

class PortfolioState extends FlxState
{
	override public function new(portfolioID:String)
	{
		super();
	}

	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(() -> new PortfolioSelect());

		super.update(elapsed);
	}
}
