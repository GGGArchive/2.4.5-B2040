package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaClanLevelUpDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaClanLevelUpDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaClanLevelUpDialog";
       
      
      public function MafiaClanLevelUpDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_ok.label = this.standardDialogProperties.buttonLabel_ok;
         this.standardDialog.btn_no.label = this.standardDialogProperties.buttonLabel_no;
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.txt_title.text = this.standardDialogProperties.title;
         this.standardDialog.txt_copy.text = this.standardDialogProperties.copy;
         if(!env.enableFeedMessages)
         {
            this.standardDialog.btn_ok.visible = false;
         }
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_ok:
               hide();
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes(null);
               }
               break;
            case this.standardDialog.btn_no:
               hide();
               if(this.standardDialogProperties.functionNo != null)
               {
                  this.standardDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get standardDialogProperties() : MafiaClanLevelUpDialogProperties
      {
         return properties as MafiaClanLevelUpDialogProperties;
      }
      
      protected function get standardDialog() : MafiaClanLevelUp
      {
         return disp as MafiaClanLevelUp;
      }
   }
}
