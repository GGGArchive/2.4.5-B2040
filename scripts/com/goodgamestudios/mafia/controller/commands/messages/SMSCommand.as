package com.goodgamestudios.mafia.controller.commands.messages
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.event.model.MafiaNewsEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   
   public class SMSCommand extends MafiaCommand
   {
       
      
      public function SMSCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_SEND_MSG;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         switch(param1)
         {
            case 0:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("MafiaMailScreen_title"),MafiaModel.languageData.getTextById("MafiaMailScreen_copy_15")));
               controller.dispatchEvent(new MafiaNewsEvent(MafiaNewsEvent.CHANGE_SENDMSG));
               return true;
            case 1:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaMailScreen_copy_20")));
               break;
            case 2:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaMailScreen_copy_16")));
               break;
            case 3:
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("MafiaMailScreen_copy_17")));
         }
         return false;
      }
   }
}
