package aRenberg.metadataparser.handlers
{
	import aRenberg.description.metadata.IMetadata;
	import aRenberg.description.metadata.MetadataUtils;
	
	public function genericMetadataHandler(metadataXML:XML):IMetadata
	{
		return MetadataUtils.parse(metadataXML);
	}	
}