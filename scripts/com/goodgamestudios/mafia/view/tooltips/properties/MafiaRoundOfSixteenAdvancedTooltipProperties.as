package com.goodgamestudios.mafia.view.tooltips.properties
{
   import com.goodgamestudios.mafia.vo.tournament.TournamentFinalFightVO;
   
   public class MafiaRoundOfSixteenAdvancedTooltipProperties extends MafiaAdvancedTooltipProperties
   {
       
      
      public var fightVO:TournamentFinalFightVO;
      
      public var round:int;
      
      public function MafiaRoundOfSixteenAdvancedTooltipProperties(param1:TournamentFinalFightVO, param2:int)
      {
         super();
         this.fightVO = param1;
         this.round = param2;
      }
   }
}
