package com.goodgamestudios.mafia.view.tooltips.properties
{
   public class MafiaBarAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var refiller:int;
      
      public var maxRefill:int;
      
      public function MafiaBarAdvancedTooltipProperties(param1:int, param2:int)
      {
         this.refiller = param1;
         this.maxRefill = param2;
         super();
      }
   }
}
