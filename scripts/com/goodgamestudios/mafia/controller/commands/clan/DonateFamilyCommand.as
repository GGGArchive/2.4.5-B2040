package com.goodgamestudios.mafia.controller.commands.clan
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardYesNoDialogProperties;
   import com.goodgamestudios.mafia.controller.BasicProtobufCommand;
   import com.goodgamestudios.mafia.controller.ProtobufController;
   import com.goodgamestudios.mafia.controller.protobuf.family.donatefamily.PBFamilyDonateFamilyRequest;
   import com.goodgamestudios.mafia.controller.protobuf.family.donatefamily.PBFamilyDonateFamilyResponse;
   import com.goodgamestudios.mafia.controller.protobuf.family.donatefamily.response.PBFamilyDonateFamilyResult;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaNoGoldDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   import com.netease.protobuf.Message;
   
   public class DonateFamilyCommand extends BasicProtobufCommand
   {
       
      
      public function DonateFamilyCommand()
      {
         super();
      }
      
      public static function sendCommand(param1:uint) : void
      {
         var _loc2_:PBFamilyDonateFamilyRequest = new PBFamilyDonateFamilyRequest();
         _loc2_.goldAmount = param1;
         ProtobufController.getInstance().sendRequest(_loc2_);
      }
      
      override public function executeCommand(param1:Message) : Boolean
      {
         var _loc2_:PBFamilyDonateFamilyResponse = param1 as PBFamilyDonateFamilyResponse;
         switch(_loc2_.result)
         {
            case PBFamilyDonateFamilyResult.OK:
               ShowClanCommand.sendCommand();
               return true;
            case PBFamilyDonateFamilyResult.NOT_ENOUGH_GOLD:
               layoutManager.showDialog(MafiaNoGoldDialog.NAME,new BasicStandardYesNoDialogProperties(MafiaModel.languageData.getTextById("MafiaNoMoneyDialog_title"),MafiaModel.languageData.getTextById("MafiaNoMoneyForDonate_copy"),controller.onClickMoreMoney,null,null,MafiaModel.languageData.getTextById("MafiaPaymentDialog_btn_buygold"),MafiaModel.languageData.getTextById("generic_btn_close")));
               break;
            case PBFamilyDonateFamilyResult.NOT_FAMILY_MEMBER:
               break;
            case PBFamilyDonateFamilyResult.NOT_PAYMENT_PLAYER:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaFamilyScreen_copy_6")));
         }
         return false;
      }
      
      override public function getRequestClass() : Class
      {
         return PBFamilyDonateFamilyRequest;
      }
      
      override public function getResponseClass() : Class
      {
         return PBFamilyDonateFamilyResponse;
      }
   }
}
