package com.goodgamestudios.mafia.controller.commands.messages
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.message.shownews.PBMessageShowNewsRequest;
   import com.goodgamestudios.mafia.controller.protobuf.message.shownews.PBMessageShowNewsResponse;
   import com.goodgamestudios.mafia.controller.protobuf.message.shownews.response.PBMessageShowNewsResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ShowNewsCommand extends BasicProtobufCommand
   {
       
      
      public function ShowNewsCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBMessageShowNewsRequest = new PBMessageShowNewsRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMessageShowNewsResponse = param1 as PBMessageShowNewsResponse;
         switch(_loc2_.result)
         {
            case PBMessageShowNewsResult.OK:
               MafiaModel.userData.messageData.parseMessages(_loc2_.messages);
               return true;
            case PBMessageShowNewsResult.MESSAGE_ID_DOESNT_EXIST:
               trace("Error in ReadMessageCommand: Message ID does not exist");
               break;
            case PBMessageShowNewsResult.MESSAGE_ID_DOESNT_MATCH_REQUESTER:
               trace("Error in ReadMessageCommand: Message ID does not match requester");
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMessageShowNewsRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMessageShowNewsResponse;
      }
   }
}
