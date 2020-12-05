package com.goodgamestudios.loading
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import org.osflash.signals.Signal;
   
   public final class GoodgameLoader
   {
       
      
      private var _loaderID:String;
      
      private var _isLoading:Boolean = false;
      
      private var _loadingError:Signal;
      
      private var _loadingQueueElementFinished:Signal;
      
      private var _loadingQueueElementStarted:Signal;
      
      private var _loaderMap:Dictionary;
      
      private var _queue:Vector.<ILoadingObject>;
      
      private var _finishedQueueEndElements:Array;
      
      private var _loadingStartTime:int;
      
      private var subloaderErrorLogging:Boolean = true;
      
      public function GoodgameLoader(param1:String, param2:Boolean = true)
      {
         this._loadingError = new Signal();
         this._loadingQueueElementFinished = new Signal();
         this._loadingQueueElementStarted = new Signal();
         this._loaderMap = new Dictionary();
         this._queue = new Vector.<ILoadingObject>();
         this._finishedQueueEndElements = new Array();
         super();
         this._loaderID = param1;
         this.subloaderErrorLogging = param2;
      }
      
      public function get loaderID() : String
      {
         return this._loaderID;
      }
      
      public function get isLoading() : Boolean
      {
         return this._isLoading;
      }
      
      public function get loadingError() : Signal
      {
         return this._loadingError;
      }
      
      public function get loadingQueueElementFinished() : Signal
      {
         return this._loadingQueueElementFinished;
      }
      
      public function get loadingQueueElementStarted() : Signal
      {
         return this._loadingQueueElementStarted;
      }
      
      public function addSWFLoader(param1:String, param2:String = "", param3:URLRequest = null, param4:LoaderContext = null, param5:Function = null, param6:Boolean = false) : LoaderObject
      {
         var _loc7_:Loader = null;
         var _loc8_:LoaderObject = null;
         var _loc9_:LoaderObject = null;
         var _loc10_:Loader = null;
         if(!this._loaderMap[param1] || param6 == true)
         {
            if(this._loaderMap[param1] && param6 == true)
            {
               _loc9_ = this._loaderMap[param1];
               _loc10_ = _loc9_.loaderInstance as Loader;
               _loc10_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,_loc9_.handleLoaderIOError);
               _loc10_.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc9_.handleLoaderSecurityError);
               _loc10_.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,_loc9_.onLoadProgress);
               _loc10_.contentLoaderInfo.removeEventListener(Event.COMPLETE,_loc9_.onComplete);
               _loc9_.dispose();
            }
            if(param2 == null || param2 == "")
            {
               if(param3 == null)
               {
                  return null;
               }
            }
            else
            {
               param3 = new URLRequest(param2);
            }
            if(!param4)
            {
               param4 = new LoaderContext();
               param4.applicationDomain = ApplicationDomain.currentDomain;
            }
            _loc7_ = new Loader();
            _loc8_ = new LoaderObject(_loc7_,param1,param3,param4,param5);
            _loc8_.loaderObjectFinished.add(this.queueElementHasFinished);
            _loc8_.loadingProgressStarted.add(this.queueElementNowLoading);
            _loc8_.loadingError.add(this.loadingError.dispatch);
            _loc7_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,_loc8_.handleLoaderIOError);
            _loc7_.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc8_.handleLoaderSecurityError);
            _loc7_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,_loc8_.onLoadProgress);
            _loc7_.contentLoaderInfo.addEventListener(Event.COMPLETE,_loc8_.onComplete);
            this._loaderMap[param1] = _loc8_;
            this._queue.push(_loc8_);
            this.startLoading();
            return _loc8_;
         }
         return this._loaderMap[param1];
      }
      
      public function addXMLLoader(param1:String, param2:String, param3:String, param4:Function = null, param5:Boolean = false) : void
      {
         var _loc6_:URLRequest = null;
         var _loc7_:URLLoader = null;
         var _loc8_:LoaderObject = null;
         var _loc9_:LoaderObject = null;
         var _loc10_:URLLoader = null;
         if(!this._loaderMap[param1] || param5 == true)
         {
            if(this._loaderMap[param1] && param5 == true)
            {
               _loc9_ = this._loaderMap[param1];
               _loc10_ = _loc9_.loaderInstance as URLLoader;
               _loc10_.removeEventListener(IOErrorEvent.IO_ERROR,_loc9_.handleLoaderIOError);
               _loc10_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc9_.handleLoaderSecurityError);
               _loc10_.removeEventListener(ProgressEvent.PROGRESS,_loc9_.onLoadProgress);
               _loc10_.removeEventListener(Event.COMPLETE,_loc9_.onComplete);
               _loc9_.dispose();
            }
            _loc6_ = new URLRequest(param2);
            _loc7_ = new URLLoader();
            _loc7_.dataFormat = param3;
            _loc8_ = new LoaderObject(_loc7_,param1,_loc6_,null,param4);
            _loc8_.loaderObjectFinished.add(this.queueElementHasFinished);
            _loc8_.loadingProgressStarted.add(this.queueElementNowLoading);
            _loc8_.loadingError.add(this.loadingError.dispatch);
            _loc7_.addEventListener(IOErrorEvent.IO_ERROR,_loc8_.handleLoaderIOError);
            _loc7_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc8_.handleLoaderSecurityError);
            _loc7_.addEventListener(ProgressEvent.PROGRESS,_loc8_.onLoadProgress);
            _loc7_.addEventListener(Event.COMPLETE,_loc8_.onComplete);
            this._loaderMap[param1] = _loc8_;
            this._queue.push(_loc8_);
            this.startLoading();
         }
      }
      
      public function addLoaderInfoObject(param1:String, param2:LoaderInfo, param3:Function = null) : void
      {
         var _loc4_:LoaderObject = null;
         if(!this._loaderMap[param1])
         {
            _loc4_ = new LoaderObject(param2,param1,null,null,param3);
            _loc4_.loaderObjectFinished.add(this.queueElementHasFinished);
            _loc4_.loadingProgressStarted.add(this.queueElementNowLoading);
            _loc4_.loadingError.add(this.loadingError.dispatch);
            param2.addEventListener(ProgressEvent.PROGRESS,_loc4_.onLoadProgress);
            param2.addEventListener(Event.COMPLETE,_loc4_.onComplete);
            this._loaderMap[param1] = _loc4_;
            this._queue.push(_loc4_);
            this.startLoading();
         }
      }
      
      public function addURLRequest(param1:String, param2:URLRequest, param3:Function = null) : void
      {
         var _loc4_:URLLoader = null;
         var _loc5_:LoaderObject = null;
         if(!this._loaderMap[param1])
         {
            _loc4_ = new URLLoader();
            _loc5_ = new LoaderObject(_loc4_,param1,param2,null,param3);
            _loc5_.loaderObjectFinished.add(this.queueElementHasFinished);
            _loc5_.loadingProgressStarted.add(this.queueElementNowLoading);
            _loc5_.loadingError.add(this.loadingError.dispatch);
            _loc4_.addEventListener(IOErrorEvent.IO_ERROR,_loc5_.handleLoaderIOError);
            _loc4_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc5_.handleLoaderSecurityError);
            _loc4_.addEventListener(ProgressEvent.PROGRESS,_loc5_.onLoadProgress);
            _loc4_.addEventListener(Event.COMPLETE,_loc5_.onComplete);
            this._loaderMap[param1] = _loc5_;
            this._queue.push(_loc5_);
            this.startLoading();
         }
      }
      
      public function addQueueEndElement(param1:String, param2:Function = null) : void
      {
         var _loc3_:LoadingQueueEndElement = new LoadingQueueEndElement(param1,param2);
         _loc3_.loaderObjectFinished.add(this.queueElementHasFinished);
         this._queue.push(_loc3_);
         this.startLoading();
      }
      
      public function hasQueEndElementFinished(param1:String) : Boolean
      {
         if(this._finishedQueueEndElements[param1] != null)
         {
            return true;
         }
         return false;
      }
      
      public function getLoaderData(param1:String) : Object
      {
         var _loc3_:URLLoader = null;
         var _loc4_:Loader = null;
         var _loc2_:LoaderObject = this._loaderMap[param1];
         if(_loc2_)
         {
            if(_loc2_.currentState == LoaderObject.STATE_LOADING_PROGRESS_FINISHED)
            {
               if(_loc2_.loaderInstance is URLLoader)
               {
                  _loc3_ = _loc2_.loaderInstance as URLLoader;
                  return _loc3_.data;
               }
               if(_loc2_.loaderInstance is Loader)
               {
                  _loc4_ = _loc2_.loaderInstance as Loader;
                  return _loc4_.contentLoaderInfo.content;
               }
               return null;
            }
            return null;
         }
         return null;
      }
      
      public function getLoaderObject(param1:String) : LoaderObject
      {
         var _loc2_:LoaderObject = this._loaderMap[param1];
         if(_loc2_)
         {
            return _loc2_;
         }
         return null;
      }
      
      public function hasSubloaderFinished(param1:String) : Boolean
      {
         var _loc2_:LoaderObject = this._loaderMap[param1];
         if(_loc2_)
         {
            if(_loc2_.currentState == LoaderObject.STATE_LOADING_PROGRESS_FINISHED)
            {
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function getCompleteProgress() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:ILoadingObject = null;
         for each(_loc3_ in this._loaderMap)
         {
            _loc1_ = _loc1_ + _loc3_.totalBytes;
            _loc2_ = _loc2_ + _loc3_.loadedBytes;
         }
         return _loc2_ / _loc1_;
      }
      
      public function getProgressOfSubloader(param1:String) : Number
      {
         var _loc2_:LoaderObject = this._loaderMap[param1];
         if(_loc2_)
         {
            return _loc2_.loadedBytes / _loc2_.totalBytes;
         }
         return -1;
      }
      
      public function getProgressOfActualSubloader() : Number
      {
         var _loc1_:ILoadingObject = null;
         if(this._queue.length > 0)
         {
            _loc1_ = this._queue[0];
            if(_loc1_)
            {
               if(_loc1_.loadedBytes != 0 || _loc1_.totalBytes != 0)
               {
                  return _loc1_.loadedBytes / _loc1_.totalBytes;
               }
               return 0;
            }
            return -1;
         }
         return 0;
      }
      
      public function calculateDataRate() : Number
      {
         var _loc3_:ILoadingObject = null;
         var _loc1_:Number = (getTimer() - this._loadingStartTime) / 1000;
         var _loc2_:Number = 0;
         for each(_loc3_ in this._loaderMap)
         {
            _loc2_ = _loc2_ + _loc3_.loadedBytes / 1024;
         }
         return Math.round(_loc2_ / _loc1_);
      }
      
      public function hasSubloader(param1:String) : Boolean
      {
         if(this._loaderMap[param1])
         {
            return true;
         }
         return false;
      }
      
      public function get elementsInQueue() : uint
      {
         return this._queue.length;
      }
      
      public function get elementsAlreadyLoaded() : uint
      {
         var _loc2_:ILoadingObject = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this._loaderMap)
         {
            _loc1_++;
         }
         return _loc1_ - this._queue.length;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         this._loadingQueueElementFinished.removeAll();
         this._loadingQueueElementStarted.removeAll();
         for(_loc1_ in this._loaderMap)
         {
            this._loaderMap[_loc1_].dispose();
            delete this._loaderMap[_loc1_];
         }
         this._loaderMap = null;
      }
      
      private function startLoading() : void
      {
         if(this._queue.length > 1)
         {
            this._isLoading = true;
         }
         else
         {
            this._isLoading = false;
         }
         if(!this._isLoading)
         {
            if(this._queue.length > 0)
            {
               if(this.elementsAlreadyLoaded == 0)
               {
                  this._loadingStartTime = getTimer();
               }
               this._queue[0].startLoadingObject(this.subloaderErrorLogging);
            }
         }
      }
      
      private function queueElementNowLoading(param1:String) : void
      {
         this._loadingQueueElementStarted.dispatch(this._loaderID,param1);
      }
      
      private function queueElementHasFinished(param1:String) : void
      {
         var _loc2_:ILoadingObject = this._queue.shift();
         if(_loc2_ is LoadingQueueEndElement)
         {
            _loc2_.onComplete(null);
            _loc2_.dispose();
            this._finishedQueueEndElements[_loc2_.loaderName] = _loc2_;
            this._isLoading = false;
         }
         var _loc3_:EventDispatcher = EventDispatcher(_loc2_.loaderInstance);
         if(_loc3_ != null)
         {
            _loc3_.removeEventListener(IOErrorEvent.IO_ERROR,_loc2_.handleLoaderIOError);
            _loc3_.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,_loc2_.handleLoaderSecurityError);
            _loc3_.removeEventListener(ProgressEvent.PROGRESS,_loc2_.onLoadProgress);
            _loc3_.removeEventListener(Event.COMPLETE,_loc2_.onComplete);
         }
         this._loadingQueueElementFinished.dispatch(this._loaderID,param1);
         if(this._queue.length > 0)
         {
            this._queue[0].startLoadingObject(this.subloaderErrorLogging);
         }
      }
   }
}
