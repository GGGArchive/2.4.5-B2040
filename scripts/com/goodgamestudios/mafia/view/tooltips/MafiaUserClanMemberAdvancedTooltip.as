package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaUserClanMemberAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.NumberStringHelper;
   import flash.display.DisplayObject;
   
   public class MafiaUserClanMemberAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaUserClanMemberAdvancedTooltip";
       
      
      public function MafiaUserClanMemberAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         var _loc1_:String = null;
         _loc1_ = MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_15") + " " + this.advancedTooltipProperties.member.donatedGold.toString();
         _loc1_ = _loc1_ + ("\n" + MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_16") + " " + NumberStringHelper.groupString(this.advancedTooltipProperties.member.activityPointsYesterday,MafiaModel.languageData.getTextById));
         _loc1_ = _loc1_ + ("\n" + MafiaModel.languageData.getTextById("MafiaFamilyScreen_text_17") + " " + NumberStringHelper.groupString(this.advancedTooltipProperties.member.activityPoints,MafiaModel.languageData.getTextById));
         this.advancedTooltip.txt_copy.text = _loc1_;
         var _loc2_:String = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_iconrank" + NumberStringHelper.groupString(this.advancedTooltipProperties.member.rankInClan.index,MafiaModel.languageData.getTextById));
         this.advancedTooltip.txt_title.text = _loc2_;
         if(this.advancedTooltipProperties.member.isOnline)
         {
            this.advancedTooltip.txt_online.text = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_online");
            this.advancedTooltip.txt_online.textColor = 7057715;
         }
         else
         {
            this.advancedTooltip.txt_online.text = MafiaModel.languageData.getTextById("tt_MafiaFamilyScreen_btn_offline");
            this.advancedTooltip.txt_online.textColor = 15356484;
         }
      }
      
      protected function get advancedTooltip() : MafiaUserClanMemberTooltip
      {
         return disp as MafiaUserClanMemberTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaUserClanMemberAdvancedTooltipProperties
      {
         return properties as MafiaUserClanMemberAdvancedTooltipProperties;
      }
   }
}
