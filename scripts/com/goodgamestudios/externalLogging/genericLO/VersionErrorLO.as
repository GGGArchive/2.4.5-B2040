package com.goodgamestudios.externalLogging.genericLO
{
   import com.goodgamestudios.externalLogging.LoggingConstants;
   
   public final class VersionErrorLO extends AbstractLogObject
   {
       
      
      public function VersionErrorLO(param1:int, param2:String)
      {
         super("client version is not up to date! version: " + param2 + ". Errorcode from server: " + param1,LoggingConstants.OLD_CLIENT_VERSION_ERROR,LoggingConstants.LOGGING_TYPE_ERROR);
      }
   }
}
