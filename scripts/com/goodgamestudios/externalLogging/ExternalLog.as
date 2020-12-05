package com.goodgamestudios.externalLogging
{
   import com.goodgamestudios.externalLogging.genericLO.AbstractLogObject;
   import com.goodgamestudios.loading.GoodgameLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getTimer;
   
   public final class ExternalLog implements IExternalLogger
   {
      
      private static var _logInstance:IExternalLogger;
      
      public static var referrer:String = "no referrer set";
      
      public static var gameId:int = -9999;
      
      public static var networkId:int = -9999;
      
      public static var instance:int = -9999;
      
      public static var playerId:int = -9999;
      
      public static var accountId:String = "-9999";
      
      public static var countryCode:String = "undefined";
      
      public static var selectedLanguage:String = "undefined";
      
      public static var isFirstVisitOfGGS:Boolean = false;
       
      
      private var requestLoader:GoodgameLoader;
      
      public function ExternalLog()
      {
         super();
      }
      
      public static function get logger() : IExternalLogger
      {
         if(!_logInstance)
         {
            _logInstance = new ExternalLog();
         }
         return _logInstance;
      }
      
      public function log(param1:AbstractLogObject, param2:String) : void
      {
         param1.logData["http_referer"] = referrer;
         param1.logData["gameId"] = gameId;
         param1.logData["networkId"] = networkId;
         param1.logData["instance"] = instance;
         param1.logData["countryCode"] = countryCode;
         param1.logData["accountId"] = accountId;
         param1.logData["playerId"] = playerId;
         param1.logData["logReferrer"] = param2;
         param1.logData["isFirstVisitOfGGS"] = isFirstVisitOfGGS;
         param1.logData["data"] = com.adobe.serialization.json.JSON.encode(param1.logOutput);
         if(this.requestLoader == null)
         {
            this.requestLoader = new GoodgameLoader("logLoader",false);
         }
         var _loc3_:URLRequest = new URLRequest("http://logging.goodgamestudios.com");
         _loc3_.method = URLRequestMethod.POST;
         _loc3_.data = param1.logData;
         this.requestLoader.addURLRequest(_loc3_.url + " " + getTimer(),_loc3_);
      }
   }
}
