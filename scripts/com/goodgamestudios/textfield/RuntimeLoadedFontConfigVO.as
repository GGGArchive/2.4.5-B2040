package com.goodgamestudios.textfield
{
   public class RuntimeLoadedFontConfigVO extends FontConfigVO
   {
       
      
      public var ggsLanguageCode:String;
      
      public function RuntimeLoadedFontConfigVO(param1:String)
      {
         super();
         this.ggsLanguageCode = param1;
         yOffset = -3;
      }
      
      override public function toString() : String
      {
         return "ggsLanguageCode: " + this.ggsLanguageCode + ", " + super.toString();
      }
   }
}
