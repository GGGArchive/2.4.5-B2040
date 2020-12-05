package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaUnlockSlotDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaUnlockSlotDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaBuySlotDialog";
       
      
      public function MafiaUnlockSlotDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_yes.label = this.standardDialogProperties.buttonLabel_yes;
         this.standardDialog.btn_no.label = this.standardDialogProperties.buttonLabel_no;
      }
      
      override protected function applyProperties() : void
      {
         this.standardDialog.txt_title.text = this.standardDialogProperties.title;
         this.standardDialog.txt_copy.text = String(this.standardDialogProperties.copy);
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         super.onClick(param1);
         switch(param1.target)
         {
            case this.standardDialog.btn_yes:
               hide();
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes(this.standardDialogProperties.slotType);
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
      
      protected function get standardDialogProperties() : MafiaUnlockSlotDialogProperties
      {
         return properties as MafiaUnlockSlotDialogProperties;
      }
      
      protected function get standardDialog() : MafiaStandardYesNo
      {
         return disp as MafiaStandardYesNo;
      }
   }
}
