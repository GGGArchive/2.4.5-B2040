package com.goodgamestudios.basic.controller.clientCommands
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicLayoutManager;
   import com.goodgamestudios.commanding.SimpleCommand;
   import com.goodgamestudios.profiling.FPSMeasurementUtil;
   import com.goodgamestudios.tracking.ProfilingTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BasicProfilingTrackingCommand extends SimpleCommand
   {
       
      
      private const FPS_MEASURE_TIME_SECONDS:uint = 60;
      
      private var _fpsTimer:Timer;
      
      private var _fpsMeasureUtil:FPSMeasurementUtil;
      
      public function BasicProfilingTrackingCommand()
      {
         super();
      }
      
      override public function execute(param1:Object = null) : void
      {
         if(!TrackingCache.getInstance().isInitialized)
         {
            return;
         }
         if(this.env.isLocal)
         {
            return;
         }
         if(this.env.doUserTunnelTracking)
         {
            this.startFPSMeasurement();
         }
      }
      
      private function startFPSMeasurement() : void
      {
         this._fpsMeasureUtil = new FPSMeasurementUtil();
         this._fpsMeasureUtil.startProfiling(BasicLayoutManager.getInstance());
         this._fpsTimer = new Timer(this.FPS_MEASURE_TIME_SECONDS * 1000,1);
         this._fpsTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onFPSTimerComplete);
         this._fpsTimer.start();
      }
      
      private function onFPSTimerComplete(param1:TimerEvent) : void
      {
         this._fpsTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onFPSTimerComplete);
         this._fpsTimer = null;
         this._fpsMeasureUtil.stopProfiling();
         var _loc2_:ProfilingTrackingEvent = TrackingCache.getInstance().getEvent(ProfilingTrackingEvent.EVENT_ID) as ProfilingTrackingEvent;
         _loc2_.gameId = this.env.gameId;
         _loc2_.networkId = this.env.networkId;
         _loc2_.instanceID = BasicModel.instanceProxy.selectedInstanceVO.instanceId;
         _loc2_.playerID = BasicModel.userData.playerID;
         _loc2_.downloadSpeed = BasicModel.basicLoaderData.downloadRateFrameOne;
         _loc2_.fps = this._fpsMeasureUtil.averageFPS;
         TrackingCache.getInstance().sendEvent(ProfilingTrackingEvent.EVENT_ID);
      }
      
      private function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
