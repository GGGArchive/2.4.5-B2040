package com.goodgamestudios.tracking
{
   import com.goodgamestudios.utils.DictionaryUtil;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class TrackingCache
   {
      
      public static const VERSION:String = "$Id: TrackingCache.as 2077 2012-11-06 16:23:48Z dirk.koehler $";
      
      private static var trackingCache:TrackingCache;
       
      
      public var currentCache:Dictionary;
      
      protected var gameId:int = 0;
      
      protected var referrer:String = "";
      
      protected var accountId:String = "";
      
      protected var networkId:int = 0;
      
      protected var distributorId:int = 0;
      
      protected var language:String = "";
      
      protected var _instanceId:int = 0;
      
      protected var _isInitialized:Boolean = false;
      
      private var trackedGameStates:Dictionary;
      
      public function TrackingCache()
      {
         super();
         this.currentCache = new Dictionary();
         this.trackedGameStates = new Dictionary();
      }
      
      public static function getInstance() : TrackingCache
      {
         if(!trackingCache)
         {
            trackingCache = new TrackingCache();
         }
         return trackingCache;
      }
      
      public function init(param1:int, param2:int, param3:String, param4:String, param5:String) : void
      {
         this.gameId = param1;
         this.networkId = param2;
         this.referrer = param3;
         this.language = param5;
         this.accountId = param4;
         this.currentCache[ImpressionTrackingEvent.EVENT_ID] = new ImpressionTrackingEvent(param3);
         this.currentCache[ConnectionTrackingEvent.EVENT_ID] = new ConnectionTrackingEvent(param3);
         this.currentCache[FirstInstanceTrackingEvent.EVENT_ID] = new FirstInstanceTrackingEvent(param3);
         this.currentCache[ClientLoadTrackingEvent.EVENT_ID] = new ClientLoadTrackingEvent(param3);
         this.currentCache[ClientLoginTrackingEvent.EVENT_ID] = new ClientLoginTrackingEvent(param3);
         this.currentCache[ABTestTimeoutTrackingEvent.EVENT_ID] = new ABTestTimeoutTrackingEvent(param3);
         this.currentCache[WorldAssignmentTrackingEvent.EVENT_ID] = new WorldAssignmentTrackingEvent(param3);
         this.currentCache[PackageDownloadEvent.EVENT_ID] = new PackageDownloadEvent(param3);
         this.currentCache[ProfilingTrackingEvent.EVENT_ID] = new ProfilingTrackingEvent(param3);
         this._isInitialized = true;
      }
      
      public function registerEvent(param1:int, param2:Class) : BasicTrackingEvent
      {
         this.currentCache[param1] = new param2(this.referrer);
         return this.currentCache[param1] as BasicTrackingEvent;
      }
      
      public function getEvent(param1:int) : BasicTrackingEvent
      {
         return this.currentCache[param1];
      }
      
      public function sendEvent(param1:int) : Boolean
      {
         if(!this.isInitialized)
         {
            return false;
         }
         if(!this.isRequestAllowed(param1))
         {
            return false;
         }
         this.executeDefaultTrackingRequest(param1);
         return true;
      }
      
      private function isRequestAllowed(param1:int) : Boolean
      {
         var _loc2_:String = null;
         if(param1 == FirstInstanceTrackingEvent.EVENT_ID)
         {
            _loc2_ = FirstInstanceTrackingEvent(this.currentCache[param1]).gameState;
            if(!DictionaryUtil.containsKey(this.trackedGameStates,_loc2_))
            {
               this.trackedGameStates[_loc2_] = _loc2_;
               return true;
            }
            return false;
         }
         return true;
      }
      
      private function executeDefaultTrackingRequest(param1:int) : void
      {
         var _loc2_:URLRequest = this.composeTrackingURLRequest(param1,TrackingConstants.DEFAULT_TRACKING_URL);
         this.executeTrackingRequest(_loc2_);
      }
      
      private function composeTrackingURLRequest(param1:int, param2:String) : URLRequest
      {
         var _loc3_:URLRequest = new URLRequest(param2);
         var _loc4_:BasicTrackingEvent = this.currentCache[param1] as BasicTrackingEvent;
         var _loc5_:URLVariables = _loc4_.getVars();
         _loc5_.eventId = param1;
         _loc5_.gameId = this.gameId;
         _loc5_.networkId = this.networkId;
         _loc5_.accountId = this.accountId;
         _loc5_.instanceId = this._instanceId;
         _loc5_.lang = this.language;
         _loc3_.data = _loc5_;
         _loc3_.method = URLRequestMethod.POST;
         return _loc3_;
      }
      
      private function executeTrackingRequest(param1:URLRequest) : void
      {
         var trackingLoader:TrackingLoader = null;
         var trackingRequest:URLRequest = param1;
         if(!trackingRequest)
         {
            return;
         }
         try
         {
            trackingLoader = new TrackingLoader(trackingRequest);
            return;
         }
         catch(e:Error)
         {
            trace("Fehler beim Erstellen des TrackingLoaders");
            return;
         }
      }
      
      public function get instanceId() : int
      {
         return this._instanceId;
      }
      
      public function set instanceId(param1:int) : void
      {
         this._instanceId = param1;
      }
      
      public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
   }
}
