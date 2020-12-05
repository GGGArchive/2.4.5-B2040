package com.goodgamestudios.mafia.view
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   public dynamic class BasicTicker extends MovieClip
   {
       
      
      public var speed:Number;
      
      private var tickerWidth:Number = 0;
      
      protected var tickerSingleTextWidth:Number;
      
      public function BasicTicker()
      {
         super();
      }
      
      public function startTicker(param1:String, param2:Number = 1.0) : void
      {
         this.speed = param2;
         if(!this.tickerWidth)
         {
            this.tickerWidth = this.width;
         }
         this.ticker.txt_ticker.text = "|";
         var _loc3_:Number = (this.ticker.txt_ticker as TextField).textWidth;
         this.ticker.txt_ticker.text = param1 + "|";
         this.tickerSingleTextWidth = (this.ticker.txt_ticker as TextField).textWidth - _loc3_;
         if(this.tickerSingleTextWidth == 0)
         {
            trace("ticker text is either empty or has no displayable characters!");
            return;
         }
         var _loc4_:uint = Math.ceil(this.tickerWidth / this.tickerSingleTextWidth) + 1;
         var _loc5_:String = "";
         var _loc6_:uint = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = _loc5_ + param1;
            _loc6_++;
         }
         this.ticker.txt_ticker.text = _loc5_;
         this.ticker.txt_ticker.width = this.tickerSingleTextWidth * _loc4_ + 4;
         this.ticker.cacheAsBitmap = true;
         this.clamp();
         addEventListener(Event.ENTER_FRAME,this.onTick);
      }
      
      public function stopTicker() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onTick);
      }
      
      private function onTick(param1:Event) : void
      {
         this.ticker.x = this.ticker.x - this.speed;
         this.clamp();
      }
      
      private function clamp() : void
      {
         while(this.ticker.x <= -this.tickerSingleTextWidth)
         {
            this.ticker.x = this.ticker.x + this.tickerSingleTextWidth;
         }
      }
   }
}
