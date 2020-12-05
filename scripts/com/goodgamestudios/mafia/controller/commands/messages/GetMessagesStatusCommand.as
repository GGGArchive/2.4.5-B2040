package com.goodgamestudios.mafia.controller.commands.messages
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.message.getmessagesstatus.PBMessageGetMessagesStatusRequest;
   import com.goodgamestudios.mafia.controller.protobuf.message.getmessagesstatus.PBMessageGetMessagesStatusResponse;
   import com.goodgamestudios.mafia.event.model.MafiaNewsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class GetMessagesStatusCommand extends BasicProtobufCommand
   {
       
      
      public function GetMessagesStatusCommand()
      {
         super();
      }
      
      public static function sendCommand() : void
      {
         var _loc1_:PBMessageGetMessagesStatusRequest = new PBMessageGetMessagesStatusRequest();
         ProtobufController.getInstance().sendRequest(_loc1_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBMessageGetMessagesStatusResponse = param1 as PBMessageGetMessagesStatusResponse;
         MafiaModel.userData.messageData.newMessages = _loc2_.unreadMessages;
         controller.dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.CHANGE_NEWNEWSDATA));
         return true;
      }
      
      override public function getRequestClass() : Class
      {
         return PBMessageGetMessagesStatusRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBMessageGetMessagesStatusResponse;
      }
   }
}
