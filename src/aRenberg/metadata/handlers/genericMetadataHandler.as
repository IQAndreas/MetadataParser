package aRenberg.metadata.handlers
{	
	import aRenberg.metadata.IMetadata;
	import aRenberg.metadata.Metadata;

	import aRenberg.metadata.parseMetadataArgs;
	
	public function genericMetadataHandler(metadataXML:XML):IMetadata
	{
		var name:String = metadataXML.attribute('name');
		var args:Object = parseMetadataArgs(metadataXML.arg);
		
		return new Metadata(name, args, metadataXML.parent());
	}
}