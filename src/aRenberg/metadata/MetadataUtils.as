package aRenberg.metadata
{
	import flash.utils.describeType;
	
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
		
		public static function getStaticMetadatas(target:Class):XMLList
		{
			var description:XML = describeType(target);
			delete description.factory;
			return description..metadata;
		}
		
		public static function getInstanceMetadatas(target:*):XMLList
		{
			var description:XML = describeType(target);
			if (target is Class)
			{
				return description.factory..metadata;
			}
			else
			{
				return description..metadata;
			}
		}
		
		public static function getMetadatas(target:*):XMLList
		{
			var description:XML = describeType(target);
			return description..metadata;
		}
		
		
		public static function parse(metadataXML:XML):Metadata
		{
			var name:String = MetadataUtils.getMetadataName(metadataXML);
			var args:Object = MetadataUtils.parseArgs(metadataXML);
			
			var targetName:String = MetadataUtils.getTargetName(metadataXML);
			var targetType:String = MetadataUtils.getTargetType(metadataXML);
			
			var targetReadable:Boolean =  MetadataUtils.hasReadAccess(metadataXML);
			var targetWriteable:Boolean = MetadataUtils.hasWriteAccess(metadataXML);
			
			return new Metadata(name, args, targetName, targetType, targetReadable, targetWriteable);
		}
		
		
		public static function getMetadataName(metadataXML:XML):String
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
			var target:XML = getTarget(metadataXML);
			return getName(target);
		}
		
		public static function getTargetType(metadataXML:XML):String
		{
			var target:XML = getTarget(metadataXML);
			return getType(target);
		}
		
		
		
		private static function getTarget(metadataXML:XML):XML
		{
			var parent:XML = metadataXML.parent() as XML;
			if (parent.name() == 'factory') 
				{ parent = parent.parent(); }
			
			return parent;
		}
		
		private static function getName(target:XML):String
		{
			return (target ? target.attribute('name') : "");
		}
		
		private static function getType(target:XML):String
		{
			return (target ? MetadataType.getTypeByName(target.name()) : "");
		}

		
		
		// I sure hope this function will never return 'null' (for unknown) :(
		public static function hasReadAccess(metadataXML:XML):Boolean
		{
			var target:XML = getTarget(metadataXML);
			var type:String = getType(target);
			
			//Special case!
			if (type == MetadataType.ACCESSOR)
			{
				var access:String = target.attribute('access');
				return Boolean((access == 'readwrite') || (access == 'readonly'));
			}
			
			//else
			return MetadataType.hasReadAccess(type);
		}
		
		// I sure hope this function will never return 'null' (for unknown) :(
		public static function hasWriteAccess(metadataXML:XML):Boolean
		{
			var target:XML = getTarget(metadataXML);
			var type:String = getType(target);
			
			//Special case!
			if (type == MetadataType.ACCESSOR)
			{
				var access:String = target.attribute('access');
				return Boolean((access == 'readwrite') || (access == 'writeonly'));
			}
			
			//else
			return MetadataType.hasWriteAccess(type);
		}
		
		
		
		public function MetadataUtils()
		{
			//Static class. Do not instantiate
		}
	}
}