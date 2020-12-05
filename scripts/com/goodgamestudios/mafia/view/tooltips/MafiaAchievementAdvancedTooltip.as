package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaAchievementAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaAchievementAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaAchievementAdvancedTooltip";
       
      
      public function MafiaAchievementAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         _loc1_ = [this.advancedTooltipProperties.achievementLevel,NumberStringHelper.groupString(this.advancedTooltipProperties.achievementValue,MafiaModel.languageData.getTextById)];
         this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("MafiaAchievementTitle_" + this.advancedTooltipProperties.achievementId);
         TextFieldHelper.changeSingleLineTextVerticalAlignInMultiLineTextfield(this.advancedTooltip.txt_title,0.2);
         if(this.advancedTooltipProperties.achievementNextValue == 0)
         {
            _loc2_ = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_10") + " " + this.advancedTooltipProperties.achievementLevel.toString();
         }
         else if(this.advancedTooltipProperties.achievementNextValue == -1)
         {
            _loc2_ = MafiaModel.languageData.getTextById("MafiaAchievement_" + this.advancedTooltipProperties.achievementId + "_2",_loc1_);
         }
         else
         {
            if(this.advancedTooltipProperties.achievementValue == 1)
            {
               _loc1_.push(NumberStringHelper.groupString(this.advancedTooltipProperties.achievementNextValue,MafiaModel.languageData.getTextById));
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAchievement_" + this.advancedTooltipProperties.achievementId + "_1",_loc1_);
            }
            else
            {
               _loc2_ = MafiaModel.languageData.getTextById("MafiaAchievement_" + this.advancedTooltipProperties.achievementId + "_2",_loc1_);
               _loc2_ = _loc2_ + (" " + MafiaModel.languageData.getTextById("MafiaAchievement_" + this.advancedTooltipProperties.achievementId + "_3",[NumberStringHelper.groupString(this.advancedTooltipProperties.achievementNextValue,MafiaModel.languageData.getTextById)]));
            }
            if(MafiaModel.userData.emailVerified && env.invitefriends && this.advancedTooltipProperties.achievementId == 8)
            {
               _loc2_ = _loc2_ + ("\n" + MafiaModel.languageData.getTextById("MafiaAchievement_8_4",[Number(Constants_Basic.FRIENDS_WORK_BONUS * this.advancedTooltipProperties.achievementLevel) + "%"]));
            }
         }
         this.advancedTooltip.txt_copy.text = _loc2_;
         this.advancedTooltip.bg.height = 60 + this.advancedTooltip.txt_copy.numLines * 15.5;
         this.advancedTooltip.txt_copy.height = this.advancedTooltip.txt_copy.numLines * 21;
      }
      
      protected function get advancedTooltip() : MafiaAchievementTooltip
      {
         return disp as MafiaAchievementTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaAchievementAdvancedTooltipProperties
      {
         return properties as MafiaAchievementAdvancedTooltipProperties;
      }
   }
}
