package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMultiLineAdvancedTooltipProperties;
   import flash.display.DisplayObject;
   
   public class MafiaMultiLineAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaMultiLineAdvancedTooltip";
       
      
      public function MafiaMultiLineAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_copy.y = 9.5;
         this.advancedTooltip.bg.height = 30;
         this.advancedTooltip.txt_copy.text = this.advancedTooltipProperties.copy;
         this.advancedTooltip.txt_copy.height = this.advancedTooltip.txt_copy.numLines * 21.5;
         if(this.advancedTooltip.txt_copy.numLines == 1)
         {
            this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + 2;
            this.advancedTooltip.txt_copy.y = this.advancedTooltip.txt_copy.y - 3;
         }
         if(this.advancedTooltip.txt_copy.numLines > 1)
         {
            this.advancedTooltip.txt_copy.y = this.advancedTooltip.bg.y - this.advancedTooltip.txt_copy.height - (!!BasicLanguageFontManager.getInstance().useDefaultFont?0:this.advancedTooltip.txt_copy.numLines * 2);
            this.advancedTooltip.bg.height = this.advancedTooltip.txt_copy.numLines * (!!BasicLanguageFontManager.getInstance().useDefaultFont?23.5:26);
            this.advancedTooltip.txt_copy.height = this.advancedTooltip.txt_copy.height + 22;
         }
      }
      
      protected function get advancedTooltip() : MafiaMultiLineTooltip
      {
         return disp as MafiaMultiLineTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaMultiLineAdvancedTooltipProperties
      {
         return properties as MafiaMultiLineAdvancedTooltipProperties;
      }
   }
}
