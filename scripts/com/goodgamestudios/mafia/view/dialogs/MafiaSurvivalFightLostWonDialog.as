package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaSurvivalFightLostWonDialogProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaSurvivalFightLostWonDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaHellFightLostWonDialog";
       
      
      public function MafiaSurvivalFightLostWonDialog(param1:Sprite)
      {
         super(param1);
         this.hellDialog.bg.gotoAndStop(2);
      }
      
      override public function show() : void
      {
         super.show();
         var _loc1_:String = MafiaModel.languageData.getTextById("MafiaSurvivalScreen_title");
         if(this.standardDialogProperties.won)
         {
            this.hellDialog.txt_title.text = _loc1_ + " - " + MafiaModel.languageData.getTextById("MafiaLevelUpDialog_title");
            TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.hellDialog.txt_copy,MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_14"),7);
            this.hellDialog.cross.visible = true;
         }
         else
         {
            this.hellDialog.txt_title.text = _loc1_ + " - " + MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_6");
            if(this.standardDialogProperties.timeExpired)
            {
               TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.hellDialog.txt_copy,MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_15"),7);
            }
            else
            {
               TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.hellDialog.txt_copy,MafiaModel.languageData.getTextById("MafiaSurvivalScreen_copy_13"),7);
            }
            this.hellDialog.cross.visible = false;
         }
         this.hellDialog.btn_ok.label = MafiaModel.languageData.getTextById("generic_btn_okay");
         this.hellDialog.btn_close.toolTipText = MafiaModel.languageData.getTextById("generic_btn_close");
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.hellDialog.btn_close:
            case this.hellDialog.btn_ok:
               hide();
         }
      }
      
      protected function get standardDialogProperties() : MafiaSurvivalFightLostWonDialogProperties
      {
         return properties as MafiaSurvivalFightLostWonDialogProperties;
      }
      
      protected function get hellDialog() : MafiaHellFightLostWon
      {
         return disp as MafiaHellFightLostWon;
      }
   }
}
