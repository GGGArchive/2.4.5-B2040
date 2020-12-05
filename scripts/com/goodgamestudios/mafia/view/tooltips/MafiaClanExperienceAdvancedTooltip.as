package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaExperienceAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   
   public class MafiaClanExperienceAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaClanExperienceAdvancedTooltip";
       
      
      public function MafiaClanExperienceAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.bg.height = 92;
         this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_xp");
         this.advancedTooltip.txt_copy.text = NumberStringHelper.groupString(this.advancedTooltipProperties.xp,MafiaModel.languageData.getTextById) + "\n";
         if(this.advancedTooltipProperties.xp < this.advancedTooltipProperties.xpForNextLevel)
         {
            this.advancedTooltip.txt_copy.appendText(MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_XPtoLevelUp") + " " + NumberStringHelper.groupString(this.advancedTooltipProperties.xpForNextLevel - this.advancedTooltipProperties.xp,MafiaModel.languageData.getTextById));
         }
         else
         {
            this.advancedTooltip.bg.height = 70;
         }
      }
      
      protected function get advancedTooltip() : MafiaExperienceTooltip
      {
         return disp as MafiaExperienceTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaExperienceAdvancedTooltipProperties
      {
         return properties as MafiaExperienceAdvancedTooltipProperties;
      }
   }
}
