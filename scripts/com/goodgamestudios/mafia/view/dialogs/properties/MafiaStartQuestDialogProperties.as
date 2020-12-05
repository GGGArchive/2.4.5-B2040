package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   
   public class MafiaStartQuestDialogProperties extends BasicProperties
   {
       
      
      public var questVO:QuestVO;
      
      public var district_id:int;
      
      public function MafiaStartQuestDialogProperties(param1:QuestVO, param2:int)
      {
         this.questVO = param1;
         this.district_id = param2;
         super();
      }
   }
}
