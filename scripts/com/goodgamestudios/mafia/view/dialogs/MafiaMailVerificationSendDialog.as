package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaMailVerificationSendDialogProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaMailVerificationSendDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaMailVerificationSendDialog";
       
      
      public function MafiaMailVerificationSendDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.mailDialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
      }
      
      override protected function applyProperties() : void
      {
         this.mailDialog.txt_title.text = this.mailDialogProperties.title;
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.mailDialog.txt_copy,this.mailDialogProperties.copy,4);
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.mailDialog.txt_copy2,this.mailDialogProperties.copy2,5);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         if(param1.target == this.mailDialog.btn_ok)
         {
            hide();
         }
      }
      
      protected function get mailDialogProperties() : MafiaMailVerificationSendDialogProperties
      {
         return properties as MafiaMailVerificationSendDialogProperties;
      }
      
      protected function get mailDialog() : MafiaMailVerificationSend
      {
         return disp as MafiaMailVerificationSend;
      }
   }
}
