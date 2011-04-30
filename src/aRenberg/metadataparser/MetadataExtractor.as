package aRenberg.metadataparser
{
	import flash.utils.describeType;
	import aRenberg.utils.getClass;
	
	/**
	 * Keeps the "describeType" function separated off in case it is
	 * replaced with a more efficient way in the future.
	 * 
	 * This may also be a good place to cache results to save time.
	 */
	internal class MetadataExtractor
	{
		
		public static function getMetadataList(target:*, instanceMembers:Boolean, staticMembers:Boolean):XMLList
		{
			if (instanceMembers && staticMembers)
			{
				return MetadataExtractor.getAllMetadatasList(getClass(target))
			}
			else if (instanceMembers)
			{
				return MetadataExtractor.getInstanceMetadatasList(target);
			}
			else if (staticMembers)
			{
				return MetadataExtractor.getStaticMetadatasList(getClass(target));
			}
			
			//else
			return new XMLList();
		}
		
		
		
		public static function getStaticMetadatasList(target:Class):XMLList
		{
			var description:XML = describeType(target);
			delete description.factory;
			return description..metadata;
		}
		
		public static function getInstanceMetadatasList(target:*):XMLList
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
		
		public static function getAllMetadatasList(target:*):XMLList
		{
			var description:XML = describeType(target);
			return description..metadata;
		}
		
		
		
		
		public function MetadataExtractor()
		{ /* Static class. Do not instantiate. */ }
		
	}
}