package com.goodgamestudios.cookie
{
   import com.goodgamestudios.externalLogging.ExternalLog;
   import com.goodgamestudios.externalLogging.genericLO.CookieFlushErrorLO;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.NetStatusEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class CookieHelper
   {
       
      
      private var cookieSaverUrl:String = "http://cdn.goodgamestudios.com/CookieSaver.swf";
      
      private var oldCookieName:String = "";
      
      private var newCookieName:String = "";
      
      public function CookieHelper(param1:String, param2:String, param3:String)
      {
         super();
         this.cookieSaverUrl = param1;
         this.oldCookieName = param2;
         this.newCookieName = param3;
         this.checkNetworkCookie();
      }
      
      public static function isCookieEmpty(param1:SharedObject) : Boolean
      {
         var _loc2_:* = null;
         for(_loc2_ in param1.data)
         {
            return false;
         }
         return true;
      }
      
      public static function checkAndSaveStatus(param1:SharedObject) : void
      {
         param1.addEventListener(NetStatusEvent.NET_STATUS,handleStatusChange);
         param1.flush();
      }
      
      private static function handleStatusChange(param1:NetStatusEvent) : void
      {
         var _loc2_:SharedObject = param1.currentTarget as SharedObject;
         if(param1.info == "SharedObject.Flush.Failed")
         {
            ExternalLog.logger.log(new CookieFlushErrorLO(com.adobe.serialization.json.JSON.encode(_loc2_.data)),"CookieHelper");
         }
         else if(param1.info == "SharedObject.Flush.Success")
         {
            _loc2_.removeEventListener(NetStatusEvent.NET_STATUS,handleStatusChange);
         }
      }
      
      public function checkNetworkCookie() : void
      {
         var _loc2_:SharedObject = null;
         var _loc1_:SharedObject = SharedObject.getLocal(this.newCookieName,"/");
         if(isCookieEmpty(_loc1_))
         {
            _loc2_ = SharedObject.getLocal(this.oldCookieName,"/");
            if(isCookieEmpty(_loc2_))
            {
               this.loadCookieSaver(this.cookieSaverUrl);
            }
            else
            {
               this.copyCookie(_loc2_,this.newCookieName);
            }
         }
      }
      
      private function loadCookieSaver(param1:String) : void
      {
         var _loc2_:Loader = new Loader();
         var _loc3_:URLRequest = new URLRequest(param1);
         var _loc4_:LoaderContext = new LoaderContext();
         _loc4_.applicationDomain = ApplicationDomain.currentDomain;
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onErrorEvent);
         _loc2_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onErrorEvent);
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
         _loc2_.load(_loc3_);
      }
      
      private function onComplete(param1:Event) : void
      {
         var savedCookie:SharedObject = null;
         var event:Event = param1;
         event.target.removeEventListener(Event.COMPLETE,this.onComplete);
         event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onErrorEvent);
         event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onErrorEvent);
         try
         {
            savedCookie = ((event.target as LoaderInfo).content as Object).getSharedObject(this.oldCookieName);
            this.copyCookie(savedCookie,this.newCookieName);
            return;
         }
         catch(e:Error)
         {
            trace("Reading saved cookie failed: " + e.message);
            return;
         }
      }
      
      private function onErrorEvent(param1:Event) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onComplete);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onErrorEvent);
         param1.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onErrorEvent);
         throw new Error(param1.type);
      }
      
      private function copyCookie(param1:SharedObject, param2:String) : void
      {
         var _loc3_:SharedObject = null;
         var _loc4_:* = null;
         if(param1)
         {
            _loc3_ = SharedObject.getLocal(param2,"/");
            for(_loc4_ in param1.data)
            {
               _loc3_.data[_loc4_] = param1.data[_loc4_];
            }
            CookieHelper.checkAndSaveStatus(_loc3_);
         }
      }
   }
}
