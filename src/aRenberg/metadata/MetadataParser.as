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
		
		public function parse(object:*, instanceMembers:Boolean = true, staticMembers:Boolean = false):Vector.<IMetadata>
		{
			if (!object) { return null; }
			
			var metadataList:XMLList = getMetadataList(object, instanceMembers, staticMembers);
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
		
		private function getMetadataList(object:*, instanceMembers:Boolean, staticMembers:Boolean):XMLList
		{
			var target:* = object;
			
			if (staticMembers && !(object is Class))
			{
				//I sure hope they haven't overriden the 'constructor' property with something else. :(
				target = object.constructor;
			}
			
			if (instanceMembers && staticMembers)
			{
				return MetadataUtils.getMetadatas(getClass(target))
			}
			else if (instanceMembers)
			{
				return MetadataUtils.getInstanceMetadatas(target);
			}
			else if (staticMembers)
			{
				return MetadataUtils.getStaticMetadatas(getClass(target));
			}
			
			//else
			return new XMLList();
		}
		
		
		//Helper function. Can be moved to a separate place.
		private function getClass(target:*):Class
		{
			if (target is Class) { return target; }
			
			if (target.constructor is Class) { return target.constructor; }
			
			//Otherwise, put on the hard gloves! Ugh!
			import flash.utils.getQualifiedClassName;
			import flash.utils.getDefinitionByName;
			return getDefinitionByName(getQualifiedClassName(target)) as Class;
		}
		
		
	}
}