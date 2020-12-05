package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaChangePasswordDialog;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   
   public class LCPCommand extends MafiaCommand
   {
       
      
      public function LCPCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_CHANGE_PASSWORD;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            if(MafiaModel.localData.readLoginDataUsername() != null && MafiaModel.localData.readLoginDataUsername() != "" && MafiaModel.localData.readLoginDataPass() != null && MafiaModel.localData.readLoginDataPass() != "")
            {
               MafiaModel.userData.loginPwd = (layoutManager.getDialog(MafiaChangePasswordDialog) as MafiaChangePasswordDialog).newPass;
               MafiaModel.localData.saveLoginData(MafiaModel.userData.loginName,MafiaModel.userData.loginPwd,true);
            }
            layoutManager.hideAllDialogs();
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_change_password_title"),MafiaModel.languageData.getTextById("generic_change_password_error_success"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
            return true;
         }
         if(param1 == 1)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("generic_change_password_error_failed"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
         }
         else
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("generic_change_password_faild_specialcharacters"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
         }
         return false;
      }
   }
}
