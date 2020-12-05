package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaSlotMachineAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaSlotMachineAdvancedTooltip";
       
      
      public function MafiaSlotMachineAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_name.text = MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_slotmachine_1");
         TextFieldHelper.changeTextFromatSizeByTextWidth(19,this.advancedTooltip.txt_copy,MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_slotmachine_2"));
      }
      
      protected function get advancedTooltip() : MafiaSlotmachineTooltip
      {
         return disp as MafiaSlotmachineTooltip;
      }
   }
}
