package com.goodgamestudios.externalLogging.genericLO
{
   import com.goodgamestudios.externalLogging.LoggingConstants;
   
   public class IOErrorLO extends AbstractLogObject
   {
       
      
      public function IOErrorLO(param1:String, param2:int)
      {
         if(param2 <= 0)
         {
            param2 = LoggingConstants.GENERIC_IO_ERROR;
         }
         super(param1,param2,LoggingConstants.LOGGING_TYPE_ERROR);
      }
   }
}
