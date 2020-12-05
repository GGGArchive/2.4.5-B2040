package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.enums.CityFightProgress;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaCityQuestBonusTooltipProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaCityQuestBonusTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaCityQuestBonusTooltip";
       
      
      public function MafiaCityQuestBonusTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc1_:String = MafiaModel.languageData.getTextById("MafiaGangwarfare_" + MafiaModel.userData.profileData.city.index + "_Family_" + int(this.advancedTooltipProperties.gangwarVO.district_id + 1).toString());
         TextFieldHelper.changeTextFromatSizeByTextWidth(14,this.advancedTooltip.txt_title,MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_bonusDistrict") + " " + (this.advancedTooltipProperties.gangwarVO.district_id + 1),1);
         this.advancedTooltip.txt_family.text = MafiaModel.languageData.getTextById("MafiaGangwarfare_copy_1",[_loc1_]);
         this.advancedTooltip.txt_copy.text = "";
         switch(this.advancedTooltipProperties.gangwarVO.cityFightProgress)
         {
            case CityFightProgress.FightUnavailable:
               break;
            case CityFightProgress.FightAvailable:
               _loc2_ = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_enemy");
               _loc3_ = MafiaModel.languageData.getTextById("tt_MafiaAvatarScreen_classicon" + this.advancedTooltipProperties.gangwarVO.cityFighterClass.index);
               _loc4_ = this.advancedTooltipProperties.gangwarVO.cityFighterLevel.toString();
               _loc5_ = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_12");
               this.advancedTooltip.txt_copy.text = _loc2_ + "\n" + _loc5_ + " " + _loc4_ + "\n" + _loc3_;
               break;
            case CityFightProgress.FightWon:
               this.advancedTooltip.txt_copy.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_reward");
               break;
            case CityFightProgress.Reward_taken:
               this.advancedTooltip.txt_copy.text = MafiaModel.languageData.getTextById("tt_MafiaGangwarfare_success");
         }
      }
      
      protected function get advancedTooltipProperties() : MafiaCityQuestBonusTooltipProperties
      {
         return properties as MafiaCityQuestBonusTooltipProperties;
      }
      
      protected function get advancedTooltip() : MafiaBonusDistrictTooltip
      {
         return disp as MafiaBonusDistrictTooltip;
      }
   }
}
