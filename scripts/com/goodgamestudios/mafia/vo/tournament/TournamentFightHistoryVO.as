package com.goodgamestudios.mafia.vo.tournament
{
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   
   public class TournamentFightHistoryVO
   {
       
      
      public var round:int;
      
      public var opponentID:int;
      
      public var opponentName:String;
      
      public var fightResult:FighterState;
      
      public function TournamentFightHistoryVO()
      {
         super();
      }
   }
}
