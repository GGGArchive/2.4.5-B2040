package com.goodgamestudios.mafia.controller.commands.quest
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.quest.startquest.PBQuestStartQuestRequest;
   import com.goodgamestudios.mafia.controller.protobuf.quest.startquest.PBQuestStartQuestResponse;
   import com.goodgamestudios.mafia.controller.protobuf.quest.startquest.response.PBQuestStartQuestResult;
   import com.netease.protobuf.Message;
   
   public class StartQuestCommand extends BasicProtobufCommand
   {
       
      
      public function StartQuestCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBQuestStartQuestRequest = new PBQuestStartQuestRequest();
         _loc2_.questId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBQuestStartQuestResponse = param1 as PBQuestStartQuestResponse;
         switch(_loc2_.result)
         {
            case PBQuestStartQuestResult.OK:
               return true;
            case PBQuestStartQuestResult.QUEST_ALREADY_FINISHED:
               break;
            case PBQuestStartQuestResult.QUEST_CANT_BE_STARTED:
               break;
            case PBQuestStartQuestResult.QUEST_DOES_NOT_EXIST:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBQuestStartQuestRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBQuestStartQuestResponse;
      }
   }
}
