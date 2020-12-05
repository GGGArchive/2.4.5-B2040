package com.goodgamestudios.mafia.controller.commands.messages
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.constants.enums.MessageType;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.ProtobufEnumTranslator;
   import com.goodgamestudios.mafia.controller.protobuf.message.readmessages.PBMessageReadMessagesRequest;
   import com.goodgamestudios.mafia.controller.protobuf.message.readmessages.PBMessageReadMessagesResponse;
   import com.goodgamestudios.mafia.controller.protobuf.message.readmessages.response.PBMessageReadMessagesResult;
   import com.goodgamestudios.mafia.event.model.MafiaNewsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class ReadMessageCommand extends BasicProtobufCommand
   {
       
      
      public function ReadMessageCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int, param2:MessageType) : void
      {
         var _loc3_:PBMessageReadMessagesRequest = new PBMessageReadMessagesRequest();
         _loc3_.messageId = param1;
         _loc3_.messageType = param2.index;
         ProtobufController.getInstance().sendRequest(_loc3_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMessageReadMessagesResponse = null;
         var _loc3_:MessageType = null;
         _loc2_ = param1 as PBMessageReadMessagesResponse;
         switch(_loc2_.result)
         {
            case PBMessageReadMessagesResult.OK:
               _loc3_ = ProtobufEnumTranslator.translateProtoMessageType(_loc2_.messageType);
               MafiaModel.userData.messageData.readMessagesData.readMsgType = _loc3_;
               switch(_loc3_)
               {
                  case MessageType.ClanInvitation:
                     MafiaModel.userData.messageData.parseClanwarInvitation(_loc2_.clanInvitation);
                     break;
                  case MessageType.FightWon:
                  case MessageType.FightLost:
                     MafiaModel.userData.messageData.parseReplayFightData(_loc2_.fight,_loc2_.reward);
                     break;
                  case MessageType.PaymentDoppler:
                     MafiaModel.userData.messageData.setDopplerCount(_loc2_.dopplerCount);
               }
               if(_loc2_.hasText)
               {
                  MafiaModel.userData.messageData.parseText(_loc2_.text);
               }
               BasicController.getInstance().dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.CHANGE_READMSGDATA));
               return true;
            case PBMessageReadMessagesResult.MESSAGE_ID_DOESNT_EXIST:
               trace("Error in ReadMessageCommand: Message ID does not exist");
               break;
            case PBMessageReadMessagesResult.MESSAGE_ID_DOESNT_MATCH_REQUESTER:
               trace("Error in ReadMessageCommand: Message ID does not match requester");
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMessageReadMessagesRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMessageReadMessagesResponse;
      }
   }
}
