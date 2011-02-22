package aRenberg.metadata
{
	//I hate these classes that only serve to hold constants!
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
		
		
		public function MetadataType()
		{
			//Static class. Do not instantiate.
		}
	}
}