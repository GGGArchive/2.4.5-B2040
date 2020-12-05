package com.goodgamestudios.loading
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import org.osflash.signals.Signal;
   
   class LoadingQueueEndElement implements ILoadingObject
   {
       
      
      private var elementName:String;
      
      private var _loaderObjectFinished:Signal;
      
      private var finishCallback:Function;
      
      function LoadingQueueEndElement(param1:String, param2:Function)
      {
         this._loaderObjectFinished = new Signal();
         super();
         this.elementName = param1;
         this.finishCallback = param2;
      }
      
      public function get loaderObjectFinished() : Signal
      {
         return this._loaderObjectFinished;
      }
      
      public function get loaderName() : String
      {
         return this.elementName;
      }
      
      public function get totalBytes() : int
      {
         return 0;
      }
      
      public function get loadedBytes() : int
      {
         return 0;
      }
      
      public function startLoadingObject(param1:Boolean) : void
      {
         this._loaderObjectFinished.dispatch(this.elementName);
      }
      
      public function onLoadProgress(param1:ProgressEvent) : void
      {
      }
      
      public function handleLoaderSecurityError(param1:SecurityErrorEvent) : void
      {
      }
      
      public function handleLoaderIOError(param1:IOErrorEvent) : void
      {
      }
      
      public function onComplete(param1:Event) : void
      {
         if(this.finishCallback != null)
         {
            this.finishCallback();
         }
      }
      
      public function get loaderInstance() : Object
      {
         return null;
      }
      
      public function dispose() : void
      {
         this._loaderObjectFinished.removeAll();
      }
   }
}
