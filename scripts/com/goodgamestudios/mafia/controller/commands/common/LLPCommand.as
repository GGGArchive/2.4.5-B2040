package com.goodgamestudios.mafia.controller.commands.common
{
   import com.goodgamestudios.basic.controller.BasicSmartfoxConstants;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   
   public class LLPCommand extends MafiaCommand
   {
       
      
      public function LLPCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return BasicSmartfoxConstants.S2C_LOST_PASSWORD;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            layoutManager.hideAllDialogs();
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_change_password_title"),MafiaModel.languageData.getTextById("generic_change_password_copy_send"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
            return true;
         }
         if(MafiaDialogHandler.getInstance().blockDialogs)
         {
            return false;
         }
         MafiaDialogHandler.getInstance().blockDialogs = true;
         if(param1 != 0)
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("generic_register_emailwrong_copy"),this.allowDialogs,MafiaModel.languageData.getTextById("generic_btn_okay")));
         }
         return false;
      }
      
      private function allowDialogs(param1:Object) : void
      {
         MafiaDialogHandler.getInstance().blockDialogs = false;
      }
   }
}
