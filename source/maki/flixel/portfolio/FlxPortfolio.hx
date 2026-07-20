package maki.flixel.portfolio;

import flixel.FlxGame;

class FlxPortfolio extends FlxGame
{
	public function new()
	{
		super(1280, 720, PortfolioSelect, 60, 60, true, false);
	}
}
