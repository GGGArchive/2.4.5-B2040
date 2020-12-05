package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaBreakingTheLawIsOverProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaBreakingTheLawIsOverDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaBreakingTheLawIsOverDialog";
       
      
      public function MafiaBreakingTheLawIsOverDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.dialog.txt_title.text = this.data.title;
         this.dialog.txt_info.text = this.data.copy;
         this.dialog.txt_xp.text = NumberStringHelper.groupString(this.data.xp,MafiaModel.languageData.getTextById);
         this.dialog.txt_cash.text = NumberStringHelper.groupString(this.data.cash,MafiaModel.languageData.getTextById);
         this.dialog.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
         this.dialog.btn_ok.label = this.data.buttonLabel_ok;
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.dialog.btn_close:
            case this.dialog.btn_ok:
               hide();
         }
         super.onClick(param1);
      }
      
      protected function get dialog() : MafiaBreakingTheLawIsOver
      {
         return disp as MafiaBreakingTheLawIsOver;
      }
      
      protected function get data() : MafiaBreakingTheLawIsOverProperties
      {
         return properties as MafiaBreakingTheLawIsOverProperties;
      }
   }
}
