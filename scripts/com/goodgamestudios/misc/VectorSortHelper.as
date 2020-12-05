package com.goodgamestudios.misc
{
   public class VectorSortHelper
   {
       
      
      public function VectorSortHelper()
      {
         super();
      }
      
      public static function sort(param1:Object, param2:Function) : Object
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc3_:int = 1;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc5_ = _loc3_ - 1;
            while(_loc5_ >= 0 && param2(param1[_loc5_],_loc4_) == 1)
            {
               param1[_loc5_ + 1] = param1[_loc5_];
               _loc5_--;
            }
            param1[_loc5_ + 1] = _loc4_;
            _loc3_++;
         }
         return param1;
      }
   }
}
