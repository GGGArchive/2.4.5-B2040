package com.goodgamestudios.externalLogging.genericLO
{
   import com.goodgamestudios.externalLogging.LoggingConstants;
   
   public class CookieFlushErrorLO extends AbstractLogObject
   {
       
      
      public function CookieFlushErrorLO(param1:String)
      {
         var _loc2_:String = "failed to flush cookie: " + param1;
         super(_loc2_,LoggingConstants.COOKIE_FLUSH_ERROR,LoggingConstants.LOGGING_TYPE_ERROR);
      }
   }
}
