package maki.flixel.portfolio;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
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

	var portfolioTextCamera:FlxCamera;
	var portfolioTextCameraFollow:FlxObject;

	var noPortfoliosText:FlxText;

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

		if (portfolioIDs.length > 0)
		{
			portfolioTextCamera = new FlxCamera(0, 0);
			portfolioTextCamera.bgColor = FlxColor.TRANSPARENT;
			FlxG.cameras.add(portfolioTextCamera, false);

			portfolioTexts.cameras = [portfolioTextCamera];

			portfolioTextCameraFollow = new FlxObject(0, 0);
			add(portfolioTextCameraFollow);

			portfolioTextCamera.follow(portfolioTextCameraFollow, LOCKON, 0.04);
			portfolioTextCamera.focusOn(portfolioTextCameraFollow.getPosition());

			return;
		}

		noPortfoliosText = new FlxText(0, 0, 0, 'No portfolios loaded.\nPress "R" to reload the portfolio entries', 32);
		noPortfoliosText.alignment = CENTER;
		noPortfoliosText.screenCenter();
		add(noPortfoliosText);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (portfolioTexts.length < 1)
		{
			if (FlxG.keys.anyJustPressed([R]))
			{
				PortfolioRegistry.reload();
				FlxG.switchState(() -> new PortfolioSelect());
			}
			return;
		}

		for (portfolioText in portfolioTexts)
		{
			portfolioText.x = portfolioTextPadding;
			portfolioText.y = portfolioTextPadding + portfolioText.ID * (portfolioText.size * 2);

			portfolioText.color = (selection == portfolioText.ID) ? FlxColor.YELLOW : FlxColor.WHITE;

			if (selection == portfolioText.ID) portfolioTextCameraFollow.y = portfolioText.y;
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
