package aRenberg.metadata
{
	public function parseMetadataArgs(argsXML:XMLList):Object
	{
		if (!argsXML) { return {}; }
		
		//I'm sorry this is so ugly...
		var args:Object = {};
		for each (var arg:XML in argsXML)
		{
			args[String(arg.attribute('key'))] = arg.attribute('value');
		}
		
		return args;
	}
}