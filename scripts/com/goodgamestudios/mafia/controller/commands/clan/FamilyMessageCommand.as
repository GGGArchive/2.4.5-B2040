package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.familymessage.PBFamilyFamilyMessageRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.familymessage.PBFamilyFamilyMessageResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.familymessage.response.PBFamilyFamilyMessageResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.netease.protobuf.Message;
   
   public class FamilyMessageCommand extends BasicProtobufCommand
   {
       
      
      public function FamilyMessageCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:String) : void
      {
         var _loc2_:PBFamilyFamilyMessageRequest = new PBFamilyFamilyMessageRequest();
         _loc2_.messageText = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyFamilyMessageResponse = param1 as PBFamilyFamilyMessageResponse;
         switch(_loc2_.result)
         {
            case PBFamilyFamilyMessageResult.OK:
               MafiaModel.userData.userClan.parseChatData(_loc2_.timeStamp,_loc2_.familyMessages);
               MafiaModel.userData.userClan.parseAccountHistory(_loc2_.timeStamp,_loc2_.familyAccounts);
               MafiaModel.userData.userClan.parseFamilyNotification(_loc2_.timeStamp,_loc2_.familyNotifications);
               return true;
            case PBFamilyFamilyMessageResult.PLAYER_NOT_IN_FAMILY:
               break;
            case PBFamilyFamilyMessageResult.INVALID_TEXT:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyFamilyMessageRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyFamilyMessageResponse;
      }
   }
}
