package com.goodgamestudios.mafia.view.dialogs
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.dialogs.properties.MafiaFullInventoryDialogProperties;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class MafiaFullInventoryDialog extends MafiaDialog
   {
      
      public static const NAME:String = "MafiaFullInventoryDialog";
       
      
      public function MafiaFullInventoryDialog(param1:Sprite)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.standardDialog.btn_fight.label = MafiaModel.languageData.getTextById("generic_btn_continue");
         this.standardDialog.btn_sell.label = MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_blackmarket");
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
            case this.standardDialog.btn_fight:
               hide();
               if(this.standardDialogProperties.functionYes != null)
               {
                  this.standardDialogProperties.functionYes(this.standardDialogProperties.missionId);
               }
               break;
            case this.standardDialog.btn_close:
               hide();
               break;
            case this.standardDialog.btn_sell:
               hide();
               if(this.standardDialogProperties.functionNo != null)
               {
                  this.standardDialogProperties.functionNo(null);
               }
         }
      }
      
      protected function get standardDialogProperties() : MafiaFullInventoryDialogProperties
      {
         return properties as MafiaFullInventoryDialogProperties;
      }
      
      protected function get standardDialog() : MafiaFullInventory
      {
         return disp as MafiaFullInventory;
      }
   }
}
