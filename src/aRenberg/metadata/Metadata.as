package aRenberg.metadata
{
	public class Metadata implements IMetadata
	{
		public function Metadata(name:String, args:Object, targetName:String, targetType:String):void
		{
			_targetName = targetName;
			_targetType = targetType;
			
			_name = name;
			_args = args;
		}
		
		private var _targetName:String;
		public function get targetName():String
		{ return _targetName; }
		
		private var _targetType:String;
		public function get targetType():String
		{ return _targetType; }
		
		
		private var _name:String;
		public function get name():String
		{ return _name; }
		
		private var _args:Object;
		public function get args():Object
		{ return _args; }
		
		
		//Sadly, it's untyped. Doesn't allow for any conversion at the moment.
		public function getArg(propertyName:String, defaultValue:* = null):*
		{
			return (args.hasOwnProperty(propertyName) ? args[propertyName] : defaultValue);
		}
		
		public function getArgNumeric(propertyName:String, defaultValue:Number = NaN):Number
		{
			if (args.hasOwnProperty(propertyName))
			{
				var value:Number = args[propertyName]; 
				if (isNaN(value))
				{
					return defaultValue;
				}
				else
				{
					return value;
				}
			}
			
			//else 
			return defaultValue; 
		}
		
		
		public function toString():String
		{
			//Is this really the best way to output the argument values?
			
			var values:Vector.<String> = new Vector.<String>();
			for (var key:String in args)
			{
				values.push(key + "=" + "\"" + args[key] + "\"");
			}
			
			var output:String = this.name;
			
			if (this.targetName)
				{ output += " (" + this.targetType + " " + this.targetName + ")"; }
			
			if (values.length)
				{ output += " - " + "{" + values.join(", ") + "}"; }
		
			return output;
		}
		
	}
}