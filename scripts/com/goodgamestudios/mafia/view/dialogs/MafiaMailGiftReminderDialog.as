package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaDialogHandler;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaMailGiftReminderDialogProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaMailGiftReminderDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaMailGiftReminderDialog";
       
      
      public function MafiaMailGiftReminderDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.mailDialog.btn_yes.label = MafiaModel.languageData.getTextById("generic_btn_yes");
         this.mailDialog.btn_later.label = MafiaModel.languageData.getTextById("generic_register_btn_later");
      }
      
      override protected function applyProperties() : void
      {
         this.mailDialog.txt_title.text = this.mailDialogProperties.title;
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.mailDialog.txt_copy,this.mailDialogProperties.copy,5);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.mailDialog.btn_yes:
               hide();
               MafiaDialogHandler.getInstance().registerDialogs(MafiaMailVerificationDialog.NAME,null,true);
               break;
            case this.mailDialog.btn_later:
            case this.mailDialog.btn_close:
               hide();
         }
      }
      
      protected function get mailDialogProperties() : MafiaMailGiftReminderDialogProperties
      {
         return properties as MafiaMailGiftReminderDialogProperties;
      }
      
      protected function get mailDialog() : MafiaMailGiftReminder
      {
         return disp as MafiaMailGiftReminder;
      }
   }
}
