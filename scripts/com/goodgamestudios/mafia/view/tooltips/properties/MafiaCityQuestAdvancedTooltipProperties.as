package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   
   public class MafiaCityQuestAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var questVO:QuestVO;
      
      public var district_id:int;
      
      public function MafiaCityQuestAdvancedTooltipProperties(param1:QuestVO, param2:int)
      {
         super();
         this.questVO = param1;
         this.district_id = param2;
      }
   }
}
