package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.basic.view.dialogs.BasicStandardOkDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaNoCashDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaNoCashDialog";
       
      
      public function MafiaNoCashDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_ok.label = this.standardDialogProperties.buttonLabel_ok;
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.txt_title.text = this.standardDialogProperties.title;
         this.standardDialog.txt_copy.text = this.standardDialogProperties.copy;
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
      
      protected function get standardDialog() : MafiaNoCash
      {
         return disp as MafiaNoCash;
      }
   }
}
