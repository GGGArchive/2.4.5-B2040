package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.quest.QuestVO;
   
   public class MafiaCompleteQuestDialogProperties extends BasicProperties
   {
       
      
      public var quest:QuestVO;
      
      public function MafiaCompleteQuestDialogProperties(param1:QuestVO)
      {
         this.quest = param1;
         super();
      }
   }
}
