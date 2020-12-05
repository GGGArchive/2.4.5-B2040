package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaLostPasswordDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaLostPasswordDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaLostPasswordDialog";
       
      
      public function MafiaLostPasswordDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.lostPassDialog.btn_yes.label = this.lostPassDialogProperties.buttonLabel_yes;
         this.lostPassDialog.btn_no.label = this.lostPassDialogProperties.buttonLabel_no;
      }
      
      override protected function applyProperties() : void
      {
         this.lostPassDialog.txt_title.text = this.lostPassDialogProperties.title;
         this.lostPassDialog.txt_copy.text = this.lostPassDialogProperties.copy;
         this.lostPassDialog.input.inputField.text = MafiaModel.languageData.getTextById("generic_email");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.lostPassDialog.input.inputField:
               this.lostPassDialog.input.inputField.text = "";
               break;
            case this.lostPassDialog.btn_yes:
               if(this.lostPassDialog.input.inputField.text.length > 0 && this.lostPassDialogProperties.functionYes != null)
               {
                  this.lostPassDialogProperties.functionYes([this.lostPassDialog.input.inputField.text,GGSCountryController.instance.currentCountry.ggsLanguageCode,new MafiaEnvironmentGlobals().referrer]);
               }
               break;
            case this.lostPassDialog.btn_no:
               hide();
               if(this.lostPassDialogProperties.functionNo != null)
               {
                  this.lostPassDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get lostPassDialogProperties() : MafiaLostPasswordDialogProperties
      {
         return properties as MafiaLostPasswordDialogProperties;
      }
      
      protected function get lostPassDialog() : LostPassword
      {
         return disp as LostPassword;
      }
   }
}
