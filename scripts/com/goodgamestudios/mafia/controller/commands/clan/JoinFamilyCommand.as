package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.joinfamily.PBFamilyJoinFamilyRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.joinfamily.PBFamilyJoinFamilyResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.joinfamily.response.PBFamilyJoinFamilyResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaSocialData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaClanLevelUpDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaClanLevelUpDialogProperties;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.netease.protobuf.Message;
   
   public class JoinFamilyCommand extends BasicProtobufCommand
   {
       
      
      public function JoinFamilyCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:uint, param2:String, param3:uint) : void
      {
         var _loc4_:PBFamilyJoinFamilyRequest = new PBFamilyJoinFamilyRequest();
         _loc4_.familyId = param1;
         _loc4_.hashcode = param2;
         _loc4_.inviteMsgId = param3;
         ProtobufController.getInstance().sendRequest(_loc4_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyJoinFamilyResponse = param1 as PBFamilyJoinFamilyResponse;
         switch(_loc2_.result)
         {
            case PBFamilyJoinFamilyResult.OK:
               layoutManager.showDialog(MafiaClanLevelUpDialog.NAME,new MafiaClanLevelUpDialogProperties(MafiaModel.languageData.getTextById("MafiaLevelUpDialog_title"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_2"),MafiaModel.languageData.getTextById("generic_btn_share"),MafiaModel.languageData.getTextById("generic_btn_okay"),this.feedJoin));
               layoutManager.state = Constants_LayoutStates.STATE_USERCLAN;
               MafiaLayoutManager.getInstance().showSpecificPanel(MafiaReviewTutorialPanel.NAME,new BasicStandardOkDialogProperties("",MafiaModel.languageData.getTextById("MafiaHelpTutDialog_family")));
               return true;
            case PBFamilyJoinFamilyResult.ALREADY_IN_FAMILY:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_title"),MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_copy_4")));
               break;
            case PBFamilyJoinFamilyResult.CANNOT_JOIN_FAMILY:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_title"),MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_copy_1")));
               break;
            case PBFamilyJoinFamilyResult.INVALID_FAMILY_ID:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_title"),MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_copy_2")));
               break;
            case PBFamilyJoinFamilyResult.INVALID_HASH:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_title"),MafiaModel.languageData.getTextById("MafiaCanNotJoinFamilyDialog_copy_3")));
               break;
            case PBFamilyJoinFamilyResult.INVALID_MSG_ID:
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyJoinFamilyRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyJoinFamilyResponse;
      }
      
      private function feedJoin(param1:Object = null) : void
      {
         MafiaModel.socialData.postFeed(MafiaSocialData.EXTERNAL_SHARE_JOIN_CLAN,[MafiaModel.userData.profileData.clanName]);
      }
   }
}
