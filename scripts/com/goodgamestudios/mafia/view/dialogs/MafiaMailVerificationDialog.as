package com.goodgamestudios.mafia.view.dialogs
{
   import com.adobe.utils.StringUtil;
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.mafia.constants.Constants_SFS;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaMailVerificationSendDialogProperties;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   
   public class MafiaMailVerificationDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaMailVerificationDialog";
       
      
      private var isWaitingForServerMessage:Boolean;
      
      public function MafiaMailVerificationDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         controller.addEventListener(MafiaUserEvent.MAIL_VERIFICATION_FAILED,this.onVerificationComplete);
         controller.addEventListener(MafiaUserEvent.MAIL_VERIFICATION_COMPLETED,this.onVerificationComplete);
         super.init();
      }
      
      override public function destroy() : void
      {
         controller.removeEventListener(MafiaUserEvent.MAIL_VERIFICATION_FAILED,this.onVerificationComplete);
         controller.removeEventListener(MafiaUserEvent.MAIL_VERIFICATION_COMPLETED,this.onVerificationComplete);
         super.destroy();
      }
      
      override public function show() : void
      {
         super.show();
         this.registerDial.btn_ok.label = MafiaModel.languageData.getTextById("MafiaForgotPasswordDialog_btn_send");
      }
      
      override protected function applyProperties() : void
      {
         MafiaModel.userData.mailVerification.reminderShown = true;
         this.isWaitingForServerMessage = false;
         this.registerDial.txt_email.text = MafiaModel.userData.email;
         this.registerDial.txt_title.text = MafiaModel.languageData.getTextById("MafiaValidationGoldForYouDialog_title",[MafiaModel.goldConstants.emailVerificationGold]);
         this.registerDial.txt_copy.text = MafiaModel.languageData.getTextById("MafiaValidationGoldForYouDialog_copy_1",[MafiaModel.goldConstants.emailVerificationGold]);
         this.registerDial.txt_copy2.text = MafiaModel.languageData.getTextById("MafiaValidationGoldForYouDialog_copy_2",[MafiaModel.goldConstants.emailVerificationGold]);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.registerDial.btn_ok:
               this.onVerification();
               break;
            case this.registerDial.btn_close:
               hide();
               break;
            case this.registerDial.txt_email:
               (param1.target as TextField).setSelection(0,(param1.target as TextField).text.length);
         }
      }
      
      override protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.target == this.registerDial.txt_email)
         {
            if(param1.keyCode == Keyboard.ENTER)
            {
               this.onVerification();
            }
         }
      }
      
      private function onVerification() : void
      {
         if(this.isWaitingForServerMessage)
         {
            return;
         }
         if(this.registerDial.txt_email.text.length == 0 || !TextValide.isSmartFoxValide(this.registerDial.txt_email.text))
         {
            layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("generic_register_email_copy")));
            return;
         }
         this.isWaitingForServerMessage = true;
         controller.sendServerMessageAndWait(Constants_SFS.C2S_EMAIL_VERIFICATION,[StringUtil.trim(this.registerDial.txt_email.text)],Constants_SFS.S2C_EMAIL_VERIFICATION);
      }
      
      private function onVerificationComplete(param1:MafiaUserEvent) : void
      {
         this.isWaitingForServerMessage = false;
         if(param1.params && param1.params.length > 0)
         {
            switch(int(param1.params[0]))
            {
               case 14:
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_register_errormistake"),MafiaModel.languageData.getTextById("generic_register_email_copy")));
                  break;
               case 19:
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_register_errormistake"),MafiaModel.languageData.getTextById("generic_register_emaillong_copy")));
                  break;
               case 13:
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_register_errormistake"),MafiaModel.languageData.getTextById("generic_register_error_accountalreadyexists")));
            }
         }
         else
         {
            MafiaDialogHandler.getInstance().registerDialogs(MafiaMailVerificationSendDialog.NAME,new MafiaMailVerificationSendDialogProperties(MafiaModel.languageData.getTextById("MafiaValidationSentDialog_title"),MafiaModel.languageData.getTextById("MafiaValidationSentDialog_copy_1"),MafiaModel.languageData.getTextById("MafiaValidationSentDialog_copy_2")),true);
            hide();
         }
      }
      
      protected function get registerDial() : MafiaMailVerification
      {
         return disp as MafiaMailVerification;
      }
   }
}
