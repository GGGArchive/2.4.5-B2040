package com.goodgamestudios.tracking.log
{
   import com.goodgamestudios.externalLogging.LoggingConstants;
   import com.goodgamestudios.externalLogging.genericLO.IOErrorLO;
   
   public final class TrackingIOErrorLO extends IOErrorLO
   {
       
      
      public function TrackingIOErrorLO(param1:String)
      {
         super(param1,LoggingConstants.TRACKING_IO_ERROR);
      }
   }
}
