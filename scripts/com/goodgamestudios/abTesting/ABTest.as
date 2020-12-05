package com.goodgamestudios.abTesting
{
   import com.adobe.serialization.json.JSONDecoder;
   import com.goodgamestudios.externalLogging.ExternalLog;
   import com.goodgamestudios.externalLogging.genericLO.HTTPStatusErrorLO;
   import com.goodgamestudios.tracking.ABTestTimeoutTrackingEvent;
   import com.goodgamestudios.tracking.TrackingCache;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import org.osflash.signals.Signal;
   
   public class ABTest
   {
       
      
      public var testIsInitalized:Signal;
      
      private var loader:URLLoader;
      
      private var request:URLRequest;
      
      private var variables:URLVariables;
      
      private var _testData:ABTestData;
      
      private var _isReady:Boolean = false;
      
      public function ABTest(param1:ABTestData)
      {
         this.testIsInitalized = new Signal();
         super();
         this._testData = param1;
         this.testIsInitalized.add(this.handleTestIsInitalized);
         this.requestDisplayEvent();
      }
      
      public function get testData() : ABTestData
      {
         return this._testData;
      }
      
      public function get isReady() : Boolean
      {
         return this._isReady;
      }
      
      private function requestDisplayEvent() : void
      {
         this.request = new URLRequest("http://splitrun.goodgamestudios.com/request/display");
         this.request.method = URLRequestMethod.POST;
         this.variables = new URLVariables();
         this.variables[ABTestData.TEST_ID] = this._testData._testID;
         this.variables[ABTestData.INSTANCE_ID] = this._testData.instanceID;
         this.variables[ABTestData.NETWORK_ID] = this._testData.networkID;
         this.variables[ABTestData.GAME_ID] = this._testData.gameID;
         this.variables[ABTestData.PLAYER_ID] = this._testData.playerID;
         this.variables[ABTestData.REFERRER] = this._testData.referrer;
         this.variables[ABTestData.ACCOUNT_ID] = this._testData.accountID;
         if(this._testData._caseID > 0 && this._testData._clientID != null && this._testData._clientID != "")
         {
            this.variables[ABTestData.CASE_ID] = this._testData._caseID;
            this.variables[ABTestData.CLIENT_ID] = this._testData._clientID;
         }
         this.request.data = this.variables;
         this.loader = new URLLoader();
         this.loader.addEventListener(Event.COMPLETE,this.onDisplayEventComplete);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.onDisplayRequestIOError);
         this.loader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onDisplayEventHTTPStatus);
         this.loader.load(this.request);
      }
      
      private function onDisplayEventComplete(param1:Event) : void
      {
         var _loc3_:JSONDecoder = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc2_:String = String(URLLoader(param1.target).data);
         if(_loc2_ && _loc2_ != "")
         {
            _loc4_ = _loc3_.getValue();
            if(_loc4_[ABTestData.TEST_ID])
            {
               this._testData._testID = uint(_loc4_[ABTestData.TEST_ID]);
            }
            if(_loc4_[ABTestData.CASE_ID])
            {
               this._testData._caseID = uint(_loc4_[ABTestData.CASE_ID]);
            }
            if(_loc4_[ABTestData.ERROR_MSG])
            {
               this._testData.errorMessage = String(_loc4_[ABTestData.ERROR_MSG]);
            }
            if(_loc4_[ABTestData.CLIENT_ID])
            {
               this._testData._clientID = String(_loc4_[ABTestData.CLIENT_ID]);
            }
            if(_loc4_[ABTestData.CONTENT])
            {
               this._testData.content = String(_loc4_[ABTestData.CONTENT]);
            }
            if(_loc4_[ABTestData.IS_VALID])
            {
               _loc5_ = String(_loc4_[ABTestData.IS_VALID]);
               if(_loc5_ == "true")
               {
                  this._testData.isValid = true;
               }
               else
               {
                  this._testData.isValid = false;
               }
            }
         }
         this.testIsInitalized.dispatch();
      }
      
      private function handleTestIsInitalized() : void
      {
         this._isReady = true;
      }
      
      private function onDisplayRequestIOError(param1:IOErrorEvent) : void
      {
         this.handleABTestError();
      }
      
      private function onDisplayEventHTTPStatus(param1:HTTPStatusEvent) : void
      {
         var _loc2_:int = param1.status / 100;
         if(_loc2_ != 2 && _loc2_ != 3)
         {
            ExternalLog.logger.log(new HTTPStatusErrorLO(param1),"ABTest.as");
            this.handleABTestError();
         }
      }
      
      private function handleABTestError() : void
      {
         this._testData.errorMessage = "timeout for display request";
         this._testData.errorCode = ABTestData.STATUS_TIMEOUT_ERROR;
         var _loc1_:ABTestTimeoutTrackingEvent = TrackingCache.getInstance().getEvent(ABTestTimeoutTrackingEvent.EVENT_ID) as ABTestTimeoutTrackingEvent;
         _loc1_.testID = this.testData._testID;
         _loc1_.playerId = this.testData.playerID;
         _loc1_.accountID = this.testData.accountID;
         TrackingCache.getInstance().sendEvent(ABTestTimeoutTrackingEvent.EVENT_ID);
      }
      
      public function sendConversion(param1:int, param2:int, param3:String) : void
      {
         if(this._isReady == false)
         {
            this._testData.errorCode = ABTestData.STATUS_NOT_READY_ERROR;
         }
         this._testData.playerID = param1;
         this._testData.instanceID = param2;
         this._testData.referrer = param3;
         this._testData.save();
         var _loc4_:URLRequest = new URLRequest("http://splitrun.goodgamestudios.com/request/track");
         _loc4_.method = URLRequestMethod.POST;
         var _loc5_:URLVariables = new URLVariables();
         _loc5_[ABTestData.TEST_ID] = this._testData._testID;
         _loc5_[ABTestData.CASE_ID] = this._testData._caseID;
         _loc5_[ABTestData.CLIENT_ID] = this._testData._clientID;
         _loc5_[ABTestData.NETWORK_ID] = this._testData.networkID;
         _loc5_[ABTestData.GAME_ID] = this._testData.gameID;
         _loc5_[ABTestData.INSTANCE_ID] = this._testData.instanceID;
         _loc5_[ABTestData.PLAYER_ID] = this._testData.playerID;
         _loc5_[ABTestData.REFERRER] = this._testData.referrer;
         _loc5_[ABTestData.ACCOUNT_ID] = this._testData.accountID;
         _loc5_[ABTestData.ERROR_CODE] = this._testData.errorCode;
         _loc4_.data = _loc5_;
         var _loc6_:URLLoader = new URLLoader();
         _loc6_.addEventListener(Event.COMPLETE,this.onConversionEventComplete);
         _loc6_.addEventListener(IOErrorEvent.IO_ERROR,this.onConversionIOError);
         _loc6_.load(_loc4_);
      }
      
      protected function onConversionIOError(param1:IOErrorEvent) : void
      {
      }
      
      private function onConversionEventComplete(param1:Event) : void
      {
         URLLoader(param1.target).removeEventListener(Event.COMPLETE,this.onConversionEventComplete);
      }
      
      public function dispose() : void
      {
         this.testIsInitalized.removeAll();
         this.disposeLoader();
         this._testData.save();
         this._testData = null;
      }
      
      private function disposeLoader() : void
      {
         if(this.loader)
         {
            this.loader.removeEventListener(Event.COMPLETE,this.onDisplayEventComplete);
            this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onDisplayRequestIOError);
            this.loader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onDisplayEventHTTPStatus);
            this.loader.removeEventListener(Event.COMPLETE,this.onConversionEventComplete);
            this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.onConversionIOError);
            this.loader.close();
            this.loader = null;
         }
      }
   }
}
