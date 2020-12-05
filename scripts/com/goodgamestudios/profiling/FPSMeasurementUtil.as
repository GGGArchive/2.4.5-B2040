package com.goodgamestudios.profiling
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   
   public class FPSMeasurementUtil extends EventDispatcher
   {
       
      
      private var _view:Sprite;
      
      private var _timer:uint;
      
      private var _ms_prev:uint;
      
      private var _fps:uint;
      
      private var _framesTotal:uint;
      
      private var _startTime:uint;
      
      public function FPSMeasurementUtil()
      {
         super();
      }
      
      public function startProfiling(param1:Sprite) : void
      {
         this._framesTotal = 0;
         this._startTime = getTimer();
         this._timer = getTimer();
         this._view = param1;
         this._view.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function stopProfiling() : void
      {
         this._view.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      public function get averageFPS() : uint
      {
         var _loc1_:uint = (getTimer() - this._startTime) * 0.001;
         return Math.round(this._framesTotal / _loc1_);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this._timer = getTimer();
         if(this._timer - 1000 > this._ms_prev)
         {
            this._ms_prev = this._timer;
            this._framesTotal = this._framesTotal + this._fps;
            this._fps = 0;
         }
         this._fps++;
      }
   }
}
