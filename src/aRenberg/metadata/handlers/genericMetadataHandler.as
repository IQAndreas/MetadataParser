package aRenberg.metadata.handlers
{	
	import aRenberg.metadata.IMetadata;
	import aRenberg.metadata.Metadata;
	import aRenberg.metadata.MetadataType;
	import aRenberg.metadata.parseMetadataArgs;
	
	public function genericMetadataHandler(metadataXML:XML):IMetadata
	{
		var name:String = metadataXML.attribute('name');
		var args:Object = parseMetadataArgs(metadataXML.arg);
		
		var parent:XML = metadataXML.parent() as XML;
		var targetName:String = parent ? parent.attribute('name') : "";
		var targetType:String = parent ? MetadataType.getTypeByName(parent.name()) : "";
		
		return new Metadata(name, args, targetName, targetType);
	}
	
}