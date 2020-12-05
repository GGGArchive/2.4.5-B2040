package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import flash.display.DisplayObject;
   
   public class MafiaGoldAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaGoldAdvancedTooltip";
       
      
      public function MafiaGoldAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_value.text = this.advancedTooltipProperties.copy;
         this.advancedTooltip.txt_value.x = 0 - this.advancedTooltip.txt_value.textWidth * 0.5 + this.advancedTooltip.gold.width * 0.5;
         this.advancedTooltip.gold.x = this.advancedTooltip.txt_value.x - 15;
         this.advancedTooltip.bg.width = this.advancedTooltip.txt_value.textWidth + 20 + this.advancedTooltip.gold.width;
      }
      
      protected function get advancedTooltip() : MafiaGoldTooltip
      {
         return disp as MafiaGoldTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaMultiLineAdvancedTooltipProperties
      {
         return properties as MafiaMultiLineAdvancedTooltipProperties;
      }
   }
}
