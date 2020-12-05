package com.goodgamestudios.loading
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import org.osflash.signals.Signal;
   
   public interface ILoadingObject
   {
       
      
      function get loaderName() : String;
      
      function get totalBytes() : int;
      
      function get loadedBytes() : int;
      
      function get loaderInstance() : Object;
      
      function startLoadingObject(param1:Boolean) : void;
      
      function onLoadProgress(param1:ProgressEvent) : void;
      
      function handleLoaderSecurityError(param1:SecurityErrorEvent) : void;
      
      function handleLoaderIOError(param1:IOErrorEvent) : void;
      
      function onComplete(param1:Event) : void;
      
      function get loaderObjectFinished() : Signal;
      
      function dispose() : void;
   }
}
