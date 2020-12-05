package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.gangwar.GangwarVO;
   
   public class MafiaCityQuestBonusTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var gangwarVO:GangwarVO;
      
      public function MafiaCityQuestBonusTooltipProperties(param1:GangwarVO)
      {
         super();
         this.gangwarVO = param1;
      }
   }
}
