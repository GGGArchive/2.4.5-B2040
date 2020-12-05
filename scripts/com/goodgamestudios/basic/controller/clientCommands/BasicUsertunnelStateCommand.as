package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.tracking.FirstInstanceTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import flash.utils.getTimer;
   
   public final class BasicUsertunnelStateCommand extends SimpleCommand
   {
      
      public static const INVALID_TRACKING:String = "INVALID_TRACKING";
       
      
      private var gameState:String;
      
      public function BasicUsertunnelStateCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         var _loc2_:FirstInstanceTrackingEvent = null;
         this.gameState = param1 as String;
         if(!TrackingCache.getInstance().isInitialized)
         {
            return;
         }
         if(this.env.isLocal)
         {
            trace("Local BasicUsertunnelStateCommand, TRACK: " + this.gameState);
            return;
         }
         if(this.env.doUserTunnelTracking)
         {
            if(this.gameState == INVALID_TRACKING)
            {
               this.env.isFirstVisitOfGGS = false;
            }
            _loc2_ = TrackingCache.getInstance().getEvent(FirstInstanceTrackingEvent.EVENT_ID) as FirstInstanceTrackingEvent;
            _loc2_.gameState = this.gameState;
            _loc2_.registered = int(this.env.isRegistered);
            if(this.gameState == INVALID_TRACKING)
            {
               _loc2_.isFirstInstanceUser = false;
            }
            else
            {
               _loc2_.isFirstInstanceUser = true;
            }
            _loc2_.sessionLength = ((getTimer() - this.env.sessionStartTime) / 1000).toFixed();
            _loc2_.tutorialLength = "0";
            _loc2_.accountID = this.env.accountId;
            _loc2_.sessionId = this.env.sessionId;
            _loc2_.version = parseInt(this.env.buildNumberGame);
            _loc2_.clp = int(this.env.isLandingpageClient);
            _loc2_.cv = this.env.campainVars;
            TrackingCache.getInstance().sendEvent(FirstInstanceTrackingEvent.EVENT_ID);
         }
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
