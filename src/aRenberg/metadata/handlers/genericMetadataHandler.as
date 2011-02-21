package aRenberg.metadata.handlers
{
	import aRenberg.metadata.IMetadata;
	import aRenberg.metadata.MetadataUtils;
	
	public function genericMetadataHandler(metadataXML:XML):IMetadata
	{
		return MetadataUtils.parse(metadataXML);
	}	
}