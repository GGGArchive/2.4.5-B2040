package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaActionPanelAvatarAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaActionPanelAvatarAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaActionPanelAvatarAdvancedTooltip";
       
      
      public function MafiaActionPanelAvatarAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.txt_lvl.text = MafiaModel.languageData.getTextById("event_lastmanstanding_winnerLevel",[this.advancedTooltipProperties.level]);
         this.advancedTooltip.txt_xp.text = MafiaModel.languageData.getTextById("generic_xp") + ": " + NumberStringHelper.groupString(this.advancedTooltipProperties.xp,MafiaModel.languageData.getTextById);
         this.advancedTooltip.txt_xpForNextLevel.text = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_XPtoLevelUp") + ": " + NumberStringHelper.groupString(this.advancedTooltipProperties.xpForNextLevel - this.advancedTooltipProperties.xp,MafiaModel.languageData.getTextById);
         this.advancedTooltip.txt_energy.text = MafiaModel.languageData.getTextById("MafiaGodfatherScreen_copy_1") + " " + this.advancedTooltipProperties.energy.toString();
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.advancedTooltip.txt_title,MafiaModel.languageData.getTextById("tt_MafiaActionPanel_btn_profile"));
         if(MafiaModel.userData.profileData.isActivityGainingUnlocked)
         {
            this.advancedTooltip.ap.visible = true;
            this.advancedTooltip.txt_ap.text = MafiaModel.languageData.getTextById("MafiaDuelScreen_copy_14") + ": " + this.advancedTooltipProperties.ap.toString();
            this.advancedTooltip.bg.height = 160;
         }
         else
         {
            this.advancedTooltip.ap.visible = false;
            this.advancedTooltip.txt_ap.text = "";
            this.advancedTooltip.bg.height = 134;
         }
      }
      
      protected function get advancedTooltip() : MafiaAvatarTooltip
      {
         return disp as MafiaAvatarTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaActionPanelAvatarAdvancedTooltipProperties
      {
         return properties as MafiaActionPanelAvatarAdvancedTooltipProperties;
      }
   }
}
