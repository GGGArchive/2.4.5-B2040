package com.goodgamestudios.tracking
{
   import com.goodgamestudios.externalLogging.ExternalLog;
   import com.goodgamestudios.externalLogging.IExternalLogger;
   import com.goodgamestudios.externalLogging.genericLO.HTTPStatusErrorLO;
   import com.goodgamestudios.externalLogging.genericLO.SecurityErrorLO;
   import com.goodgamestudios.tracking.log.TrackingIOErrorLO;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public final class TrackingLoader
   {
       
      
      private var extLog:IExternalLogger;
      
      private var reqLoader:URLLoader;
      
      private var request:URLRequest;
      
      public function TrackingLoader(param1:URLRequest)
      {
         this.extLog = ExternalLog.logger;
         super();
         this.request = param1;
         this.reqLoader = new URLLoader();
         this.reqLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.reqLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onCountSecurityError);
         this.reqLoader.addEventListener(Event.COMPLETE,this.handleTrackingComplete);
         this.reqLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
         this.reqLoader.load(this.request);
      }
      
      private function onCountSecurityError(param1:SecurityErrorEvent) : void
      {
         this.extLog.log(new SecurityErrorLO(param1.text),"TrackingLoader");
         this.dispose();
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         this.extLog.log(new TrackingIOErrorLO(param1.text),"TrackingLoader");
         this.dispose();
      }
      
      private function onHTTPStatus(param1:HTTPStatusEvent) : void
      {
         var _loc2_:int = param1.status / 100;
         if(_loc2_ != 2 && _loc2_ != 3)
         {
            ExternalLog.logger.log(new HTTPStatusErrorLO(param1),"TrackingLoader.as");
            this.dispose();
         }
      }
      
      private function handleTrackingComplete(param1:Event) : void
      {
         this.dispose();
      }
      
      private function dispose() : void
      {
         this.reqLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.reqLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onCountSecurityError);
         this.reqLoader.removeEventListener(Event.COMPLETE,this.handleTrackingComplete);
         this.reqLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onHTTPStatus);
      }
   }
}
