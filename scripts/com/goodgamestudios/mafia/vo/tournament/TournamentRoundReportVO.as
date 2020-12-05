package com.goodgamestudios.mafia.vo.tournament
{
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   
   public class TournamentRoundReportVO
   {
       
      
      public var fightResult:FighterState;
      
      public var nextRound:int;
      
      public var cash:int;
      
      public var xp:int;
      
      public var gold:int;
      
      public var ap:int;
      
      public var glory:int;
      
      public var opponentName:String;
      
      public var opponentID:int;
      
      public function TournamentRoundReportVO()
      {
         super();
      }
   }
}
