package aRenberg.metadata
{
	public interface IMetadata
	{
		function get targetName():String;
		function get targetType():String;
		
		function get name():String;
		function get args():Object;
		
		function getArg(propertyName:String, defaultValue:* = null):*;
		function getArgNumeric(propertyName:String, defaultValue:Number = NaN):Number;
		
	}
}