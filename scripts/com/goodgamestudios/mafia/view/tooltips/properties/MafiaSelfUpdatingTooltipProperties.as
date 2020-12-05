package com.goodgamestudios.mafia.view.tooltips.properties
{
   public class MafiaSelfUpdatingTooltipProperties extends MafiaMultiLineAdvancedTooltipProperties
   {
       
      
      public var onUpdate:Function;
      
      public var functionParams:Array;
      
      public var updateInterval:int;
      
      public function MafiaSelfUpdatingTooltipProperties(param1:Function, param2:Array, param3:int)
      {
         super(param1(param2));
         this.onUpdate = param1;
         this.functionParams = param2;
         this.updateInterval = param3;
      }
   }
}
