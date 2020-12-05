package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaClanBoosterAdvancedTooltipProperties;
   import flash.display.DisplayObject;
   
   public class MafiaClanBoosterAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaClanBoosterAdvancedTooltip";
       
      
      public function MafiaClanBoosterAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_copy.text = this.advancedTooltipProperties.copy;
         this.advancedTooltip.txt_gold.text = this.advancedTooltipProperties.gold.toString();
      }
      
      protected function get advancedTooltipProperties() : MafiaClanBoosterAdvancedTooltipProperties
      {
         return properties as MafiaClanBoosterAdvancedTooltipProperties;
      }
      
      protected function get advancedTooltip() : MafiaClanBoosterToolTip
      {
         return disp as MafiaClanBoosterToolTip;
      }
   }
}
