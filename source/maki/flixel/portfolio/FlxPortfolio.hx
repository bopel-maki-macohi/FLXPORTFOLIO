package maki.flixel.portfolio;

import flixel.FlxGame;
import openfl.events.Event;

class FlxPortfolio extends FlxGame
{
	public function new()
	{
		super(1280, 720, PortfolioSelect, 60, 60, true, false);
	}

	override function create(_:Event)
	{
		PortfolioRegistry.reload();

		super.create(_);
	}
}
