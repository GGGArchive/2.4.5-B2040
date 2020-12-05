package com.goodgamestudios.basic.tracking
{
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.tracking.ConnectionTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ConnectionTrackingUtil
   {
      
      public static const SECOND_CONNECTION_EVENT_DELAY:Number = 60000;
      
      public static const THIRD_CONNECTION_EVENT_DELAY:Number = 120000;
      
      public static var trackCounter:int = 0;
      
      private static var _instance:ConnectionTrackingUtil;
       
      
      private var _executeConnectionTrackingTimer:Timer;
      
      private var _roundTripTime:Number = 0;
      
      private var _delayTime:Number = 0;
      
      private var _bluebox:int = 0;
      
      public function ConnectionTrackingUtil()
      {
         super();
      }
      
      public static function get instance() : ConnectionTrackingUtil
      {
         if(!_instance)
         {
            _instance = new ConnectionTrackingUtil();
         }
         return _instance;
      }
      
      public function doConnectionTracking(param1:Number, param2:int) : void
      {
         this._roundTripTime = param1;
         this._bluebox = param2;
         this.executeConnectionTrackingEvent();
      }
      
      private function executeConnectionTrackingEvent() : void
      {
         var _loc1_:ConnectionTrackingEvent = TrackingCache.getInstance().getEvent(ConnectionTrackingEvent.EVENT_ID) as ConnectionTrackingEvent;
         _loc1_.roundTrip = this._roundTripTime.toString();
         _loc1_.bluebox = this._bluebox;
         _loc1_.delay = this._delayTime;
         TrackingCache.getInstance().sendEvent(ConnectionTrackingEvent.EVENT_ID);
      }
      
      public function executeRoundTripDelayed(param1:Number) : void
      {
         this._delayTime = param1;
         this._executeConnectionTrackingTimer = new Timer(this._delayTime,1);
         this._executeConnectionTrackingTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompleteExecuteConnectionTrackingEventDelayed);
         this._executeConnectionTrackingTimer.start();
      }
      
      private function onTimerCompleteExecuteConnectionTrackingEventDelayed(param1:TimerEvent) : void
      {
         this.disposeTimer();
         BasicModel.smartfoxClient.executeRoundTrip();
      }
      
      private function disposeTimer() : void
      {
         if(this._executeConnectionTrackingTimer)
         {
            this._executeConnectionTrackingTimer.stop();
            this._executeConnectionTrackingTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompleteExecuteConnectionTrackingEventDelayed);
            this._executeConnectionTrackingTimer = null;
         }
      }
      
      public function dispose() : void
      {
         this.disposeTimer();
      }
   }
}
