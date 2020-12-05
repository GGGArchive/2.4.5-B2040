package com.goodgamestudios.mafia.controller.commands.quest
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests.PBQuestGetActiveQuestsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests.PBQuestGetActiveQuestsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests.response.PBQuestGetActiveQuestsResult;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class GetActiveQuestsCommand extends BasicProtobufCommand
   {
       
      
      public function GetActiveQuestsCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBQuestGetActiveQuestsRequest = new PBQuestGetActiveQuestsRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBQuestGetActiveQuestsResponse = param1 as PBQuestGetActiveQuestsResponse;
         switch(_loc2_.result)
         {
            case PBQuestGetActiveQuestsResult.OK:
               MafiaModel.userData.questData.parseActiveQuests(_loc2_.quests,_loc2_.newQuestsAvailable);
               BasicController.getInstance().dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.CHANGE_QUESTLOG_DATA));
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBQuestGetActiveQuestsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBQuestGetActiveQuestsResponse;
      }
   }
}
