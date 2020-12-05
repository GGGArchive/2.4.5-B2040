package com.goodgamestudios.signal
{
   public class BooleanSignal extends GoodgameSignal
   {
       
      
      public function BooleanSignal()
      {
         super();
      }
      
      public function signal(param1:Boolean) : void
      {
         super.dispatch(param1);
      }
   }
}
