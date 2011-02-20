package aRenberg.metadata
{
	public interface IMetadata
	{
		//function populate(name:String, args:Object, parent:XML):void;
		
		function get name():String;
		function get args():Object;
	}
}