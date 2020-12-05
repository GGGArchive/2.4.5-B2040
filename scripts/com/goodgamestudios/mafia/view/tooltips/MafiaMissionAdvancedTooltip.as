package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.model.components.MafiaItemData;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaMissionAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class MafiaMissionAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaMissionAdvancedTooltip";
       
      
      public function MafiaMissionAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:MovieClip = null;
         this.advancedTooltip.energy.gotoAndStop(3);
         this.advancedTooltip.txt_time.text = String(Math.round(this.advancedTooltipProperties.missionVO.time / 60 * 10) / 10);
         this.advancedTooltip.txt_xp.text = NumberStringHelper.groupString(this.advancedTooltipProperties.missionVO.xp,MafiaModel.languageData.getTextById);
         this.advancedTooltip.txt_cash.text = NumberStringHelper.groupString(this.advancedTooltipProperties.missionVO.c1,MafiaModel.languageData.getTextById);
         TextFieldHelper.changeTextFromatSizeByTextWidth(12,this.advancedTooltip.txt_name,this.advancedTooltipProperties.missionVO.name);
         TextFieldHelper.changeTextFromatSizeByTextWidth(19,this.advancedTooltip.txt_copy,MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_quest"));
         while(this.advancedTooltip.missionItemContainer.numChildren > 1)
         {
            this.advancedTooltip.missionItemContainer.removeChildAt(1);
         }
         this.advancedTooltip.bg.height = 220;
         this.advancedTooltip.missionItemContainer.y = 255;
         if(MafiaModel.userData.profileData.isActivityGainingUnlocked)
         {
            this.advancedTooltip.missionActivity.visible = true;
            this.advancedTooltip.missionActivity.txt_ap.text = this.advancedTooltipProperties.missionVO.ap;
            this.advancedTooltip.ClassIcon.y = 200;
            this.advancedTooltip.Line.y = 215;
         }
         else
         {
            this.advancedTooltip.missionActivity.visible = false;
            this.advancedTooltip.bg.height = this.advancedTooltip.bg.height - this.advancedTooltip.missionActivity.height;
            this.advancedTooltip.missionItemContainer.y = this.advancedTooltip.missionItemContainer.y - this.advancedTooltip.missionActivity.height;
            this.advancedTooltip.ClassIcon.y = 170;
            this.advancedTooltip.Line.y = 185;
         }
         if(this.advancedTooltipProperties.missionVO.item != null)
         {
            _loc1_ = MafiaItemData.getInstance().generateItemIcon(this.advancedTooltipProperties.missionVO.item);
            this.advancedTooltip.missionItemContainer.addChild(_loc1_);
            this.advancedTooltip.missionItemContainer.visible = true;
            this.advancedTooltip.bg.height = this.advancedTooltip.bg.height + 79;
         }
         else
         {
            this.advancedTooltip.missionItemContainer.visible = false;
         }
         if(this.advancedTooltipProperties.missionVO.cIcon == CharacterClass.Bully)
         {
            this.advancedTooltip.ClassIcon.gotoAndStop(1);
         }
         else if(this.advancedTooltipProperties.missionVO.cIcon == CharacterClass.Rogue)
         {
            this.advancedTooltip.ClassIcon.gotoAndStop(2);
         }
         else if(this.advancedTooltipProperties.missionVO.cIcon == CharacterClass.Tactician)
         {
            this.advancedTooltip.ClassIcon.gotoAndStop(3);
         }
      }
      
      protected function get advancedTooltip() : MafiaMissionTooltip
      {
         return disp as MafiaMissionTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaMissionAdvancedTooltipProperties
      {
         return properties as MafiaMissionAdvancedTooltipProperties;
      }
   }
}
