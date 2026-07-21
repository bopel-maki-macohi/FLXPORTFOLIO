package maki.flixel.portfolio.data;

typedef PortfolioMetaData =
{
	var author:String;

	var portfolio:PortfolioData;
}

typedef PortfolioData =
{
	var ?pronouns:Array<String>;

	var ?nationality:String;

	var ?languages:Array<String>;

	var ?socials:Array<String>;

	/**
	 * Mental "Disorders"
	 */
	var ?mental_specialties:Array<String>;
}
