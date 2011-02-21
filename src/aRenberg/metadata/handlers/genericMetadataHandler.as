package aRenberg.metadata.handlers
{	
	import aRenberg.metadata.IMetadata;
	import aRenberg.metadata.Metadata;
	import aRenberg.metadata.MetadataType;
	import aRenberg.metadata.MetadataUtils;
	
	public function genericMetadataHandler(metadataXML:XML):IMetadata
	{
		var name:String = MetadataUtils.getName(metadataXML);
		var args:Object = MetadataUtils.parseArgs(metadataXML);
		
		var targetName:String = MetadataUtils.getTargetName(metadataXML);
		var targetType:String = MetadataUtils.getTargetType(metadataXML);
		
		return new Metadata(name, args, targetName, targetType);
	}
	
}