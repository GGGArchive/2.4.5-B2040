package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaBarAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaBarAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaBarAdvancedTooltip";
       
      
      public function MafiaBarAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_name.text = MafiaModel.userData.missionData.missionNameList[4];
         this.advancedTooltip.txt_copy.text = MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_barkeeper");
         TextFieldHelper.changeTextFromatSizeByTextWidth(19,this.advancedTooltip.txt_copy,MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_barkeeper"));
         this.advancedTooltip.txt_refiller.text = this.advancedTooltipProperties.refiller.toString() + " / " + this.advancedTooltipProperties.maxRefill.toString();
         this.advancedTooltip.txt_energy.text = "20";
         this.advancedTooltip.energy.gotoAndStop(2);
      }
      
      protected function get advancedTooltip() : MafiaBarTooltip
      {
         return disp as MafiaBarTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaBarAdvancedTooltipProperties
      {
         return properties as MafiaBarAdvancedTooltipProperties;
      }
   }
}
