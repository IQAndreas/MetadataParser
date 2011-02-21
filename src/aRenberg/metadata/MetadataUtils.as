package aRenberg.metadata
{
	/**
	 * MetadataUtils
	 * 
	 * It's good keeping all these functions in one place in case the format
	 * returned by "describeType" changes!
	 * 
	 * I was going to go for "MetadataParserUtils", but it seemed too long.
	 * I even considered merging this class with the "MetadataParser" class.
	 */
	public class MetadataUtils
	{
		
		public static function getMetadatas(object:*):XMLList
		{
			import flash.utils.describeType;
			
			var description:XML = describeType(object);
			return description..metadata;
		}
		
		
		public static function parse(metadataXML:XML):Metadata
		{
			var name:String = MetadataUtils.getName(metadataXML);
			var args:Object = MetadataUtils.parseArgs(metadataXML);
			
			var targetName:String = MetadataUtils.getTargetName(metadataXML);
			var targetType:String = MetadataUtils.getTargetType(metadataXML);
			
			return new Metadata(name, args, targetName, targetType);
		}
		
		
		public static function getName(metadataXML:XML):String
		{
			return metadataXML.attribute('name');
		}
		
		public static function parseArgs(metadataXML:XML):Object
		{
			var argsXML:XMLList = metadataXML.arg;
			
			if (!argsXML) { return {}; }
			
			//I'm sorry this is so ugly...
			var args:Object = {};
			for each (var arg:XML in argsXML)
			{
				args[String(arg.attribute('key'))] = arg.attribute('value');
			}
			
			return args;
		}
		
		public static function getTargetName(metadataXML:XML):String
		{
			var parent:XML = metadataXML.parent() as XML;
			if (parent.name() == 'factory') 
				{ parent = parent.parent(); }
			
			return (parent ? parent.attribute('name') : "");
		}
		
		public static function getTargetType(metadataXML:XML):String
		{
			var parent:XML = metadataXML.parent() as XML;
			if (parent.name() == 'factory') 
				{ parent = parent.parent(); }
			
			return (parent ? MetadataType.getTypeByName(parent.name()) : "");
		}
		
		
		
		public function MetadataUtils()
		{
			//Static class. Do not instantiate
		}
	}
}