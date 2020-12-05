package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.model.components.user.MafiaAttributeCostsData;
   
   public class MafiaPushAttributAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var cost:MafiaAttributeCostsData;
      
      public var current:int;
      
      public function MafiaPushAttributAdvancedTooltipProperties(param1:MafiaAttributeCostsData, param2:int)
      {
         super();
         this.cost = param1;
         this.current = param2;
      }
   }
}
