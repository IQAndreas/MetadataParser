package aRenberg.metadata
{
	public interface IMetadata
	{
		function get targetName():String;
		function get targetType():String;
		function get targetReadable():Boolean;
		function get targetWriteable():Boolean;
		
		function get name():String;
		function get args():Object;
		
		function getArg(propertyName:String, defaultValue:* = null):*;
		function getArgNumeric(propertyName:String, defaultValue:Number = NaN):Number;
		
		//This may be uneccessary to require, but I think it's a good idea anyway
		function toString():String;
	}
}