package aRenberg.metadata
{
	public class Metadata implements IMetadata
	{
		public function Metadata(name:String, args:Object, parent:XML):void
		{
			_name = name;
			_args = args;
			_parent = parent;
		}
		
		private var _name:String;
		public function get name():String
		{ return _name; }
		
		private var _args:Object;
		public function get args():Object
		{ return _args; }
		
		private var _parent:XML;
		public function get parent():XML
		{ return _parent; }
		
		
		public function toString():String
		{
			//TODO
			return super.toString();
		}
		
	}
}