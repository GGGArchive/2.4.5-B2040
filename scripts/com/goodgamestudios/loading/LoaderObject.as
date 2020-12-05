package com.goodgamestudios.loading
{
   import com.goodgamestudios.externalLogging.ExternalLog;
   import com.goodgamestudios.externalLogging.LoggingConstants;
   import com.goodgamestudios.externalLogging.genericLO.IOErrorLO;
   import com.goodgamestudios.externalLogging.genericLO.SecurityErrorLO;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.Timer;
   import org.osflash.signals.Signal;
   
   public final class LoaderObject implements ILoadingObject
   {
      
      public static const STATE_IDLE:int = 1;
      
      public static const STATE_LOADING_PROGRESS_INITIATED:int = 2;
      
      public static const STATE_LOADING_PROGRESS_STARTED:int = 3;
      
      public static const STATE_LOADING_PROGRESS_FINISHED:int = 4;
      
      public static const STATE_LOADING_ERROR:int = 5;
       
      
      private var _currentState:int;
      
      private var _loaderName:String;
      
      private var _loaderInstance:Object;
      
      private var _totalBytes:int;
      
      private var _loadedBytes:int;
      
      private var _loaderObjectFinished:Signal;
      
      var loadingProgressStarted:Signal;
      
      var loadingError:Signal;
      
      protected var _request:URLRequest;
      
      private var _onCompleteCallback:Function;
      
      private var _loaderContext:LoaderContext;
      
      private var tempLoadedBytes:Number;
      
      private var loadingProgressDelta:Number;
      
      private var loadingProgressDeltaTimer:Timer;
      
      private var loadingProgressDeltaNullTicks:int = 0;
      
      private var subloaderErrorLogging:Boolean = true;
      
      public function LoaderObject(param1:Object, param2:String, param3:URLRequest, param4:LoaderContext, param5:Function = null)
      {
         this._loaderObjectFinished = new Signal();
         this.loadingProgressStarted = new Signal();
         this.loadingError = new Signal();
         this.loadingProgressDeltaTimer = new Timer(1000);
         super();
         this._loaderInstance = param1;
         this._loaderName = param2;
         this._request = param3;
         this._loaderContext = param4;
         this._onCompleteCallback = param5;
         this._currentState = STATE_IDLE;
         this.loadingProgressDeltaTimer.addEventListener(TimerEvent.TIMER,this.handleLoadingProgressDeltaTimerTick);
      }
      
      public function get currentState() : int
      {
         return this._currentState;
      }
      
      public function get isLoadingFinished() : Boolean
      {
         return this._currentState == STATE_LOADING_PROGRESS_FINISHED;
      }
      
      public function get loaderName() : String
      {
         return this._loaderName;
      }
      
      public function get loaderInstance() : Object
      {
         return this._loaderInstance;
      }
      
      public function get totalBytes() : int
      {
         if(this._currentState == STATE_LOADING_PROGRESS_STARTED || this._currentState == STATE_LOADING_PROGRESS_FINISHED)
         {
            return this._totalBytes;
         }
         return 0;
      }
      
      public function get loadedBytes() : int
      {
         if(this._currentState == STATE_LOADING_PROGRESS_STARTED || this._currentState == STATE_LOADING_PROGRESS_FINISHED)
         {
            return this._loadedBytes;
         }
         return 0;
      }
      
      public function get loaderObjectFinished() : Signal
      {
         return this._loaderObjectFinished;
      }
      
      public function dispose() : void
      {
         this._loaderObjectFinished.removeAll();
         this.loadingProgressStarted.removeAll();
         this._onCompleteCallback = null;
         this._loaderContext = null;
         this._loaderInstance = null;
         this.removeTimer();
      }
      
      public function startLoadingObject(param1:Boolean) : void
      {
         this.subloaderErrorLogging = param1;
         this.loadingProgressDeltaTimer.start();
         if(this._loaderInstance is Loader)
         {
            Loader(this._loaderInstance).load(this._request,this._loaderContext);
         }
         else if(this._loaderInstance is URLLoader)
         {
            URLLoader(this._loaderInstance).load(this._request);
         }
         else if(this._loaderInstance is LoaderInfo)
         {
         }
      }
      
      public function onLoadProgress(param1:ProgressEvent) : void
      {
         this._totalBytes = param1.bytesTotal;
         this._loadedBytes = param1.bytesLoaded;
         this.loadingProgressDelta = param1.bytesLoaded - this.tempLoadedBytes;
         switch(this._currentState)
         {
            case STATE_IDLE:
               this._currentState = STATE_LOADING_PROGRESS_INITIATED;
               break;
            case STATE_LOADING_PROGRESS_INITIATED:
               this._currentState = STATE_LOADING_PROGRESS_STARTED;
               this.loadingProgressStarted.dispatch(this._loaderName);
         }
         this.tempLoadedBytes = param1.bytesLoaded;
      }
      
      private function handleLoadingProgressDeltaTimerTick(param1:TimerEvent) : void
      {
         if(this.loadingProgressDelta <= 0)
         {
            this.loadingProgressDeltaNullTicks++;
         }
         else
         {
            this.loadingProgressDeltaNullTicks = 0;
         }
         if(this.loadingProgressDeltaNullTicks >= 5)
         {
            if(!this.subloaderErrorLogging)
            {
            }
         }
      }
      
      public function handleLoaderSecurityError(param1:SecurityErrorEvent) : void
      {
         if(this.subloaderErrorLogging)
         {
            ExternalLog.logger.log(new SecurityErrorLO(param1.text),"LoaderObject.as");
         }
         this._currentState = STATE_LOADING_ERROR;
         this.loadingError.dispatch(this._loaderName,param1);
         this._loaderObjectFinished.dispatch(this._loaderName);
         this.removeTimer();
      }
      
      public function handleLoaderIOError(param1:IOErrorEvent) : void
      {
         if(this.subloaderErrorLogging)
         {
            ExternalLog.logger.log(new IOErrorLO(param1.text,LoggingConstants.GENERIC_IO_ERROR),"LoaderObject");
         }
         this._currentState = STATE_LOADING_ERROR;
         this.loadingError.dispatch(this._loaderName,param1);
         this._loaderObjectFinished.dispatch(this._loaderName);
         this.removeTimer();
      }
      
      public function onComplete(param1:Event) : void
      {
         var event:Event = param1;
         this._currentState = STATE_LOADING_PROGRESS_FINISHED;
         this._loaderObjectFinished.dispatch(this._loaderName);
         this.removeTimer();
         if(this._onCompleteCallback != null)
         {
            try
            {
               this._onCompleteCallback(this.loaderName);
               return;
            }
            catch(error:ArgumentError)
            {
               _onCompleteCallback();
               return;
            }
         }
      }
      
      private function removeTimer() : void
      {
         if(this.loadingProgressDeltaTimer)
         {
            this.loadingProgressDeltaTimer.stop();
            this.loadingProgressDeltaTimer.removeEventListener(TimerEvent.TIMER,this.handleLoadingProgressDeltaTimerTick);
         }
      }
   }
}
