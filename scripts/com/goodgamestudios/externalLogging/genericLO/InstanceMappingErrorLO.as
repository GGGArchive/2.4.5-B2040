package com.goodgamestudios.externalLogging.genericLO
{
   import com.goodgamestudios.externalLogging.LoggingConstants;
   
   public class InstanceMappingErrorLO extends AbstractLogObject
   {
      
      public static const NO_INSTANCES_FOR_CURRENT_COUNTRY_FOUND:int = 100;
      
      public static const CONNECT_TO_INSTANCE_NULL:int = 200;
       
      
      public function InstanceMappingErrorLO(param1:String, param2:int)
      {
         param1 = "SubErrorCode:" + param2 + ". " + param1;
         super(param1,LoggingConstants.INSTANCE_MAPPING_ERROR,LoggingConstants.LOGGING_TYPE_ERROR);
      }
   }
}
