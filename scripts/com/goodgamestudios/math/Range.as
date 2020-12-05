package com.goodgamestudios.math
{
   public class Range
   {
       
      
      public function Range()
      {
         super();
         throw new Error("Range is a static class and cannot be instantiated.");
      }
      
      public static function isInRange(param1:Number, param2:Number, param3:Number, param4:Array = null) : Boolean
      {
         var _loc5_:* = null;
         if(!param4)
         {
            param4 = new Array();
         }
         if(param4.length > 0)
         {
            for(_loc5_ in param4)
            {
               if(param1 == param4[_loc5_])
               {
                  return false;
               }
            }
         }
         return param1 >= param2 && param1 <= param3;
      }
      
      public static function randRangeSet(param1:Number, param2:Number, param3:Number, param4:Boolean) : Array
      {
         var _loc6_:Array = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc5_:Array = new Array();
         if(param4 && param3 <= param2 - param1 + 1)
         {
            _loc6_ = new Array();
            _loc7_ = param1;
            while(_loc7_ <= param2)
            {
               _loc6_.push(_loc7_);
               _loc7_++;
            }
            _loc8_ = 1;
            while(_loc8_ <= param3)
            {
               _loc9_ = Math.floor(Math.random() * _loc6_.length);
               _loc5_.push(_loc6_[_loc9_]);
               _loc6_.splice(_loc9_,1);
               _loc8_++;
            }
         }
         else
         {
            _loc10_ = 1;
            while(_loc10_ <= param3)
            {
               _loc5_.push(randRangeInt(param1,param2));
               _loc10_++;
            }
         }
         return _loc5_;
      }
      
      public static function randRangeFloat(param1:Number, param2:Number) : Number
      {
         return Math.random() * (param2 - param1) + param1;
      }
      
      public static function randRangeInt(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (param2 - param1 + 1) + param1);
      }
      
      public static function resolve(param1:Number, param2:Number, param3:Number) : Number
      {
         return Math.max(Math.min(param1,param3),param2);
      }
      
      public static function center(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 > param2 && param1 > param3)
         {
            if(param2 > param3)
            {
               return param2;
            }
            return param3;
         }
         if(param2 > param1 && param2 > param3)
         {
            if(param1 > param3)
            {
               return param1;
            }
            return param3;
         }
         if(param1 > param2)
         {
            return param1;
         }
         return param2;
      }
   }
}
