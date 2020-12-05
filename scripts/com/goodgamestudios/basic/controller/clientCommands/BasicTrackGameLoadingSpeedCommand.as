package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.CachebreakerInfoObject;
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.tracking.PackageDownloadEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   
   public class BasicTrackGameLoadingSpeedCommand extends SimpleCommand
   {
       
      
      public function BasicTrackGameLoadingSpeedCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:CachebreakerInfoObject = null;
         var _loc3_:PackageDownloadEvent = null;
         if(param1 && param1 is CachebreakerInfoObject)
         {
            if(EnvGlobalsHandler.globals.isFirstVisitOfGGS && EnvGlobalsHandler.globals.isLocal == false)
            {
               _loc2_ = param1 as CachebreakerInfoObject;
               _loc3_ = TrackingCache.getInstance().getEvent(PackageDownloadEvent.EVENT_ID) as PackageDownloadEvent;
               _loc3_.gameId = EnvGlobalsHandler.globals.gameId;
               _loc3_.networkId = EnvGlobalsHandler.globals.networkId;
               _loc3_.accountID = EnvGlobalsHandler.globals.accountId;
               _loc3_.downloadDuration = _loc2_.loadingEndTime - _loc2_.loadingStartTime;
               _loc3_.downloadSize = _loc2_.fileSize;
               _loc3_.downloadURL = _loc2_.originURL;
               TrackingCache.getInstance().sendEvent(PackageDownloadEvent.EVENT_ID);
            }
         }
      }
   }
}
