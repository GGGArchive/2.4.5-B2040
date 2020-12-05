package com.goodgamestudios.mafia.controller.commands.email
{
   import com.goodgamestudios.basic.model.components.BasicDialogHandler;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.MafiaMailGiftDialog;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaMailGiftDialogProperties;
   
   public class EMCCommand extends MafiaCommand
   {
       
      
      public function EMCCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_EMAIL_CONFIRMED;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaDialogHandler.getInstance().registerDialogs(MafiaMailGiftDialog.NAME,new MafiaMailGiftDialogProperties(MafiaModel.languageData.getTextById("MafiaValidationReceivedDialog_title"),MafiaModel.languageData.getTextById("MafiaValidationReceivedDialog_copy_1",[MafiaModel.goldConstants.emailVerificationGold])),true,BasicDialogHandler.PRIORITY_MIDDLE);
         }
         return param1 == 0;
      }
   }
}
