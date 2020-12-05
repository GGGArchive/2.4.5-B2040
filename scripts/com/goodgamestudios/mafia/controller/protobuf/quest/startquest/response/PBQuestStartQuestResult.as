package com.goodgamestudios.mafia.controller.protobuf.quest.startquest.response
{
   public final class PBQuestStartQuestResult
   {
      
      public static const OK:int = 1;
      
      public static const QUEST_ALREADY_FINISHED:int = 2;
      
      public static const QUEST_DOES_NOT_EXIST:int = 3;
      
      public static const QUEST_CANT_BE_STARTED:int = 4;
       
      
      public function PBQuestStartQuestResult()
      {
         super();
      }
   }
}
