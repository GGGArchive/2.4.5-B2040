package com.goodgamestudios.language.unicodeRanges
{
   public class UnicodeRange
   {
       
      
      public var rangeId:String;
      
      public var rangeOffset:int;
      
      public var rangeEnd:int;
      
      public function UnicodeRange(param1:String, param2:int, param3:int)
      {
         super();
         this.rangeId = param1;
         this.rangeOffset = param2;
         this.rangeEnd = param3;
      }
      
      public function toString() : String
      {
         return "rangeId: " + this.rangeId + ", rangeOffset: " + this.rangeOffset + ", rangeEnd: " + this.rangeEnd;
      }
   }
}
