package com.goodgamestudios.externalLogging.genericLO
{
   import com.goodgamestudios.externalLogging.LoggingConstants;
   import flash.events.HTTPStatusEvent;
   
   public final class HTTPStatusErrorLO extends AbstractLogObject
   {
       
      
      public function HTTPStatusErrorLO(param1:HTTPStatusEvent)
      {
         super("",LoggingConstants.GENERIC_HTTP_ERROR,LoggingConstants.LOGGING_TYPE_ERROR);
      }
   }
}
