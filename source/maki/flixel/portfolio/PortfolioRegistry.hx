package maki.flixel.portfolio;

import haxe.Json;
import haxe.io.Path;
import lime.utils.Assets;
import maki.flixel.portfolio.PortfolioData.PortfolioMetaData;
import sys.FileSystem;

class PortfolioRegistry
{
	public static var PORTFOLIOS(default, null):Map<String, PortfolioMetaData> = [];

	public static final PORTFOLIO_DIRECTORY = 'assets/portfolios';

	public static function reload()
	{
		PORTFOLIOS = [];

		for (folder in FileSystem.readDirectory(PORTFOLIO_DIRECTORY))
		{
			var metaPath = '$PORTFOLIO_DIRECTORY/$folder/portfolio.json';

			// trace(metaPath);
			if (FileSystem.exists(metaPath))
			{
				var metadata:PortfolioMetaData = null;

				try
				{
					metadata = Json.parse(Assets.getText(metaPath));
				}
				catch (e)
				{
					trace(e);
				}

				if (metadata != null && metadata?.author != null && metadata?.portfolio != null) PORTFOLIOS.set(folder, metadata);
			}
		};

		trace('PORTFOLIOS: ${[for (i => p in PORTFOLIOS) i]}');
	}
}
