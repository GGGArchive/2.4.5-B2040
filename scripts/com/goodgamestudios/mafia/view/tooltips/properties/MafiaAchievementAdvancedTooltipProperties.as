package com.goodgamestudios.mafia.view.tooltips.properties
{
   public class MafiaAchievementAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var achievementId:int;
      
      public var achievementLevel:int;
      
      public var achievementValue:Number;
      
      public var achievementNextValue:Number;
      
      public function MafiaAchievementAdvancedTooltipProperties(param1:int, param2:int, param3:Number = 0, param4:Number = 0)
      {
         this.achievementId = param1;
         this.achievementLevel = param2;
         this.achievementValue = param3;
         this.achievementNextValue = param4;
         super();
      }
   }
}
