package com.goodgamestudios.signal
{
   import flash.utils.getQualifiedClassName;
   import org.osflash.signals.Signal;
   
   public class GoodgameSignal extends Signal
   {
       
      
      public function GoodgameSignal(... rest)
      {
         super(rest);
      }
      
      public static function checkSignals(param1:*) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:GoodgameSignal = null;
      }
      
      public function hasListener(param1:Function) : Boolean
      {
         var _loc2_:Function = null;
         if(numListeners > 0)
         {
            for each(_loc2_ in listeners)
            {
               if(_loc2_ == param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get isDisposed() : Boolean
      {
         var _loc1_:* = numListeners == 0;
         return _loc1_;
      }
      
      public function toString() : String
      {
         return getQualifiedClassName(this).match("[^:]*$")[0];
      }
   }
}
