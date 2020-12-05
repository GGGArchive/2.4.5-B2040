package com.goodgamestudios.mafia.view.tooltips.properties
{
   public class MafiaActionPanelAvatarAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var energy:Number;
      
      public var ap:int;
      
      public var level:int;
      
      public var xp:Number;
      
      public var xpForCurrentLevel:Number;
      
      public var xpForNextLevel:Number;
      
      public function MafiaActionPanelAvatarAdvancedTooltipProperties(param1:int, param2:Number, param3:Number, param4:Number, param5:Number, param6:int)
      {
         this.energy = param5;
         this.ap = param6;
         this.level = param1;
         this.xp = param2;
         this.xpForCurrentLevel = param3;
         this.xpForNextLevel = param4;
         super();
      }
   }
}
