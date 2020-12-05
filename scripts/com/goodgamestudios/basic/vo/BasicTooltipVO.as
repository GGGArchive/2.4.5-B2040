package com.goodgamestudios.basic.vo
{
   import com.goodgamestudios.basic.view.tooltips.BasicAdvancedToolTipProperties;
   import flash.geom.Point;
   
   public class BasicTooltipVO
   {
       
      
      public var dispPos:String;
      
      public var advancedTooltipID:String;
      
      public var advancedTooltipProperties:BasicAdvancedToolTipProperties;
      
      public var cursorStyle:int;
      
      public var staticPosition:Point;
      
      public function BasicTooltipVO(param1:String = null, param2:BasicAdvancedToolTipProperties = null, param3:Point = null, param4:String = "", param5:int = 1)
      {
         super();
         this.advancedTooltipID = param1;
         this.advancedTooltipProperties = param2;
         this.dispPos = param4;
         this.cursorStyle = param5;
         this.staticPosition = param3;
      }
   }
}
