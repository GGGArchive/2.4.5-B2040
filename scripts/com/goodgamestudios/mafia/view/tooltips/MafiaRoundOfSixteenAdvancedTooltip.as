package com.goodgamestudios.mafia.view.tooltips
{
   import com.goodgamestudios.mafia.constants.Constants_Tournament;
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import com.goodgamestudios.mafia.view.tooltips.properties.MafiaRoundOfSixteenAdvancedTooltipProperties;
   import flash.display.DisplayObject;
   
   public class MafiaRoundOfSixteenAdvancedTooltip extends MafiaAdvancedTooltip
   {
      
      public static const NAME:String = "MafiaRoundOfSixteenAdvancedTooltip";
       
      
      public function MafiaRoundOfSixteenAdvancedTooltip(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function applyProperties() : void
      {
         switch(this.advancedTooltipProperties.round)
         {
            case Constants_Tournament.RO16_ROUNDOFSIXTEEN:
               this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_22");
               break;
            case Constants_Tournament.RO16_QUARTERFINAL:
               this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_23");
               break;
            case Constants_Tournament.RO16_SEMIFINAL:
               this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_24");
               break;
            case Constants_Tournament.RO16_FINAL:
               this.advancedTooltip.txt_title.text = MafiaModel.languageData.getTextById("event_lastmanstanding_copy_25");
         }
         if(this.advancedTooltipProperties.fightVO)
         {
            switch(this.advancedTooltipProperties.fightVO.fighterState1)
            {
               case FighterState.None:
                  this.advancedTooltip.gotoAndStop(1);
                  break;
               case FighterState.Lost:
                  this.advancedTooltip.gotoAndStop(3);
                  this.fillPlayerInformation();
                  break;
               case FighterState.Won:
                  this.advancedTooltip.gotoAndStop(4);
                  this.fillPlayerInformation();
                  break;
               default:
                  this.advancedTooltip.gotoAndStop(2);
                  this.fillPlayerInformation();
            }
         }
      }
      
      private function fillPlayerInformation() : void
      {
         this.advancedTooltip.txt_name_player1.text = this.advancedTooltipProperties.fightVO.fighter1.name;
         this.advancedTooltip.txt_level_player1.text = MafiaModel.languageData.getTextById("event_lastmanstanding_winnerLevel",[this.advancedTooltipProperties.fightVO.fighter1.level]);
         this.advancedTooltip.txt_name_player2.text = this.advancedTooltipProperties.fightVO.fighter2.name;
         this.advancedTooltip.txt_level_player2.text = MafiaModel.languageData.getTextById("event_lastmanstanding_winnerLevel",[this.advancedTooltipProperties.fightVO.fighter2.level]);
      }
      
      protected function get advancedTooltip() : MafiaRoundOfSixteenTooltip
      {
         return disp as MafiaRoundOfSixteenTooltip;
      }
      
      protected function get advancedTooltipProperties() : MafiaRoundOfSixteenAdvancedTooltipProperties
      {
         return properties as MafiaRoundOfSixteenAdvancedTooltipProperties;
      }
   }
}
