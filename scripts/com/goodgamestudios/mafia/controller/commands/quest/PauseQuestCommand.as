package com.goodgamestudios.mafia.controller.commands.quest
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.quest.pausequest.PBQuestPauseQuestRequest;
   import com.goodgamestudios.mafia.controller.protobuf.quest.pausequest.PBQuestPauseQuestResponse;
   import com.goodgamestudios.mafia.controller.protobuf.quest.pausequest.response.PBQuestPauseQuestResult;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.netease.protobuf.Message;
   
   public class PauseQuestCommand extends BasicProtobufCommand
   {
       
      
      public function PauseQuestCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBQuestPauseQuestRequest = new PBQuestPauseQuestRequest();
         _loc2_.questId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBQuestPauseQuestResponse = param1 as PBQuestPauseQuestResponse;
         switch(_loc2_.result)
         {
            case PBQuestPauseQuestResult.OK:
               controller.dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.PAUSE_ACTIVE_CITY_QUEST));
               return true;
            case PBQuestPauseQuestResult.QUEST_ALREADY_FINISHED:
               break;
            case PBQuestPauseQuestResult.QUEST_CANT_BE_PAUSED:
               break;
            case PBQuestPauseQuestResult.QUEST_DOES_NOT_EXIST:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBQuestPauseQuestRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBQuestPauseQuestResponse;
      }
   }
}
