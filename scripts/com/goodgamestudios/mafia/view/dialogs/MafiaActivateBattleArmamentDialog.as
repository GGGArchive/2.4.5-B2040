package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaActivateBattleArmamentDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaActivateBattleArmamentDialog extends MafiaDialog
   {
      
      public static const NAME:String = "ActivateBattleArmamentDialog";
       
      
      public function MafiaActivateBattleArmamentDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_unlock.label = this.standardDialogProperties.buttonLabel_unlock;
         this.standardDialog.btn_unlock.goldInfoVisible = true;
         this.standardDialog.btn_unlock.goldInfoTimeText = this.standardDialogProperties.unlockCost.toString();
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.txt_title.text = this.standardDialogProperties.title;
         this.standardDialog.txt_body.text = String(this.standardDialogProperties.copy);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case this.standardDialog.btn_unlock:
               hide();
               if(this.standardDialogProperties.functionUnlock != null)
               {
                  this.standardDialogProperties.functionUnlock();
               }
               break;
            case this.standardDialog.btn_close:
               hide();
               if(this.standardDialogProperties.functionClose != null)
               {
                  this.standardDialogProperties.functionClose();
               }
         }
      }
      
      protected function get standardDialogProperties() : MafiaActivateBattleArmamentDialogProperties
      {
         return properties as MafiaActivateBattleArmamentDialogProperties;
      }
      
      protected function get standardDialog() : MafiaActivateBattleArmament
      {
         return disp as MafiaActivateBattleArmament;
      }
   }
}
