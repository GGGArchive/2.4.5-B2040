package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaBoosterAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaBoosterAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaBoosterAdvancedTooltip";
       
      
      public function MafiaBoosterAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_title.text = this.advancedTooltipProperties.boosterTitle;
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.txt_copy,this.advancedTooltipProperties.boosterCopy,4);
         this.advancedTooltip.highlight.gotoAndStop(this.advancedTooltipProperties.boosterVO.boosterID);
      }
      
      protected function get advancedTooltip() : MafiaBoosterTooltip
      {
         return disp as MafiaBoosterTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaBoosterAdvancedTooltipProperties
      {
         return properties as MafiaBoosterAdvancedTooltipProperties;
      }
   }
}
