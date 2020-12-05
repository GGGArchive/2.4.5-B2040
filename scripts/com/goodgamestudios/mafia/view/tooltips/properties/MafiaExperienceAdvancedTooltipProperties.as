package com.goodgamestudios.mafia.view.tooltips.properties
{
   public class MafiaExperienceAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var xp:Number;
      
      public var xpForCurrentLevel:int;
      
      public var xpForNextLevel:int;
      
      public function MafiaExperienceAdvancedTooltipProperties(param1:Number, param2:int, param3:int)
      {
         this.xp = param1;
         this.xpForCurrentLevel = param2;
         this.xpForNextLevel = param3;
         super();
      }
   }
}
