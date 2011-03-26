package aRenberg.metadata
{
	//I hate these classes that only serve to hold constants!
	//It's best to keep the list of all types here in case any are added or removed in future FP versions.
	public class MetadataType
	{
		
		public static const ACCESSOR:String = 	"accessor";
		public static const METHOD:String = 	"method";
		public static const VARIABLE:String = 	"variable";
		public static const CONSTANT:String = 	"constant";
		public static const CLASS:String = 		"class";
		
		public static const UNKNOWN:String = 	"unknown";
		
		
		public static function getTypeByName(name:String):String
		{
			switch(name)
			{
				case 'accessor': 	return MetadataType.ACCESSOR;
				case 'method' : 	return MetadataType.METHOD;
				case 'variable' : 	return MetadataType.VARIABLE;
				case 'constant' :	return MetadataType.CONSTANT;
					
				case 'factory' : // Class passed in
				case 'type' : // instance passed in
					return MetadataType.CLASS;
					
				default: 
					return MetadataType.UNKNOWN;
			}
		}
		
		
		// This seemed like the best place to keep the function,
		// though it really could use a better home!
		// Will return 'null' (instead of false) if it's a special case! :(
		public static function hasReadAccess(type:String):Object
		{
			switch (type)
			{
				case MetadataType.METHOD : 
				case MetadataType.VARIABLE : 
				case MetadataType.CONSTANT : 
				case MetadataType.CLASS : 
					return true;
					
				case MetadataType.ACCESSOR : 
				case MetadataType.UNKNOWN : 
					//return maybe!
					return null;
			}
			
			return null;
		}
		
		public static function hasWriteAccess(type:String):Object
		{
			switch (type)
			{
				case MetadataType.VARIABLE : 
					return true;
				
				case MetadataType.METHOD : //Calling a method with an argument is NOT the same as writing to it!
				case MetadataType.CONSTANT : 
				case MetadataType.CLASS : 
					return false;
					
				case MetadataType.ACCESSOR : 
				case MetadataType.UNKNOWN : 
					//return maybe!
					return null;
			}
			
			return null;
		}
		
		
		public function MetadataType()
		{
			//Static class. Do not instantiate.
		}
	}
}