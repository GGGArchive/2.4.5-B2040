package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.view.TextValide;
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaChangePasswordDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaChangePasswordDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaChangePasswordDialog";
       
      
      public function MafiaChangePasswordDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.changePassDialog.btn_yes.label = this.changePassDialogProperties.buttonLabel_yes;
         this.changePassDialog.btn_no.label = this.changePassDialogProperties.buttonLabel_no;
      }
      
      override protected function applyProperties() : void
      {
         this.changePassDialog.txt_title.text = this.changePassDialogProperties.title;
         this.changePassDialog.txt_old.text = this.changePassDialogProperties.oldpassword_text;
         this.changePassDialog.txt_new.text = this.changePassDialogProperties.newpassword_text;
         this.changePassDialog.txt_oldpass.text = "";
         this.changePassDialog.txt_oldpass.displayAsPassword = true;
         this.changePassDialog.txt_oldpass.maxChars = Constants_Basic.MAX_NAMELENGTH;
         this.changePassDialog.txt_newpass.text = "";
         this.changePassDialog.txt_newpass.displayAsPassword = true;
         this.changePassDialog.txt_newpass.maxChars = Constants_Basic.MAX_NAMELENGTH;
         this.changePassDialog.txt_oldpass.tabIndex = 100;
         this.changePassDialog.txt_newpass.tabIndex = 200;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.changePassDialog.btn_yes:
               if(!TextValide.isSmartFoxValide(TextValide.trimPassword(this.changePassDialog.txt_newpass.text)) || !TextValide.isSmartFoxValide(TextValide.trimPassword(this.changePassDialog.txt_oldpass.text)))
               {
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_alert_watchout"),MafiaModel.languageData.getTextById("generic_change_password_faild_specialcharacters"),null,MafiaModel.languageData.getTextById("generic_btn_okay")));
               }
               else if(TextValide.trimPassword(this.changePassDialog.txt_newpass.text).length > 0)
               {
                  if(this.changePassDialogProperties.functionYes != null)
                  {
                     this.changePassDialogProperties.functionYes([TextValide.trimPassword(this.changePassDialog.txt_oldpass.text),TextValide.trimPassword(this.changePassDialog.txt_newpass.text),GGSCountryController.instance.currentCountry.ggsLanguageCode]);
                  }
               }
               else
               {
                  layoutManager.showDialog(MafiaStandardOkDialog.NAME,new BasicStandardOkDialogProperties(MafiaModel.languageData.getTextById("generic_change_password_faild_title"),MafiaModel.languageData.getTextById("generic_change_password_faild_copy")));
               }
               break;
            case this.changePassDialog.btn_no:
               hide();
               if(this.changePassDialogProperties.functionNo != null)
               {
                  this.changePassDialogProperties.functionNo(null);
               }
         }
      }
      
      public function get newPass() : String
      {
         return this.changePassDialog.txt_newpass.text;
      }
      
      protected function get changePassDialogProperties() : MafiaChangePasswordDialogProperties
      {
         return properties as MafiaChangePasswordDialogProperties;
      }
      
      protected function get changePassDialog() : ChangePassword
      {
         return disp as ChangePassword;
      }
   }
}
