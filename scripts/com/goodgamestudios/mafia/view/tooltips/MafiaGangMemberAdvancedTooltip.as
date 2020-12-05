package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.Constants_LayoutStates;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaGangMemberAdvancedTooltipProperties;
   import flash.display.DisplayObject;
   
   public class MafiaGangMemberAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaGangMemberAdvancedTooltip";
       
      
      public function MafiaGangMemberAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.advancedTooltip.bg.height = 159;
         this.advancedTooltip.txt_category.text = MafiaModel.languageData.getTextById("MafiaGangScreen_title");
         this.advancedTooltip.txt_name.text = MafiaModel.languageData.getTextById("MafiaGangScreen_memberName_copy_" + this.advancedTooltipProperties.gangMember.picID);
         this.advancedTooltip.txt_duration.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_2");
         this.advancedTooltip.txt_effect.text = MafiaModel.languageData.getTextById("MafiaGangScreen_copy_1");
         this.advancedTooltip.txt_effectValue.text = MafiaModel.languageData.getTextById("MafiaGangScreen_memberEffect_copy_" + this.advancedTooltipProperties.gangMember.effectType,[this.advancedTooltipProperties.gangMember.effectValue]);
         if(layoutManager.currentState == Constants_LayoutStates.STATE_OTHERPROFILE)
         {
            this.advancedTooltip.txt_duration.text = "";
            this.advancedTooltip.txt_durationValue.text = "";
            this.advancedTooltip.bg.height = 120;
         }
         else
         {
            this.advancedTooltip.txt_durationValue.text = this.advancedTooltipProperties.gangMember.remainingTime;
         }
      }
      
      protected function get advancedTooltip() : MafiaGangMemberTooltip
      {
         return disp as MafiaGangMemberTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaGangMemberAdvancedTooltipProperties
      {
         return properties as MafiaGangMemberAdvancedTooltipProperties;
      }
   }
}
