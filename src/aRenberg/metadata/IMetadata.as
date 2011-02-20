package aRenberg.metadata
{
	public interface IMetadata
	{
		function get targetName():String;
		function get targetType():String;
		
		function get name():String;
		function get args():Object;
	}
}