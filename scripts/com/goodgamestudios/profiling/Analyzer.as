package com.goodgamestudios.profiling
{
   import com.goodgamestudios.commanding.CommandController;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   final class Analyzer
   {
       
      
      private var cmdStack:Vector.<String>;
      
      private var watchTimer:Timer;
      
      private var currentfps:uint;
      
      private var isWatching:Boolean;
      
      private var fpsLimit:uint;
      
      private var _isShutDown:Boolean = false;
      
      function Analyzer(param1:uint)
      {
         super();
         this.watchTimer = new Timer(1000,param1);
         this.watchTimer.addEventListener(TimerEvent.TIMER,this.handleWatchTimerStep);
         this.watchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.handleWatchTimerComplete);
         this.cmdStack = new Vector.<String>();
      }
      
      public function get isShutDown() : Boolean
      {
         return this._isShutDown;
      }
      
      final function addCommand(param1:String) : void
      {
         this.cmdStack.push(param1);
      }
      
      final function lookAt(param1:uint, param2:uint) : void
      {
         if(this._isShutDown)
         {
            this.watchTimer.addEventListener(TimerEvent.TIMER,this.handleWatchTimerStep);
            this.watchTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.handleWatchTimerComplete);
         }
         this.currentfps = param1;
         this.fpsLimit = param2;
         if(this.currentfps < this.fpsLimit)
         {
            if(this.isWatching == false)
            {
               this.watch();
            }
         }
      }
      
      private function watch() : void
      {
         this.isWatching = true;
         this.watchTimer.start();
      }
      
      private function startCommandExecution() : void
      {
         var _loc1_:String = null;
         if(this.cmdStack.length >= 1)
         {
            _loc1_ = this.cmdStack.shift();
            CommandController.instance.executeCommand(_loc1_);
            this.watchTimer.start();
         }
         else
         {
            this.stopWatching();
            this.shutDown();
         }
      }
      
      protected function handleWatchTimerStep(param1:TimerEvent) : void
      {
         if(this.currentfps > this.fpsLimit || this.currentfps < 5)
         {
            this.stopWatching();
         }
      }
      
      protected function handleWatchTimerComplete(param1:TimerEvent) : void
      {
         this.watchTimer.reset();
         if(this.currentfps > this.fpsLimit || this.currentfps < 5)
         {
            this.stopWatching();
         }
         else
         {
            this.startCommandExecution();
         }
      }
      
      private function stopWatching() : void
      {
         this.isWatching = false;
         this.watchTimer.reset();
      }
      
      private function shutDown() : void
      {
         this.watchTimer.reset();
         this.watchTimer.removeEventListener(TimerEvent.TIMER,this.handleWatchTimerStep);
         this.watchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.handleWatchTimerComplete);
         this._isShutDown = true;
      }
   }
}
