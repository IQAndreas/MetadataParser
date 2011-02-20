package aRenberg.metadata.handlers
{	
	import aRenberg.metadata.IMetadata;
	import aRenberg.metadata.Metadata;

	public function genericMetadataHandler(name:String, args:Object, parent:XML):IMetadata
	{
		return new Metadata(name, args, parent);
	}
}