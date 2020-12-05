package com.goodgamestudios.mafia.controller.commands.email
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.controller.commands.MafiaCommand;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.MafiaStandardOkDialog;
   
   public class EMVCommand extends MafiaCommand
   {
       
      
      public function EMVCommand()
      {
         super();
      }
      
      override protected function get cmdId() : String
      {
         return Constants_SFS.S2C_EMAIL_VERIFICATION;
      }
      
      override public function executeCommand(param1:int, param2:Array) : Boolean
      {
         if(param1 == 0)
         {
            MafiaModel.userData.mailVerification.eMailVerificationSend = true;
            MafiaModel.userData.email = param2[1];
            controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.MAIL_VERIFICATION_COMPLETED));
         }
         else
         {
            if(param1 == 102)
            {
               layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("error_common_title"),MafiaModel.languageData.getTextById("MafiaRegisterGuestDialog_copy_14")));
            }
            controller.dispatchEvent(new MafiaUserEvent(MafiaUserEvent.MAIL_VERIFICATION_FAILED,param2));
         }
         return param1 == 0;
      }
   }
}
