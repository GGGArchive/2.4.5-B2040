package com.goodgamestudios.externalLogging.genericLO
{
   import com.goodgamestudios.externalLogging.LoggingConstants;
   
   public final class SecurityErrorLO extends AbstractLogObject
   {
       
      
      public function SecurityErrorLO(param1:String)
      {
         super(param1,LoggingConstants.GENERIC_SECURITY_ERROR,LoggingConstants.LOGGING_TYPE_ERROR);
      }
   }
}
