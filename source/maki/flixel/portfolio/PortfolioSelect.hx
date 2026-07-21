package maki.flixel.portfolio;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxSpriteContainer.FlxTypedSpriteContainer;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PortfolioSelect extends FlxState
{
	var selection:Int = 0;

	var portfolioIDs:Array<String> = [for (id => portfolioMetadata in PortfolioRegistry.PORTFOLIOS) id];
	var portfolioTexts:FlxTypedSpriteContainer<FlxText>;
	var portfolioTextPadding = 10;

	override function create()
	{
		super.create();

		portfolioTexts = new FlxTypedSpriteContainer<FlxText>();
		add(portfolioTexts);

		for (i => portfolioID in portfolioIDs)
		{
			var portfolioText = new FlxText(0, 0, 0, portfolioID, 16);
			portfolioText.ID = i;
			portfolioTexts.add(portfolioText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		for (portfolioText in portfolioTexts)
		{
			portfolioText.x = portfolioTextPadding;
			portfolioText.y = portfolioTextPadding + portfolioText.ID * (portfolioText.size * 2);

			portfolioText.color = (selection == portfolioText.ID) ? FlxColor.YELLOW : FlxColor.WHITE;
		}

		if (FlxG.keys.anyJustPressed([W, UP])) changeSelection(-1);
		if (FlxG.keys.anyJustPressed([S, DOWN])) changeSelection(1);

		if (FlxG.keys.anyJustPressed([ENTER])) loadPortfolio(portfolioIDs[selection]);
	}

	function changeSelection(amount:Int)
	{
		selection += amount;

		if (selection < 0) selection = portfolioTexts.length - 1;

		if (selection > portfolioTexts.length - 1) selection = 0;
	}

	function loadPortfolio(portfolio:String)
	{
		FlxG.switchState(() -> new PortfolioState(portfolio));
	}
}
