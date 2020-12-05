package com.goodgamestudios.mafia.controller.commands.quest
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.quest.getactivequests.response.PBQuestGetActiveQuestsResult;
   import com.goodgamestudios.mafia.controller.protobuf.quest.viewquestbook.PBQuestViewQuestBookRequest;
   import com.goodgamestudios.mafia.controller.protobuf.quest.viewquestbook.PBQuestViewQuestBookResponse;
   import com.goodgamestudios.mafia.event.model.MafiaQuestEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ViewQuestBookCommand extends BasicProtobufCommand
   {
       
      
      public function ViewQuestBookCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBQuestViewQuestBookRequest = new PBQuestViewQuestBookRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBQuestViewQuestBookResponse = param1 as PBQuestViewQuestBookResponse;
         switch(_loc2_.result)
         {
            case PBQuestGetActiveQuestsResult.OK:
               MafiaModel.userData.questData.viewedNewQuests();
               controller.dispatchEvent(new MafiaQuestEvent(MafiaQuestEvent.CHANGE_QUESTLOG_DATA));
               return true;
            default:
               return false;
         }
      }
      
      override public function getRequestClass() : Class
      {
         return PBQuestViewQuestBookRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBQuestViewQuestBookResponse;
      }
   }
}
