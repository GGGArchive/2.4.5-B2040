package com.goodgamestudios.mafia.view.panels
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaReviewTutorialPanel extends MafiaPanel
   {
      
      public static const NAME:String = "MafiaReviewTutorialPanel";
       
      
      public function MafiaReviewTutorialPanel(param1:Sprite)
      {
         super(param1);
         index = PANEL_INDEX_REVIEWTUTORIAL;
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_ok.label = this.standardDialogProperties.buttonLabel_ok;
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.txt_copy.text = this.standardDialogProperties.copy;
         TextFieldHelper.changeVerticalAlignInMultiLineTextfield(this.standardDialog.txt_copy);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_close:
            case this.standardDialog.btn_ok:
               hide();
               if(this.standardDialogProperties.functionOk != null)
               {
                  this.standardDialogProperties.functionOk(null);
               }
         }
      }
      
      protected function get standardDialogProperties() : BasicStandardOkDialogProperties
      {
         return properties as BasicStandardOkDialogProperties;
      }
      
      protected function get standardDialog() : MafiaTutorial
      {
         return disp as MafiaTutorial;
      }
   }
}
