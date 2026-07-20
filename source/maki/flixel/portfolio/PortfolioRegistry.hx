package maki.flixel.portfolio;

import haxe.io.Path;
import lime.utils.Assets;
import sys.FileSystem;

class PortfolioRegistry
{
	public static var PORTFOLIOS(default, null):Array<String> = [];

	public static final PORTFOLIO_DIRECTORY = 'assets/portfolios';

	public static function reload()
	{
		PORTFOLIOS = [];

		for (folder in FileSystem.readDirectory(PORTFOLIO_DIRECTORY))
		{
			var metaPath = '$PORTFOLIO_DIRECTORY/$folder/portfolio.json';

			// trace(metaPath);
			if (FileSystem.exists(metaPath))
				PORTFOLIOS.push(folder);
		};

		trace('PORTFOLIOS: $PORTFOLIOS');
	}
}
