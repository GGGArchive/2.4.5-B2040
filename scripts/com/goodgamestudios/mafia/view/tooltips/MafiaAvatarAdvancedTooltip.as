package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaExperienceAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   
   public class MafiaAvatarAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaAvatarAdvancedTooltip";
       
      
      public function MafiaAvatarAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("MafiaAvatarScreen_text_xp");
         this.advancedTooltip.txt_copy.text = NumberStringHelper.groupString(this.advancedTooltipProperties.xp,MafiaModel.languageData.getTextById) + "\n";
         this.advancedTooltip.txt_copy.appendText(MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_XPtoLevelUp") + " " + NumberStringHelper.groupString(this.advancedTooltipProperties.xpForNextLevel - this.advancedTooltipProperties.xp,MafiaModel.languageData.getTextById));
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
