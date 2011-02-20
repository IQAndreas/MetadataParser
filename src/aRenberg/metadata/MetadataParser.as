package aRenberg.metadata
{
	import flash.utils.describeType;
	
	import aRenberg.metadata.Metadata; 
	
	import aRenberg.metadata.handlers.genericMetadataHandler;
	import aRenberg.metadata.handlers.ignoreMetadataHandler;
	
	public class MetadataParser
	{
		public function MetadataParser()
		{
			types = {};
			this.setDefaultHandler(null);
		}
		
		private var defaultHandler:Function;
		private var types:Object;
		public function registerHandler(name:String, handler:Function):void
		{
			if (handler != null)
			{
				types[name] = handler;
			}
			else
			{
				delete types[name];
			}
		}
		
		public function removeHandler(name:String):void
		{
			this.registerHandler(name, null);
		}
		
		public function ignoreType(name:String):void
		{
			this.registerHandler(name, ignoreMetadataHandler);
		}
		
		public function setDefaultHandler(handler:Function):void
		{
			if (handler != null)
			{
				defaultHandler = handler;
			}
			else
			{
				//Pass null to default to generic handler.
				defaultHandler = genericMetadataHandler;
			}
		}
		
		public function getHandler(name:String):Function
		{
			return (types[name] as Function) || defaultHandler;
		}
		
		public function parse(object:*):Vector.<IMetadata>
		{
			if (!object) { return null; }
			
			var description:XML = describeType(object);
			var metadataList:XMLList = description..metadata;
			
			var data:Vector.<IMetadata> = new Vector.<IMetadata>();
			
			for each (var meta:XML in metadataList)
			{
				var name:String = meta.attribute('name');
				var handler:Function = this.getHandler(name);
				
				//Parse args - I'm sorry this is so ugly...
				var argsXML:XMLList = meta.arg;
				var args:Object = {};
				for each (var arg:XML in argsXML)
				{
					args[String(arg.attribute('key'))] = arg.attribute('value');
				}
			
				var instance:IMetadata = handler.call(null, name, args, meta.parent());
				if (instance) { data.push(instance); }
			}
			
			return data;
		}
		
		
	}
}