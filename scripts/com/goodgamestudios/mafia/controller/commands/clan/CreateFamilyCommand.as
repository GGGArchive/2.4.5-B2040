package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.createfamily.PBFamilyCreateFamilyRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.createfamily.PBFamilyCreateFamilyResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.createfamily.response.PBFamilyCreateFamilyResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaSocialData;
   import com.goodgamestudios.mafia.view.MafiaLayoutManager;
   import com.goodgamestudios.mafia.view.dialogs.MafiaClanLevelUpDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardYesNoDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaClanLevelUpDialogProperties;
   import com.goodgamestudios.mafia.view.panels.MafiaReviewTutorialPanel;
   import com.netease.protobuf.Message;
   
   public class CreateFamilyCommand extends BasicProtobufCommand
   {
       
      
      public function CreateFamilyCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:String) : void
      {
         var _loc2_:PBFamilyCreateFamilyRequest = new PBFamilyCreateFamilyRequest();
         _loc2_.familyName = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyCreateFamilyResponse = param1 as PBFamilyCreateFamilyResponse;
         switch(_loc2_.result)
         {
            case PBFamilyCreateFamilyResult.OK:
               MafiaLayoutManager.getInstance().state = Constants_LayoutStates.STATE_USERCLAN;
               MafiaLayoutManager.getInstance().showSpecificPanel(MafiaReviewTutorialPanel.NAME,new BasicStandardOkDialogProperties("",MafiaModel.languageData.getTextById("MafiaHelpTutDialog_family")));
               layoutManager.showDialog(MafiaClanLevelUpDialog.NAME,new MafiaClanLevelUpDialogProperties(MafiaModel.languageData.getTextById("MafiaLevelUpDialog_title"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_familyfeeds_1"),MafiaModel.languageData.getTextById("generic_btn_share"),MafiaModel.languageData.getTextById("generic_btn_okay"),this.feedCreate));
               return true;
            case PBFamilyCreateFamilyResult.NAME_ALREADY_EXISTS:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_2")));
               break;
            case PBFamilyCreateFamilyResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaStandardYesNoDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaNoMoneyForFamilyStart_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("generic_btn_yes"),MafiaModel.languageData.getTextById("generic_btn_no")));
               break;
            case PBFamilyCreateFamilyResult.NAME_TOO_SHORT:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_4")));
               break;
            case PBFamilyCreateFamilyResult.NAME_TOO_LONG:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_3")));
               break;
            case PBFamilyCreateFamilyResult.NAME_INVALID:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_5")));
               break;
            case PBFamilyCreateFamilyResult.ALREADY_IN_FAMILY:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaMailScreen_copy_9")));
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyCreateFamilyRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyCreateFamilyResponse;
      }
      
      private function feedCreate(param1:Object = null) : void
      {
         MafiaModel.socialData.postFeed(MafiaSocialData.EXTERNAL_SHARE_CREATE_CLAN,[MafiaModel.userData.profileData.clanName]);
      }
   }
}
