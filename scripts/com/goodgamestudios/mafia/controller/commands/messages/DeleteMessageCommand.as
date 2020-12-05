package com.goodgamestudios.mafia.controller.commands.messages
{
   import com.goodgamestudios.mafia.constants.enums.MessageType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.message.deletemessage.PBMessageDeleteMessageRequest;
   import com.goodgamestudios.mafia.controller.protobuf.message.deletemessage.PBMessageDeleteMessageResponse;
   import com.goodgamestudios.mafia.controller.protobuf.message.deletemessage.response.PBMessageDeleteMessageResult;
   import com.netease.protobuf.Message;
   
   public class DeleteMessageCommand extends BasicProtobufCommand
   {
       
      
      public function DeleteMessageCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:MessageType) : void
      {
         var _loc3_:PBMessageDeleteMessageRequest = new PBMessageDeleteMessageRequest();
         _loc3_.messageId = param1;
         _loc3_.messageType = param2.index;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMessageDeleteMessageResponse = param1 as PBMessageDeleteMessageResponse;
         switch(_loc2_.result)
         {
            case PBMessageDeleteMessageResult.OK:
               return true;
            case PBMessageDeleteMessageResult.MESSAGE_ID_DOESNT_EXIST:
               trace("Error in DeleteMessageCommand: Message ID does not exist");
               break;
            case PBMessageDeleteMessageResult.MESSAGE_ID_DOESNT_MATCH_REQUESTER:
               trace("Error in DeleteMessageCommand: Message ID does not match requester");
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMessageDeleteMessageRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMessageDeleteMessageResponse;
      }
   }
}
