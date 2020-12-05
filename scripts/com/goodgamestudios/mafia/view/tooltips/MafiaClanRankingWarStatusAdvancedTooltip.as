package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.graphics.utils.ColorMatrix;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaClanRankingWarStatusAdvancedTooltipProperties;
   import flash.display.DisplayObject;
   
   public class MafiaClanRankingWarStatusAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaClanRankingWarStatusAdvancedTooltip";
       
      
      protected var disableButton:ColorMatrix;
      
      public function MafiaClanRankingWarStatusAdvancedTooltip(param1:DisplayObject)
      {
         this.disableButton = new ColorMatrix();
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         this.disableButton.desaturate();
         this.advancedTooltip.attack.filters = [];
         this.advancedTooltip.defend.filters = [];
         if(this.advancedTooltipProperties.attackClan != null)
         {
            this.advancedTooltip.txt_defend.text = MafiaModel.languageData.getTextById("tt_MafiaRankingScreen_familypvp",[this.advancedTooltipProperties.attackClan,this.advancedTooltipProperties.attackTime]);
         }
         else
         {
            this.advancedTooltip.txt_defend.text = "";
            this.advancedTooltip.defend.filters = [this.disableButton.filter];
         }
         if(this.advancedTooltipProperties.defendClan != null)
         {
            this.advancedTooltip.txt_attack.text = MafiaModel.languageData.getTextById("tt_MafiaRankingScreen_familypvp",[this.advancedTooltipProperties.defendClan,this.advancedTooltipProperties.defendTime]);
         }
         else
         {
            this.advancedTooltip.txt_attack.text = "";
            this.advancedTooltip.attack.filters = [this.disableButton.filter];
         }
      }
      
      protected function get advancedTooltip() : MafiaClanRankingWarStatusTooltip
      {
         return disp as MafiaClanRankingWarStatusTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaClanRankingWarStatusAdvancedTooltipProperties
      {
         return properties as MafiaClanRankingWarStatusAdvancedTooltipProperties;
      }
   }
}
