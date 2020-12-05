package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import flash.display.DisplayObject;
   
   public class MafiaArrowMultiLineAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaArrowMultiLineAdvancedTooltip";
       
      
      public function MafiaArrowMultiLineAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_copy.y = -47;
         this.advancedTooltip.bg.height = 37;
         this.advancedTooltip.bg.y = -50;
         this.advancedTooltip.txt_copy.text = this.advancedTooltipProperties.copy;
         this.advancedTooltip.txt_copy.height = this.advancedTooltip.txt_copy.numLines * 20;
         if(this.advancedTooltip.txt_copy.numLines == 1)
         {
            this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + 2;
            this.advancedTooltip.txt_copy.y = this.advancedTooltip.txt_copy.y - 3;
         }
         if(this.advancedTooltip.txt_copy.numLines > 1)
         {
            this.advancedTooltip.bg.height = this.advancedTooltip.txt_copy.numLines * (!!BasicLanguageFontManager.getInstance().useDefaultFont?14:17) + 8;
            this.advancedTooltip.txt_copy.y = 0 - (this.advancedTooltip.bg.height - 3);
         }
         this.advancedTooltip.bg.y = 0 - this.advancedTooltip.bg.height;
      }
      
      protected function get advancedTooltip() : MafiaArrowMultiLineTooltip
      {
         return disp as MafiaArrowMultiLineTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaMultiLineAdvancedTooltipProperties
      {
         return properties as MafiaMultiLineAdvancedTooltipProperties;
      }
   }
}
