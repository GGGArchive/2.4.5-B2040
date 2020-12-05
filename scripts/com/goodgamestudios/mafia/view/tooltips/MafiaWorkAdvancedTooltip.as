package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaWorkAdvancedTooltipProperties;
   import com.goodgamestudios.stringhelper.TextFieldHelper;
   import flash.display.DisplayObject;
   
   public class MafiaWorkAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaWorkAdvancedTooltip";
       
      
      public function MafiaWorkAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override public function show() : void
      {
         super.show();
         this.advancedTooltip.txt_name.text = MafiaModel.userData.missionData.missionNameList[5];
         TextFieldHelper.changeTextFromatSizeByTextWidth(19,this.advancedTooltip.txt_copy,MafiaModel.languageData.getTextById("tt_MafiaGodfatherScreen_protectionmoney_2"));
         this.advancedTooltip.txt_cash.text = this.advancedTooltipProperties.award + " " + MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_9");
         this.advancedTooltip.txt_copy2.text = MafiaModel.languageData.getTextById("MafiaProtectionMoneyScreen_copy_11");
         if(MafiaModel.userData.profileData.isActivityGainingUnlocked)
         {
            this.advancedTooltip.txt_ap.text = "1/" + MafiaModel.languageData.getTextById("generic_hour");
         }
         else
         {
            this.advancedTooltip.txt_ap.text = "0";
         }
      }
      
      protected function get advancedTooltip() : MafiaWorkTooltip
      {
         return disp as MafiaWorkTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaWorkAdvancedTooltipProperties
      {
         return properties as MafiaWorkAdvancedTooltipProperties;
      }
   }
}
