package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   
   public class MafiaQuestlogAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var questVO:QuestVO;
      
      public function MafiaQuestlogAdvancedTooltipProperties(param1:QuestVO)
      {
         this.questVO = param1;
         super();
      }
   }
}
