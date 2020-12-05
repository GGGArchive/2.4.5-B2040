package com.goodgamestudios.net
{
   import com.goodgamestudios.tracking.ConnectionTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.XMLSocket;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class PolicyPingTest
   {
      
      private static const TIMEOUT_TIME:int = 20000;
       
      
      private var ip:String;
      
      private var port:uint;
      
      private var testSocket:XMLSocket;
      
      private var delay:uint;
      
      private var delayTimer:Timer;
      
      private var startTime:Number;
      
      private var endTime:Number;
      
      public function PolicyPingTest(param1:String, param2:uint, param3:uint)
      {
         super();
         this.ip = param1;
         this.port = param2;
         this.delay = param3;
         this.delayTimer = new Timer(param3,1);
         this.delayTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.startTest);
         this.delayTimer.start();
      }
      
      private function startTest(param1:TimerEvent) : void
      {
         var e:TimerEvent = param1;
         this.disposeDelayTimer();
         this.testSocket = new XMLSocket();
         this.testSocket.timeout = TIMEOUT_TIME;
         this.testSocket.addEventListener(Event.CONNECT,this.handleConnect);
         this.testSocket.addEventListener(DataEvent.DATA,this.handleData);
         this.testSocket.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.testSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
         try
         {
            this.testSocket.connect(this.ip,this.port);
            return;
         }
         catch(error:SecurityError)
         {
            trace("PolicyPingTest, startTest() -> SecurityError: " + error.message);
            return;
         }
      }
      
      private function disposeDelayTimer() : void
      {
         this.delayTimer.stop();
         this.delayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.startTest);
      }
      
      private function handleConnect(param1:Event) : void
      {
         this.startTime = getTimer();
         this.testSocket.send("<policy-file-request/>");
      }
      
      private function handleData(param1:DataEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.data.indexOf("policy") != -1)
         {
            this.endTime = getTimer();
            _loc2_ = this.endTime - this.startTime;
            this.sendResultToTracking(_loc2_);
            this.closeConnection();
            this.removeListeners();
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void
      {
      }
      
      private function closeConnection() : void
      {
         this.testSocket.close();
      }
      
      private function removeListeners() : void
      {
         this.testSocket.removeEventListener(Event.CONNECT,this.handleConnect);
         this.testSocket.removeEventListener(DataEvent.DATA,this.handleData);
         this.testSocket.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.testSocket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError);
      }
      
      private function sendResultToTracking(param1:int) : void
      {
         var _loc2_:ConnectionTrackingEvent = TrackingCache.getInstance().getEvent(ConnectionTrackingEvent.EVENT_ID) as ConnectionTrackingEvent;
         _loc2_.delay = this.delay;
         _loc2_.roundTrip = String(param1);
         TrackingCache.getInstance().sendEvent(ConnectionTrackingEvent.EVENT_ID);
      }
   }
}
