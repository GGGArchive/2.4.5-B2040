package com.goodgamestudios.mafia.vo.tournament
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.constants.enums.PlayerTournamentStatus;
   
   public class TournamentRemainingPlayerVO
   {
      
      public static const LAST_SIXTEEN:int = -4;
      
      public static const QUARTER_FINAL:int = -3;
      
      public static const SEMI_FINAL:int = -2;
      
      public static const FINAL:int = -1;
       
      
      public var playerID:int;
      
      public var name:String;
      
      public var level:int;
      
      public var characterClass:CharacterClass;
      
      public var clanID:int;
      
      public var clanName:String;
      
      public var playerTournamentStatus:PlayerTournamentStatus;
      
      public var playerReachedRound:int;
      
      public function TournamentRemainingPlayerVO()
      {
         super();
      }
   }
}
