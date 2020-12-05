package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.inviteplayertofamily.PBFamilyInvitePlayerToFamilyRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.inviteplayertofamily.PBFamilyInvitePlayerToFamilyResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.inviteplayertofamily.response.PBFamilyInvitePlayerToFamilyResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.netease.protobuf.Message;
   
   public class InvitePlayerToFamilyCommand extends BasicProtobufCommand
   {
       
      
      public function InvitePlayerToFamilyCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:int) : void
      {
         var _loc2_:PBFamilyInvitePlayerToFamilyRequest = new PBFamilyInvitePlayerToFamilyRequest();
         _loc2_.playerId = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyInvitePlayerToFamilyResponse = param1 as PBFamilyInvitePlayerToFamilyResponse;
         switch(_loc2_.result)
         {
            case PBFamilyInvitePlayerToFamilyResult.OK:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaFamilyInviteDialog_title"),MafiaModel.languageData.getTextById("MafiaFamilyInviteDialog_copy_1")));
               return true;
            case PBFamilyInvitePlayerToFamilyResult.FAMILY_FULL:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaAvatarScreen_btn_invite"),MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_copy_1")));
               break;
            case PBFamilyInvitePlayerToFamilyResult.INVITING_PLAYER_NOT_IN_FAMILY:
               break;
            case PBFamilyInvitePlayerToFamilyResult.PLAYER_ALREADY_IN_FAMILY:
               break;
            case PBFamilyInvitePlayerToFamilyResult.RANK_TOO_LOW:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyInvitePlayerToFamilyRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyInvitePlayerToFamilyResponse;
      }
   }
}
