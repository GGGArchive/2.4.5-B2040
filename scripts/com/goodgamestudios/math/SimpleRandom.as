package com.goodgamestudios.math
{
   public class SimpleRandom
   {
       
      
      private var seed:int;
      
      public function SimpleRandom(param1:int)
      {
         super();
         this.seed = param1 ^ 3740067437;
      }
      
      private function next() : int
      {
         var _loc1_:int = this.seed;
         _loc1_ = int(_loc1_ * 16807) % 2147483647;
         _loc1_ = (int(_loc1_ * 14903917) + 11) % 2147483647;
         this.seed = _loc1_;
         return this.seed;
      }
      
      public function nextInt(param1:int) : int
      {
         return this.nextInt2() % param1;
      }
      
      public function nextInt2() : int
      {
         return Math.abs(this.next());
      }
   }
}
