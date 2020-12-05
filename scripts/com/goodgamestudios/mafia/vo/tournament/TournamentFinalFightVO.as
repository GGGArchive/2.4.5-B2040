package com.goodgamestudios.mafia.vo.tournament
{
   import com.goodgamestudios.mafia.constants.enums.FighterState;
   import com.goodgamestudios.mafia.vo.PlayerVO;
   
   public class TournamentFinalFightVO
   {
      
      public static const STATE_UPCOMING:String = "state_upcoming";
      
      public static const STATE_OVER:String = "state_over";
       
      
      public var state:String;
      
      public var fighter1:PlayerVO;
      
      public var fighter2:PlayerVO;
      
      public var fighterState1:FighterState;
      
      public var fighterState2:FighterState;
      
      public var fighterClanId1:int;
      
      public var fighterClanId2:int;
      
      public var fighterClanName1:String;
      
      public var fighterClanName2:String;
      
      public var avatarPicString1:String;
      
      public var avatarPicString2:String;
      
      public function TournamentFinalFightVO()
      {
         super();
      }
   }
}
