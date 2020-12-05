package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaMailGiftDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaMailGiftDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaMailGiftDialog";
       
      
      public function MafiaMailGiftDialog(param1:Sprite)
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
         this.mailDialog.txt_copy.text = this.mailDialogProperties.copy;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         if(param1.target == this.mailDialog.btn_ok || param1.target == this.mailDialog.btn_close)
         {
            hide();
         }
      }
      
      protected function get mailDialogProperties() : MafiaMailGiftDialogProperties
      {
         return properties as MafiaMailGiftDialogProperties;
      }
      
      protected function get mailDialog() : MafiaMailGift
      {
         return disp as MafiaMailGift;
      }
   }
}
