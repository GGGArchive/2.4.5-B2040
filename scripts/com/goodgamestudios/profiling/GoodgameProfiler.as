package com.goodgamestudios.profiling
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public final class GoodgameProfiler
   {
       
      
      private var _isRunning:Boolean = false;
      
      private var _currentFPS:uint;
      
      private var fpsLimit:uint;
      
      private var gameStage:Stage;
      
      private var countedFrames:uint = 0;
      
      private var fpsTimer:Timer;
      
      private var analyzer:Analyzer;
      
      public function GoodgameProfiler(param1:Stage, param2:uint, param3:uint)
      {
         this.fpsTimer = new Timer(1000);
         super();
         this.fpsLimit = param2;
         this.gameStage = param1;
         this.analyzer = new Analyzer(param3);
      }
      
      public function get isRunning() : Boolean
      {
         return this._isRunning;
      }
      
      public function get currentFPS() : uint
      {
         return this._currentFPS;
      }
      
      public final function addCommandToStack(param1:String) : void
      {
         this.analyzer.addCommand(param1);
      }
      
      public final function startProfiling() : void
      {
         this.fpsTimer.addEventListener(TimerEvent.TIMER,this.handleTimerTick);
         this.fpsTimer.start();
         this.gameStage.addEventListener(Event.ENTER_FRAME,this.handleEnterFrame);
         this.gameStage.addEventListener(Event.DEACTIVATE,this.handleDeactivate);
         this._isRunning = true;
      }
      
      public final function stopProfiling() : void
      {
         this.fpsTimer.removeEventListener(TimerEvent.TIMER,this.handleTimerTick);
         this.fpsTimer.reset();
         this.gameStage.removeEventListener(Event.ENTER_FRAME,this.handleEnterFrame);
         this.countedFrames = 0;
         this._currentFPS = 0;
         this._isRunning = false;
      }
      
      private function handleTimerTick(param1:TimerEvent) : void
      {
         if(!this.analyzer.isShutDown)
         {
            this._currentFPS = this.countedFrames;
            this.countedFrames = 0;
            this.analyzer.lookAt(this._currentFPS,this.fpsLimit);
         }
         else
         {
            this.stopProfiling();
         }
      }
      
      private function handleEnterFrame(param1:Event) : void
      {
         this.countedFrames++;
      }
      
      private function handleActivate(param1:Event) : void
      {
         this.gameStage.removeEventListener(Event.ACTIVATE,this.handleActivate);
         this.gameStage.addEventListener(Event.DEACTIVATE,this.handleDeactivate);
         this.startProfiling();
      }
      
      private function handleDeactivate(param1:Event) : void
      {
         this.gameStage.removeEventListener(Event.DEACTIVATE,this.handleDeactivate);
         this.gameStage.addEventListener(Event.ACTIVATE,this.handleActivate);
         this.stopProfiling();
      }
   }
}
