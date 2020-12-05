package com.goodgamestudios.textfield
{
   import flash.text.TextFormat;
   
   public class FontConfigVO
   {
       
      
      private var debug:Boolean = false;
      
      public var debugColor:Number = 65280;
      
      public var fontName:String;
      
      public var yOffset:Number = 0;
      
      private var _y:Number;
      
      private var _textFormat:TextFormat;
      
      public function FontConfigVO()
      {
         super();
      }
      
      public function setYPosition(param1:Number) : void
      {
         this._y = param1 + this.yOffset;
      }
      
      public function set textFormat(param1:TextFormat) : void
      {
         this._textFormat = param1;
         this._textFormat.font = this.fontName;
         if(this.debug)
         {
            this._textFormat.color = this.debugColor;
         }
      }
      
      public function get textFormat() : TextFormat
      {
         return this._textFormat;
      }
      
      public function toString() : String
      {
         return "fontName: " + this.fontName + ", yOffset: " + this.yOffset;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
   }
}
