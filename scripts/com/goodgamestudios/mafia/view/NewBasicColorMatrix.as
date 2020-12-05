package com.goodgamestudios.mafia.view
{
   import flash.filters.ColorMatrixFilter;
   
   public class NewBasicColorMatrix
   {
      
      private static var r_lum:Number = 0.3086;
      
      private static var g_lum:Number = 0.6094;
      
      private static var b_lum:Number = 0.082;
      
      private static var IDENTITY:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
       
      
      public var matrix:Array;
      
      public function NewBasicColorMatrix(param1:Object = null)
      {
         super();
         if(param1 is NewBasicColorMatrix)
         {
            this.matrix = param1.matrix.concat();
         }
         else if(param1 is Array)
         {
            this.matrix = param1.concat();
         }
         else
         {
            this.reset();
         }
      }
      
      public function reset() : void
      {
         this.matrix = IDENTITY.concat();
      }
      
      public function desaturate() : void
      {
         var _loc1_:Array = [r_lum,g_lum,b_lum,0,0,r_lum,g_lum,b_lum,0,0,r_lum,g_lum,b_lum,0,0,0,0,0,1,0];
         this.concat(_loc1_);
      }
      
      public function concat(param1:Array) : void
      {
         var _loc5_:Number = NaN;
         var _loc2_:Array = new Array();
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         while(_loc4_ < 4)
         {
            _loc5_ = 0;
            while(_loc5_ < 5)
            {
               _loc2_[_loc3_ + _loc5_] = param1[_loc3_] * this.matrix[_loc5_] + param1[_loc3_ + 1] * this.matrix[_loc5_ + 5] + param1[_loc3_ + 2] * this.matrix[_loc5_ + 10] + param1[_loc3_ + 3] * this.matrix[_loc5_ + 15] + (_loc5_ == 4?param1[_loc3_ + 4]:0);
               _loc5_++;
            }
            _loc3_ = _loc3_ + 5;
            _loc4_++;
         }
         this.matrix = _loc2_;
      }
      
      public function get filter() : ColorMatrixFilter
      {
         return new ColorMatrixFilter(this.matrix);
      }
   }
}
