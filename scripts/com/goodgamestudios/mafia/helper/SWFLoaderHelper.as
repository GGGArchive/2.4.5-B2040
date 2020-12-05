package com.goodgamestudios.mafia.helper
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class SWFLoaderHelper
   {
      
      private static var _instance:SWFLoaderHelper;
       
      
      private var loadingSWFs:Array;
      
      private var completedLoader:Array;
      
      public function SWFLoaderHelper()
      {
         super();
         this.loadingSWFs = [];
         this.completedLoader = [];
      }
      
      public static function get instance() : SWFLoaderHelper
      {
         if(SWFLoaderHelper._instance == null)
         {
            SWFLoaderHelper._instance = new SWFLoaderHelper();
         }
         return SWFLoaderHelper._instance;
      }
      
      public function loadSWF(param1:String, param2:Function = null, param3:Function = null) : Loader
      {
         var _loc4_:Loader = new Loader();
         this.setupLoader(_loc4_,param1,param2,param3);
         return _loc4_;
      }
      
      public function loadFamilyCrestPartSWF(param1:String, param2:Function = null, param3:Function = null) : Loader
      {
         var _loc4_:Loader = new FamilyCrestPartLoader();
         this.setupLoader(_loc4_,param1,param2,param3);
         return _loc4_;
      }
      
      private function setupLoader(param1:Loader, param2:String, param3:Function = null, param4:Function = null) : void
      {
         if(param4 == null)
         {
            param4 = this.onErrorEvent;
         }
         var _loc5_:URLRequest = new URLRequest(param2);
         var _loc6_:LoaderContext = new LoaderContext();
         _loc6_.applicationDomain = ApplicationDomain.currentDomain;
         param1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,param4);
         param1.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,param4);
         if(param3 != null)
         {
            param1.contentLoaderInfo.addEventListener(Event.COMPLETE,param3);
         }
         param1.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onComplete);
         param1.load(_loc5_,_loc6_);
         this.loadingSWFs[param2] = param1;
      }
      
      private function onErrorEvent(param1:IOErrorEvent) : void
      {
         trace(param1.text);
      }
      
      private function removeListener(param1:LoaderInfo) : void
      {
         param1.addEventListener(Event.COMPLETE,this.onComplete);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onErrorEvent);
         param1.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onErrorEvent);
      }
      
      private function onComplete(param1:Event) : void
      {
         this.removeListener(param1.target as LoaderInfo);
         var _loc2_:String = (param1.target as LoaderInfo).url;
         this.completedLoader[_loc2_] = (param1.target as LoaderInfo).loader;
         this.loadingSWFs[_loc2_] = null;
      }
      
      public function getCompletedLoader(param1:String) : Loader
      {
         if(this.completedLoader[param1])
         {
            return this.completedLoader[param1];
         }
         return null;
      }
      
      public function isSWFLoading(param1:String) : Boolean
      {
         if(this.loadingSWFs[param1])
         {
            return true;
         }
         return false;
      }
      
      public function isSWFLoaded(param1:String) : Boolean
      {
         if(this.completedLoader[param1])
         {
            return true;
         }
         return false;
      }
   }
}
