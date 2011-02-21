package aRenberg.metadata
{
	import aRenberg.metadata.Metadata;
	import aRenberg.metadata.handlers.genericMetadataHandler;
	import aRenberg.metadata.handlers.ignoreMetadataHandler;
	
	import flash.utils.describeType;
	
	public class MetadataParser
	{
		public function MetadataParser(strict:Boolean = false)
		{
			types = {};
			
			if (strict)
			{
				this.setDefaultHandler(ignoreMetadataHandler);
			}
			else
			{
				this.setDefaultHandler(genericMetadataHandler);
			}
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
			
			var metadataList:XMLList = MetadataUtils.getMetadatas(object);
			var data:Vector.<IMetadata> = new Vector.<IMetadata>();
			
			for each (var meta:XML in metadataList)
			{
				var name:String = MetadataUtils.getName(meta);
				var handler:Function = this.getHandler(name);
			
				var instance:IMetadata = handler.call(null, meta);
				if (instance) { data.push(instance); }
			}
			
			return data;
		}
		
		
	}
}